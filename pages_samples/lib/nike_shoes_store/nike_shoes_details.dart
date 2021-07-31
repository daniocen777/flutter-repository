import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pages_samples/nike_shoes_store/models/nike_shoes.dart';
import 'package:pages_samples/nike_shoes_store/widgets/shoes_size_item.dart';

class NikeShoesDetails extends StatelessWidget {
  final NikeShoes? nikeShoes;
  // Para las notificaciones para ir a la otroa página y ocultar la barra
  final ValueNotifier<bool> notifierButtonsVisible = ValueNotifier(false);

  NikeShoesDetails({Key? key, @required this.nikeShoes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      notifierButtonsVisible.value = true;
    });

    Widget _buildCarousel(BuildContext context) {
      return SizedBox(
          height: _size.height * 0.50,
          child: Stack(children: [
            Positioned.fill(
                child: Hero(
                    tag: 'background_${nikeShoes!.model}',
                    child: Container(color: Color(nikeShoes!.color!)))),
            Positioned(
                left: 70.0,
                right: 70.0,
                top: 10.0,
                child: Hero(
                    tag: 'number_${nikeShoes!.model}',
                    child: Material(
                        color: Colors.transparent,
                        child: FittedBox(
                            child: Text(nikeShoes!.modelNumber.toString(),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.05),
                                    fontWeight: FontWeight.bold)))))),
            PageView.builder(
                itemCount: nikeShoes!.images!.length,
                itemBuilder: (BuildContext context, int index) {
                  final String tag = (index == 0)
                      ? 'image_${nikeShoes!.model}'
                      : 'image_${nikeShoes!.model}_$index';
                  return Container(
                      alignment: Alignment.center,
                      child: Hero(
                          tag: tag,
                          child: Image.asset(nikeShoes!.images![index],
                              height: _size.height * 0.30,
                              width: _size.width * 0.30)));
                })
          ]));
    }

    Widget _buildDescription() {
      return Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(nikeShoes!.model!,
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0)),
              const Spacer(),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                    Text('\$${nikeShoes!.oldPrice!.toInt().toString()}',
                        style: TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12.0)),
                    Text('\$${nikeShoes!.currentPrice!.toInt().toString()}',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0))
                  ]))
            ]),
            const SizedBox(height: 20.0),
            Text('AVAILABLE SIZES', style: TextStyle(fontSize: 11.0)),
            const SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              ShoesSizeItem(text: '4'),
              ShoesSizeItem(text: '6'),
              ShoesSizeItem(text: '7'),
              ShoesSizeItem(text: '8'),
              ShoesSizeItem(text: '9'),
              ShoesSizeItem(text: '11')
            ]),
            const SizedBox(height: 20.0),
            Text('DESCRIPTION', style: TextStyle(fontSize: 11.0)),
          ]));
    }

    return Theme(
        data: ThemeData.light(),
        child: Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: BackButton(color: Colors.black87),
                centerTitle: true,
                title: SvgPicture.asset('assets/shoes/logo1.svg',
                    width: _size.width * 0.2, height: _size.height * 0.1)),
            body: Stack(fit: StackFit.expand, children: [
              Positioned.fill(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                    _buildCarousel(context),
                    _buildDescription()
                  ])),
              ValueListenableBuilder<bool>(
                  valueListenable: notifierButtonsVisible,
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(children: [
                        FloatingActionButton(
                          heroTag: 'fav_1',
                          backgroundColor: Colors.white,
                          child: Icon(Icons.favorite, color: Colors.black87),
                          onPressed: () {},
                        ),
                        Spacer(),
                        FloatingActionButton(
                            heroTag: 'fav_2',
                            backgroundColor: Colors.black87,
                            child: Icon(Icons.shopping_cart),
                            onPressed: () {})
                      ])),
                  builder: (context, value, child) {
                    return AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        left: 0.0,
                        right: 0.0,
                        bottom: value ? 0.0 : -kToolbarHeight,
                        child: child!);
                  })
            ])));
  }
}
