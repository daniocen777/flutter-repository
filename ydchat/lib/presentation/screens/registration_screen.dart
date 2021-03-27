import 'package:flutter/material.dart';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ydchat/presentation/bloc/auth/auth_cubit.dart';
import 'package:ydchat/presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'package:ydchat/presentation/pages/phone_verification_page.dart';
import 'package:ydchat/presentation/pages/set_initial_profile.dart';
import 'package:ydchat/presentation/screens/home_screen.dart';

import '../widgets/theme/theme.dart';

class RegistrationScreen extends StatefulWidget {
  static final String route = 'registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  static Country _selectedFilteredDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode('51');
  String _countryCode = _selectedFilteredDialogCountry.phoneCode;
  String _phoneNumber = '';

  TextEditingController _phoneAuthController = TextEditingController();

  @override
  void dispose() {
    _phoneAuthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
      listener: (context, state) {
        if (state is PhoneAuthSuccess) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }

        if (state is PhoneAuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red[400],
              content: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Error, coloca buien el código'),
                    Icon(Icons.error_outline)
                  ],
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is PhoneAuthSmsCodeReceived) {
          return PhoneVerificationPage(phoneNumber: _phoneNumber);
        }

        if (state is PhoneAuthProfileInfo) {
          return SetInitialProfilePage(
            phoneNumber: _phoneNumber,
          );
        }

        if (state is PhoneAuthLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is PhoneAuthSuccess) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (BuildContext context, state) {
              if (state is Authenticated) {
                return HomeScreen(
                  uid: state.uid,
                );
              }
              return Container();
            },
          );
        }

        return this._bodyWidget();
      },
    ));
  }

  Widget _bodyWidget() {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Verifica tu número de celular',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: primaryColor,
                      fontWeight: FontWeight.w500)),
              FaIcon(FontAwesomeIcons.ellipsisV),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          ListTile(
            onTap: _openFilteredCountryPickerDialig,
            title: _buildDialogItem(_selectedFilteredDialogCountry),
          ),
          Row(
            children: [
              Container(
                  width: 80.0,
                  height: 42.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.5, color: primaryColor))),
                  child: Text(
                    '${_selectedFilteredDialogCountry.phoneCode}',
                  )),
              SizedBox(width: 8.0),
              Expanded(
                child: Container(
                  height: 40.0,
                  child: TextField(
                    controller: _phoneAuthController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Número de celular'),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                color: primaryColorDark,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text('Siguiente',
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
                onPressed: this._submitVerifyPhoneNumber,
              ),
            ),
          )
        ],
      ),
    ));
  }

  _openFilteredCountryPickerDialig() {
    showDialog(
        context: context,
        builder: (BuildContext context) => Theme(
              data: Theme.of(context).copyWith(primaryColor: primaryColor),
              child: CountryPickerDialog(
                titlePadding: EdgeInsets.all(8.0),
                searchCursorColor: Colors.black87,
                isSearchable: true,
                searchInputDecoration: InputDecoration(hintText: 'Buscar...'),
                title: Text('Selecciona el código de tu país'),
                onValuePicked: (Country country) {
                  setState(() {
                    _selectedFilteredDialogCountry = country;
                    _countryCode = country.phoneCode;
                  });
                  print(_countryCode);
                },
                itemBuilder: _buildDialogItem,
              ),
            ));
  }

  Widget _buildDialogItem(Country country) {
    return Container(
      height: 50.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: primaryColor, width: 1.0))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(height: 8.0),
          Text('+${country.phoneCode}'),
          SizedBox(height: 8.0),
          Expanded(
            child: Text(
              '${country.name}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Spacer(),
          FaIcon(FontAwesomeIcons.angleDown),
        ],
      ),
    );
  }

  void _submitVerifyPhoneNumber() {
    if (_phoneAuthController.text.isNotEmpty) {
      _phoneNumber = '+$_countryCode${_phoneAuthController.text}';
      print('NÚMERO QUE SE REGISTRA: $_phoneNumber');
      BlocProvider.of<PhoneAuthCubit>(context)
          .submitVerifyPhoneNumber(_phoneNumber);
    }
  }
}
