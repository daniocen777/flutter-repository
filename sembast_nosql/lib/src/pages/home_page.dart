import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_nosql/src/db/theme.dart';
import 'package:sembast_nosql/src/db/user-store.dart';
import 'package:sembast_nosql/src/models/user_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> _users = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    this._load();
  }

  _load() async {
    /* De mayor a menor edad */
    final Finder finder =
        Finder(sortOrders: [SortOrder('age', false), SortOrder('name')]);
    this._users = await UserStore.instance.find(finder: finder);
    setState(() {});
  }

  _add() async {
    final User user = User.fake();
    await UserStore.instance.add(user);
    this._users.add(user);
    setState(() {});
  }

  _delete() async {
    final Finder finder = Finder(filter: Filter.greaterThan('age', 55));
    final int count = await UserStore.instance.delete(finder: finder);
    final SnackBar snackBar = SnackBar(
      content: Text('$count items deleted'),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
    this._load();
  }

  _deleteUser(User user) async {
    final Finder finder = Finder(filter: Filter.byKey(user.id));
    final int count = await UserStore.instance.delete(finder: finder);
    final SnackBar snackBar = SnackBar(
      content: Text('User deleted'),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
    this._load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          Switch(
            onChanged: (bool value) {
              MyAppTheme.instance.change(value);
            },
            value: MyAppTheme.instance.darkEnabled,
          )
        ],
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: _users.length,
        itemBuilder: (BuildContext context, int index) {
          final user = _users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text('Age: ${user.age}, email: ${user.email}'),
            trailing: IconButton(icon: Icon(Icons.delete), onPressed: () {
              this._deleteUser(user);
            }),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: this._load,
            heroTag: 'reload',
            backgroundColor: Colors.green,
            child: Icon(Icons.repeat, color: Colors.white),
          ),
          SizedBox(width: 15.0),
          FloatingActionButton(
            onPressed: this._delete,
            heroTag: 'clear',
            backgroundColor: Colors.redAccent,
            child: Icon(Icons.delete_sweep, color: Colors.white),
          ),
          SizedBox(width: 15.0),
          FloatingActionButton(
            onPressed: this._add,
            heroTag: 'add',
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.person_add, color: Colors.white),
          )
        ],
      ),
    );
  }
}
