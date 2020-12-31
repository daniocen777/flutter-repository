import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocate/models/search_result.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is OnActivateManualMarker) {
      yield state.copyWith(manualselection: true);
    } else if (event is OnDeactivateManualMarker) {
      yield state.copyWith(manualselection: false);
    } else if (event is OnAddHistorial) {
      final exist = state.historial
          .where((result) => result.nameDestiny == event.result.nameDestiny)
          .length;
      if (exist == 0) {
        final newHistorial = [...state.historial, event.result];
        yield state.copyWith(historial: newHistorial);
      }
    }
  }
}
