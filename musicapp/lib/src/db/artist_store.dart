import 'package:musicapp/src/db/db.dart';
import 'package:musicapp/src/models/artist_model.dart';
import 'package:sembast/sembast.dart';

class ArtistStore {
  ArtistStore._internal();
  static ArtistStore _instance = ArtistStore._internal();
  static ArtistStore get instance => _instance;

  Database _db = DB.instance.database;
  StoreRef<int, Map> _store = StoreRef('artists');

  Future<List<Artist>> find() async {
    final snapshot = await this._store.find(this._db);
    return snapshot.map<Artist>((e) => Artist.fromJson(e.value)).toList();
  }

  Future<void> add(Artist artist) async {
    await this._store.record(artist.id).put(_db, artist.toJson());
  }

  Future<void> addAll(List<Artist> artists) async {
    await this._db.transaction((transaction) async {
      for (final artist in artists) {
        await this._store.record(artist.id).put(transaction, artist.toJson());
      }
    });
  }

  Future<void> clear() async {
    await this._store.delete(this._db);
  }
}
