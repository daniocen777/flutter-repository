part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class OnActivateManualMarker extends SearchEvent {}

class OnDeactivateManualMarker extends SearchEvent {}

class OnAddHistorial extends SearchEvent {
  final SearchResult result;

  OnAddHistorial(this.result);
}
