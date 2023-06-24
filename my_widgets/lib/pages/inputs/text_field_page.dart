import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_widgets/constants/countries.dart';
import 'package:my_widgets/models/country.dart';
import 'package:my_widgets/utils/capitalize_input_formater.dart';

class TextFieldPage extends StatefulWidget {
  const TextFieldPage({super.key});

  @override
  State<TextFieldPage> createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  final _textEditingController = TextEditingController();
  late List<Country> _countries;
  // String _query = '';

  @override
  void initState() {
    super.initState();
    _countries = countries.map<Country>((e) => Country.fromJson(e)).toList();
  }

  // Simpre liberar controaldores
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /* Filtrar en el appbar los páises */
    final query = _textEditingController.text;
    late final List<Country> filteredList;
    if (query.isEmpty) {
      filteredList = _countries;
    } else {
      filteredList = _countries
          .where(
            (element) =>
                element.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: TextField(
          controller: _textEditingController,
          // Validaciones con regex
          // allow = false => a la inversa
          // NO TENER MÚLTIPLES FILTROS CON REGEX (SOLO 1)
          inputFormatters: [
            FilteringTextInputFormatter(RegExp(r'^[a-zA-Z\s]*$'), allow: true),
            CapitalizeInputFormater(),
          ],
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            label: const Text('Buscar...'),
            hintText: 'Ejemplo: Peru',
            hintStyle: const TextStyle(color: Colors.black26),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
                onPressed: () {
                  _textEditingController.text = ''; // limpiando campo de texto
                  // query = '';  Limpiar query para ver todos los países
                  FocusScope.of(context)
                      .unfocus(); // setState hace el setState (esconder teclado)
                  // setState(() {});
                },
                icon: const Icon(Icons.close)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
              color: Color(0xffd81b60),
            )),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.black54,
            )),
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.black12,
            )),
          ),
          onChanged: (_) {
            setState(() {});
          },
        ),
      ),
      body: ListView.builder(
        itemCount: filteredList.length,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
            .onDrag, // minimizar teclado con scroll
        itemBuilder: (BuildContext context, int index) {
          final country = filteredList[index];
          return ListTile(
            title: Text(country.name),
          );
        },
      ),
    );
  }
}
