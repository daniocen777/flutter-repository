import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:pages_samples/nike_shoes_store/models/nike_shoes.dart';
import 'package:pages_samples/nike_shoes_store/nike_shoes_details.dart';

/* 21 */

class MainNikeShoesStore extends StatelessWidget {
  const MainNikeShoesStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    // Para las notificaciones para ir a la otroa página y ocultar la barra
    ValueNotifier<bool> notifierBottonbarVisible = ValueNotifier(true);

    void _onShoesPressed(NikeShoes shoesItem, BuildContext context) async {
      notifierBottonbarVisible.value = false;
      await Navigator.of(context).push(PageRouteBuilder(pageBuilder:
          (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
        return FadeTransition(
            opacity: animation,
            child: SingleChildScrollView(
                child: Container(
                    height: _size.height,
                    child: NikeShoesDetails(nikeShoes: shoesItem))));
      }));
      notifierBottonbarVisible.value = true;
    }

    return Theme(
        data: ThemeData.light(),
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(children: [
              Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SvgPicture.asset('assets/shoes/logo1.svg',
                            width: _size.width * 0.2,
                            height: _size.height * 0.1),
                        Expanded(
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                padding: const EdgeInsets.only(bottom: 20.0),
                                itemCount: shoes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final NikeShoes shoesItem = shoes[index];
                                  return _NikeShoesItem(
                                      nikeShoes: shoesItem,
                                      onTap: () {
                                        _onShoesPressed(shoesItem, context);
                                      });
                                }))
                      ])),
              ValueListenableBuilder<bool>(
                  valueListenable: notifierBottonbarVisible,
                  child: Container(
                      color: Colors.white.withOpacity(0.7),
                      child: Row(children: [
                        Expanded(child: Icon(Icons.home)),
                        Expanded(child: Icon(Icons.search)),
                        Expanded(child: Icon(Icons.favorite_border)),
                        Expanded(child: Icon(Icons.shopping_cart)),
                        Expanded(child: Icon(Icons.supervised_user_circle))
                      ])),
                  builder: (context, value, child) {
                    return AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        bottom: value ? 0.0 : -kToolbarHeight,
                        left: 0.0,
                        right: 0.0,
                        height: kToolbarHeight,
                        child: child!);
                  })
            ])));
  }
}

class _NikeShoesItem extends StatelessWidget {
  final NikeShoes? nikeShoes;
  final VoidCallback? onTap;

  const _NikeShoesItem({Key? key, this.nikeShoes, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 290.0;
    return InkWell(
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: SizedBox(
                height: itemHeight,
                child: Stack(fit: StackFit.expand, children: [
                  // Posicionar en toda la pantalla
                  Positioned.fill(
                      child: Hero(
                          tag: 'background_${nikeShoes!.model}',
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color(nikeShoes!.color!),
                                  borderRadius: BorderRadius.circular(15.0))))),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Hero(
                          tag: 'number_${nikeShoes!.model}',
                          child: SizedBox(
                              height: itemHeight * 0.70,
                              child: Material(
                                  color: Colors.transparent,
                                  child: FittedBox(
                                      child: Text(
                                          nikeShoes!.modelNumber.toString(),
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.05),
                                              fontWeight:
                                                  FontWeight.bold))))))),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Hero(
                          tag: 'image_${nikeShoes!.model}',
                          child: Image.asset(nikeShoes!.images!.first,
                              fit: BoxFit.contain, height: itemHeight * 0.60))),
                  Positioned(
                      bottom: 20.0,
                      left: 20.0,
                      child: Icon(Icons.favorite_border, color: Colors.grey)),
                  Positioned(
                      bottom: 20.0,
                      right: 20.0,
                      child: Icon(Icons.shopping_cart, color: Colors.grey)),
                  Positioned(
                      bottom: 25.0,
                      left: 0.0,
                      right: 0.0,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(nikeShoes!.model!,
                                style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 10.0),
                            Text('\$${nikeShoes!.oldPrice!.toInt().toString()}',
                                style: TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough)),
                            const SizedBox(height: 5.0),
                            Text(
                                '\$${nikeShoes!.currentPrice!.toInt().toString()}',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0))
                          ]))
                ]))));
  }
}
