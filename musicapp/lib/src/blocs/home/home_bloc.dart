import 'package:flutter/widgets.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/src/api/deezer_api.dart';
import 'package:musicapp/src/blocs/home/home_events.dart';
import 'package:musicapp/src/blocs/home/home_state.dart';
import 'package:musicapp/src/db/artist_store.dart';
import 'package:musicapp/src/models/artist_model.dart';
import 'package:musicapp/src/models/track_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({HomeState initialState}) : super(HomeState.initialState) {
    add(CheckDbEvent());
  }

  HomeState get initialState => HomeState.initialState;

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is CheckDbEvent) {
      yield* this._mapCheckDbEvent(event);
    } else if (event is OnSearchEvent) {
      yield this.state.copyWith(searchText: event.searchText);
    } else if (event is OnSelectedEvent) {
      yield* this._mapOnSelectedEvent(event);
    } else if (event is DownloadEvent) {
      yield* this._mapDownloadEvent(event);
    }
  }

  Stream<HomeState> _mapDownloadEvent(DownloadEvent event) async* {
    yield this.state.copyWith(status: HomeStatus.downloading);
    List<Artist> artists = [];
    for (final Artist artist in event.artistsSelected) {
      final List<Track> tracks = await DeezerApi.instance.getTracks(artist.id);
      artists.add(artist.addTracks(tracks));
    }
    await ArtistStore.instance.addAll(artists);
    yield this.state.copyWith(status: HomeStatus.ready, artists: artists);
  }

  Stream<HomeState> _mapOnSelectedEvent(OnSelectedEvent event) async* {
    final int id = event.id;
    final List<Artist> temporal = List.from(this.state.artists);
    final int index = temporal.indexWhere((element) => element.id == id);
    if (index != -1) {
      temporal[index] = temporal[index].onSelected();
      yield this.state.copyWith(artists: temporal);
    }
  }

  Stream<HomeState> _mapCheckDbEvent(CheckDbEvent event) async* {
    /* Comprobando datos en la DB */
    final List<Artist> artists = await ArtistStore.instance.find();
    if (artists != null && artists.length >= 5) {
      print('ARTIST: $artists');

      yield this.state.copyWith(status: HomeStatus.ready, artists: artists);
    } else {
      print('DEEZER');
      yield this.state.copyWith(status: HomeStatus.loading);
      final List<Artist> artists = await DeezerApi.instance.getArtists();
      if (artists != null) {
        yield this
            .state
            .copyWith(status: HomeStatus.selecting, artists: artists);
      } else {
        yield this.state.copyWith(status: HomeStatus.error);
      }
    }
  }

  /* Para acceder al bloc desde los hijos de HomePage */
  static HomeBloc of(BuildContext context) {
    return BlocProvider.of<HomeBloc>(context);
  }
}
