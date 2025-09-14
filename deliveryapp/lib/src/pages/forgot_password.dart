import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../widgets/back_button.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Builder(
          builder: (BuildContext context) {
            return backButton(context, Colors.black);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text(
                "Forgot Password",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Please, enter you email address. You will receive a link to create a new password via email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                  ),
                ),
              ),
              _emailInput(),
              _sendButton(context),
            ],
          ),
        ),
      ),
    );
  }
}

// Form
Widget _emailInput() {
  return Container(
    padding: EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30.0),
      color: bgInputs,
    ),
    child: TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Your email",
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    ),
  );
}

Widget _sendButton(BuildContext context) {
  return Container(
    width: 350.0,
    height: 45.0,
    margin: EdgeInsets.only(top: 30.0),
    child: ElevatedButton(
      onPressed: () => _showAlert(context),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Theme.of(context).focusColor,
        elevation: 0.5,
      ),
      child: Text(
        'Send',
        style: TextStyle(fontSize: 15.0, color: Colors.white),
      ),
    ),
  );
}

void _showAlert(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: SizedBox(
          height: 400.0,
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/lock.png'),
                width: 130.0,
                height: 130.0,
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Your password has been reset",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "You'll shortly receive an email with a code to setup a new password.",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                  ),
                ),
              ),
              _doneButton(context),
            ],
          ),
        ),
      );
    },
  );
}

Widget _doneButton(BuildContext context) {
  return Container(
    width: 350.0,
    height: 45.0,
    margin: EdgeInsets.only(top: 30.0),
    child: ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, "login"),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Theme.of(context).focusColor,
        elevation: 0.5,
      ),
      child: Text(
        'Done',
        style: TextStyle(fontSize: 15.0, color: Colors.white),
      ),
    ),
  );
}
