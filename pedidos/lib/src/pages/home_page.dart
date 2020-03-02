import 'package:flutter/material.dart';
import 'package:pedidos/src/provider/menu_provider.dart';
import 'package:pedidos/src/provider/usuario_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductoProvider _productoProvider = new ProductoProvider();

  @override
  void initState() {
    super.initState();
    _cargarProductos();
  }

  _cargarProductos() async {
    await _productoProvider.getUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home')), body: _mostrarModulo());
  }

  Widget _mostrarModulo() {
    return FutureBuilder(
      future: menuProvider.cargarData(), // Lo que está esperando
      initialData: [], // Por defecto, antes de cargar la data
      // Builder es requerido
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        // 3 estados (1=>cuando se pide data, 2=>cuando se tiene y 3=>error)
        return Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView(children: _listaItems(snapshot.data, context)));
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];
    data.forEach((opt) {
      final widgetTemporal = Card(
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            ListTile(
              title: Text(opt['title'], style: TextStyle(fontSize: 20.0)),
              subtitle: Text(opt['description']),
              onTap: () {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text('Ingresar',
                      style: TextStyle(color: Theme.of(context).accentColor)),
                  onPressed: () {
                    switch (opt['ruta']) {
                      case 'usuarios':
                        print("USUARIOS");
                        break;
                      case 'requerimientos':
                        print("REQUERIMIENTOS");
                        break;
                      case 'pedido':
                        print('PEDIDOS');
                        break;
                      case 'comprobantes':
                        print('COMPROBANTES');
                        break;
                      default:
                        print('NO SÉ A DÓNDE QUIERES IR');
                    }
                    /*  Navigator.pushNamed(context, opt['ruta']); */
                  },
                )
              ],
            )
          ],
        ),
      );
      opciones..add(widgetTemporal)..add(SizedBox(height: 15.0));
    });
    return opciones;
  }
}
