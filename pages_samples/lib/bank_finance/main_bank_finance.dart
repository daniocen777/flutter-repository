import 'package:flutter/material.dart';
import 'package:pages_samples/bank_finance/pages/sign_up_page.dart';
import 'package:pages_samples/bank_finance/utils/colors.dart';
import 'package:pages_samples/bank_finance/utils/responsive.dart';

class MainBankFinancePage extends StatelessWidget {
  const MainBankFinancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpPage()),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Bankee',
                    style: TextStyle(
                      fontSize: responsive.ip(8.5),
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                Text('Bank, Finance Kit',
                    style: TextStyle(
                      fontSize: responsive.ip(2.0),
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
