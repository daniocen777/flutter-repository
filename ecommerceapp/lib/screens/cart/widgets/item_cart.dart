import 'package:ecommerceapp/consts/my_icons.dart';
import 'package:ecommerceapp/providers/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemCart extends StatelessWidget {
  const ItemCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Container(
      height: 155.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0),
          ),
          color: Theme.of(context).backgroundColor),
      child: Row(
        children: [
          Container(
            width: 130.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/emptycart.png'),
                  fit: BoxFit.contain),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                        'Título',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15.0),
                      )),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32.0),
                          child: Container(
                              width: 50.0,
                              height: 50.0,
                              child: Center(child: MyAppIcons.delete)),
                          onTap: () => print('DELETE'),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text('Price:'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '450\$',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Sub Total:'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '450\$',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: themeChange.darkTheme
                                ? Colors.brown.shade900
                                : Theme.of(context).accentColor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Ships Free',
                        style: TextStyle(
                            color: themeChange.darkTheme
                                ? Colors.brown.shade900
                                : Theme.of(context).primaryColor),
                      ),
                      Spacer(),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4.0),
                          // splashColor: ,
                          onTap: () {},
                          child: Container(
                            child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: MyAppIcons.minus),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 12,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '154',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4.0),
                          // splashColor: ,
                          onTap: () {},
                          child: Container(
                            child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: MyAppIcons.plus),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
