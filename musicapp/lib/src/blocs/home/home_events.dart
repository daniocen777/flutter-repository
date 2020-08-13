import 'package:musicapp/src/models/artist_model.dart';

abstract class HomeEvent {}

class CheckDbEvent extends HomeEvent {}

class LoadArtistsEvent extends HomeEvent {}

class OnSelectArtistEvent extends HomeEvent {}

/* Filtrar artista */
class OnSearchEvent extends HomeEvent {
  final String searchText;

  OnSearchEvent(this.searchText);
}

/* Artistas con sus playlist */
class DownloadEvent extends HomeEvent {
  final List<Artist> artistsSelected;

  DownloadEvent(this.artistsSelected);
}

/* Artistas seleccionados */
class OnSelectedEvent extends HomeEvent {
  final int id;

  OnSelectedEvent(this.id);
}
