import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:bandsapp/services/socket_service.dart';
import 'package:bandsapp/models/band_model.dart';

class HomePage extends StatefulWidget {
  static final route = 'home';
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [];

  @override
  void initState() {
    super.initState();
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on("active-bands", (payload) {
      this._handleActivebands(payload);
    });
  }

  _handleActivebands(dynamic payload) {
    this.bands = (payload as List).map((band) => Band.fromMap(band)).toList();
    setState(() {});
  }

  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off("active-bands");
    super.dispose();
  }

  _showDialogNewBand() {
    final textEditingController = TextEditingController();
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('New Band Name'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoTextField(
                controller: textEditingController,
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Add'),
                  onPressed: () => addBandToList(textEditingController.text)),
              CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text('Cancel'),
                  onPressed: () => Navigator.pop(context)),
            ],
          );
        });
  }

  void addBandToList(String name) {
    if (name.length > 0) {
      final socketService = Provider.of<SocketService>(context, listen: false);
      socketService.socket.emit("add-band", {'name': name});
    }
    Navigator.pop(context);
  }

  Widget _itemBand(Band band) {
    final socketService = Provider.of<SocketService>(context, listen: false);
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) =>
          socketService.socket.emit('delete-band', {'id': band.id}),
      background: Container(
          padding: EdgeInsets.only(left: 8.0),
          color: Colors.redAccent,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Delete band',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ))),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[100],
            child: Text(band.name.substring(0, 2)),
          ),
          title: Text(band.name),
          trailing: Text(
            '${band.votes}',
            style: TextStyle(fontSize: 18.0),
          ),
          onTap: () => socketService.socket.emit("vote-band", {'id': band.id})),
    );
  }

  Widget _showGraph() {
    final Size size = MediaQuery.of(context).size;
    Map<String, double> dataMap = new Map();

    for (var i = 0; i < this.bands.length; i++) {
      dataMap.putIfAbsent(bands[i].name, () => bands[i].votes.toDouble());
    }

    final List<Color> colorList = [
      Colors.blue[50],
      Colors.blue[200],
      Colors.pink[50],
      Colors.pink[200],
      Colors.yellow[50],
      Colors.yellow[200],
      Colors.orange[50],
      Colors.orange[200],
      Colors.deepPurple[50],
      Colors.deepPurple[200],
    ];

    if (dataMap.isNotEmpty && dataMap != null) {
      return Container(
          padding: EdgeInsets.only(top: 15.0),
          child: PieChart(
            dataMap: dataMap,
            animationDuration: Duration(milliseconds: 800),
            chartRadius: size.width / 3.2,
            colorList: colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 10,
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: false,
              showChartValues: true,
              showChartValuesInPercentage: false,
              showChartValuesOutside: true,
            ),
          ));
    }

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text('Cargando datos'),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Bands', style: TextStyle(color: Colors.black87)),
        elevation: 1.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 10.0),
              child: (socketService.serverStatus == ServerStatus.online)
                  ? Icon(Icons.check_circle, color: Colors.blue[300])
                  : Icon(Icons.offline_bolt, color: Colors.redAccent))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            this._showGraph(),
            Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: bands.length,
                  itemBuilder: (BuildContext context, int index) =>
                      _itemBand(bands[index])),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1.0,
        onPressed: this._showDialogNewBand,
      ),
    );
  }
}
