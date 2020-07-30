import 'package:cupertinoapp/src/models/youtube_model.dart';

class MasterEvent {}

/* Actualizar pestaña activa de la página home */
class MasterSetTab extends MasterEvent {
  final int tab;

  MasterSetTab({this.tab});
}

/* Agregar video en la página historial */
class MasterAddToHistory extends MasterEvent {
  final YouTubeVideo youTubeVideo;

  MasterAddToHistory({this.youTubeVideo});
}

/* Agregar video en la página favoritos */
class MasterAddToFavorites extends MasterEvent {
  final YouTubeVideo youTubeVideo;

  MasterAddToFavorites({this.youTubeVideo});
}

/* Eliminar video del historial */
class MasterRemoveFromHistory extends MasterEvent {
  final int index;

  MasterRemoveFromHistory({this.index});
}

/* logout */
class MasterLogOut extends MasterEvent {}
