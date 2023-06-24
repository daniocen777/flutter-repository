import 'package:flutter/material.dart';

class CheckBoxPage extends StatefulWidget {
  const CheckBoxPage({super.key});

  @override
  State<CheckBoxPage> createState() => _CheckBoxPageState();
}

class _CheckBoxPageState extends State<CheckBoxPage> {
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text(
                  ''' Lorem Ipsum es simplemente el texto de relleno de las imprentas
                   y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar
                    de las industrias desde el año 1500, cuando un impresor
                     (N. del T. persona que se dedica a la imprenta) desconocido usó una
                      galería de textos y los mezcló de tal manera que logró hacer un libro
                       de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó
                        como texto de relleno en documentos electrónicos, quedando esencialmente
                         igual al original. Fue popularizado en los 60s con la creación de las
                          hojas "Letraset", las cuales contenian pasajes de Lorem Ipsum, y más 
                          recientemente con software de autoedición, como por ejemplo Aldus PageMaker,
                           el cual incluye versiones de Lorem Ipsum. '''),

              CheckboxListTile(
                  value: _checked,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  title: const Text(
                      'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {
                    print('$value');
                    if (value != null) {
                      setState(() {
                        _checked = value;
                      });
                    }
                  }),

              // No recomendable
              GestureDetector(
                onTap: () {
                  setState(() {
                    _checked = !_checked;
                  });
                },
                child: Row(
                  children: [
                    Checkbox(
                        value: _checked,
                        onChanged: (value) {
                          print('$value');
                          if (value != null) {
                            setState(() {
                              _checked = value;
                            });
                          }
                        }),
                    const Flexible(
                        child: Text(
                            'Lorem Ipsum es simplemente el texto de relleno'))
                  ],
                ),
              ),
              Checkbox(
                  value: _checked,
                  fillColor: MaterialStateProperty.all(Colors.blue),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  onChanged: (value) {
                    print('$value');
                    if (value != null) {
                      setState(() {
                        _checked = value;
                      });
                    }
                  }),
              const Divider(),
              // Switch
              SwitchListTile(
                  value: _checked,
                  inactiveTrackColor: Colors.blueGrey.shade100,
                  title: const Text('Habilitar notificaciones'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {
                    print('$value');
                    setState(() {
                      _checked = value;
                    });
                  }),
              const Divider(),
              MaterialButton(
                onPressed: _checked ? () {} : null,
                child: const Text('Next'),
              )
            ],
          ),
        ),
      )),
    );
  }
}
