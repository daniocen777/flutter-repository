import 'package:sembast/sembast.dart';
import 'package:sembast_nosql/src/db/db.dart';
import 'package:sembast_nosql/src/models/user_model.dart';

class UserStore {
  UserStore._internal();
  static UserStore _instance = UserStore._internal();
  static UserStore get instance => _instance;

  final Database _db = DB.instance.database;

  /* StoreRef<tipo_llave, tipo_dato_a_guardar>( 'nombre' ) */
  final StoreRef<String, Map> _storeRef = StoreRef<String, Map>('users');

  Future<List<User>> find({Finder finder}) async {
    final List<RecordSnapshot<String, Map>> snapshots =
        await this._storeRef.find(this._db, finder: finder);

    return snapshots.map((RecordSnapshot<String, Map> snapshot) {
      return User.fromJson(snapshot.value);
    }).toList();
  }

  Future<void> add(User user) async {
    await this._storeRef.record(user.id).put(this._db, user.toJson());
  }

  Future<int> delete({Finder finder}) async {
    return await this._storeRef.delete(this._db, finder: finder);
  }
}
