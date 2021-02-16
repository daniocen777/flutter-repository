import 'package:flutter/material.dart';
import 'package:pages_samples/rappi_scroll_sync/models/rappi_product.dart';
import 'package:pages_samples/rappi_scroll_sync/utils/colors.dart';

class RappiProductItem extends StatelessWidget {
  final double productHight;
  final RappiProduct product;

  const RappiProductItem({Key key, this.productHight, this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.productHight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Card(
          elevation: 6.0,
          shadowColor: Colors.black54,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(this.product.image),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(this.product.name,
                        style: TextStyle(
                            color: BLUE_COLOR,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(this.product.description,
                        maxLines: 2,
                        style: TextStyle(
                          color: BLUE_COLOR,
                          fontSize: 10.0,
                        )),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text('\$${this.product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: GREEN_COLOR,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
