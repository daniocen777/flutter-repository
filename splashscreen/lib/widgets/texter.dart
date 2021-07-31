import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/widgets/components/heading_component.dart';

import '../labels/custom_label.dart';

class TexterWidget extends StatelessWidget {
  final String heading;

  const TexterWidget({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      Size texterSize = MediaQuery.of(context).size;
      return Container(
          height: texterSize.height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Container(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.only(left: 36.0, right: 36.0),
                            child: Text(heading,
                                textAlign: TextAlign.center,
                                style: CustomLabels.h2.copyWith(
                                    height: 1.3, letterSpacing: 0.5))))),
               /*  SizedBox(height: 100.0),
                heading == "¿Cuál es tu nombre?"
                    ? HeadingComponent(label: 'Nombre')
                    : heading == "¿Dónde naciste?"
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HeadingComponent(label: 'año/mes/día'),
                            Padding(
                                padding: const EdgeInsets.only(right: 24.0),
                                child: Icon(CupertinoIcons.calendar,
                                    color: Colors.grey[400]))
                          ])
                        : heading == "¿Qué habilidades tienes?"
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                HeadingComponent(label: 'Habilidades'),
                                Padding(
                                    padding: const EdgeInsets.only(right: 24.0),
                                    child: Icon(CupertinoIcons.chevron_down,
                                        color: Colors.grey[400]))
                              ])
                            : Container() */
              ]));
    });
  }
}
