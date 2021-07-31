import 'package:flutter/material.dart';
import 'package:pages_samples/bank_finance/utils/colors.dart';
import 'package:pages_samples/bank_finance/utils/responsive.dart';

import 'package:pages_samples/bank_finance/witgets/text_input.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _checked = true;
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);
    return Theme(
        data: ThemeData.light(),
        child: Scaffold(
            body: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 40.0,
                                    ),
                                    Text('Welcome!',
                                        style: TextStyle(
                                            fontSize: responsive.ip(5.0),
                                            fontWeight: FontWeight.w700)),
                                    SizedBox(height: 20.0),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('Please, provide following',
                                              style: TextStyle(
                                                fontSize: responsive.ip(2.0),
                                              )),
                                          Text('details for your new account',
                                              style: TextStyle(fontSize: 15))
                                        ]),
                                    SizedBox(height: 40.0),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 30.0, horizontal: 25.0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth: 330.0,
                                                      minHeight: 200.0),
                                                  child: Form(
                                                      child: Column(children: [
                                                    Container(
                                                        decoration: BoxDecoration(
                                                            color: primaryColor
                                                                .withOpacity(
                                                                    0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                        child: TextInput(
                                                            labelText:
                                                                'Full Name',
                                                            onFieldSubmitted:
                                                                (String text) {
                                                              print(
                                                                  'Full Name');
                                                            })),
                                                    SizedBox(height: 5.0),
                                                    TextInput(
                                                        labelText:
                                                            'Email Address',
                                                        onFieldSubmitted:
                                                            (String text) {
                                                          print('Email');
                                                        }),
                                                    SizedBox(height: 5.0),
                                                    TextInput(
                                                        labelText: 'Password',
                                                        obscureText: true,
                                                        onFieldSubmitted:
                                                            (String text) {
                                                          print('Password');
                                                        }),
                                                    SizedBox(height: 20.0),
                                                    /* CheckboxListTile(
                                      title: Text(
                                          'By creating your account yo have to agree with our Tearns and Conditions'),
                                          controlAffinity: ListTileControlAffinity.leading,
                                      value: _checked,
                                      onChanged: (bool value) {
                                        print('VALOR => $value');
                                        setState(() {
                                          _checked = value;
                                        });
                                      },
                                      activeColor:
                                          primaryColor.withOpacity(0.2),
                                    ) */
                                                    Checkbox(
                                                        value: _checked,
                                                        onChanged:
                                                            (bool? value) {
                                                          print(
                                                              'VALOR => $value');
                                                          setState(() {
                                                            _checked = value!;
                                                          });
                                                        })
                                                  ])))
                                            ]))
                                  ])))
                    ]))));
  }
}
