part of 'search_bloc.dart';

@immutable
class SearchState {
  final bool manualselection;
  final List<SearchResult> historial;

  SearchState({this.manualselection = false, List<SearchResult> historial})
      : this.historial = (historial == null) ? [] : historial;

  SearchState copyWith({bool manualselection, List<SearchResult> historial}) {
    return SearchState(
      manualselection: manualselection ?? this.manualselection,
      historial: historial ?? this.historial,
    );
  }
}
