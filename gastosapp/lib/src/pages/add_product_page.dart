import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastosapp/src/blocs/product/product_bloc.dart';
import 'package:gastosapp/src/models/product.dart';
import 'package:gastosapp/src/widgets/custom_form_field.dart';
import 'package:gastosapp/src/widgets/myButton_widget.dart';
import 'package:websafe_svg/websafe_svg.dart';

class AddProductPage extends StatefulWidget {
  static final String routename = 'register';
  AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  FocusNode _focusNodeName = FocusNode();
  String _name = '';
  double _price = 0.0;
  GlobalKey<FormState> _formKey = GlobalKey();

  String? _validateName(String? name) {
    if (name!.isNotEmpty) {
      _name = name;
      return null;
    } else {
      return 'Debes escribir el producto';
    }
  }

  String? _validatePrice(String? price) {
    if (price!.isEmpty) {
      price = '0';
    }
    double p = double.parse(price);

    if (p > 0) {
      _price = p;
      return null;
    } else {
      return 'No te van a regalar producto';
    }
  }

  @override
  Widget build(BuildContext context) {
    final _productBloc = BlocProvider.of<ProductBloc>(context);

    void _submit() {
      final bool isValid = _formKey.currentState!.validate();

      if (isValid) {
        final product = Product(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: _name.toUpperCase().trim(),
            price: _price,
            createAt: DateTime.now());
        _productBloc.add(AddProductEvent(product: product));
        setState(() {
          _name = '';
          _price = 0;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nuevo Producto',
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: IconThemeData(
          color: Colors.black87, //change your color here
        ),
        backgroundColor: Colors.amber,
      ),
      body: BlocProvider.value(
        value: _productBloc,
        child: SafeArea(
            child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 50.0, bottom: 10.0),
                          child: Text(
                            "Nuevo Producto",
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Colors.transparent,
                          child: WebsafeSvg.asset('assets/icons/box.svg',
                              color: Colors.black54,
                              width: 100.0,
                              height: 100.0),
                        )
                      ],
                    ),
                    ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: 330.0, minHeight: 200.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 40.0,
                              ),
                              CustomTextFormField(
                                iconPath: 'assets/icons/box.svg',
                                labelText: 'Nombre del producto',
                                validator: _validateName,
                                focusNode: _focusNodeName,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              CustomTextFormField(
                                iconPath: 'assets/icons/dollar.svg',
                                textInputType: TextInputType.number,
                                labelText: 'Precio',
                                validator: _validatePrice,
                              ),
                              SizedBox(
                                height: 35.0,
                              ),
                              BlocBuilder<ProductBloc, ProductState>(
                                builder: (BuildContext context, state) {
                                  if (state.loading!) {
                                    Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return MyButton(
                                    label: 'Guardar Producto',
                                    fullWidth: true,
                                    onPressed: _submit,
                                  );
                                },
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
