part of 'memes_bloc_bloc.dart';

@immutable
class MemesState extends Equatable {
  final List<Meme>? memes;
  final bool loading;

  const MemesState({this.memes = const [], this.loading = false});

  // const MemesBlocState();

  MemesState copyWith({List<Meme>? memes, bool? loading}) {
    return MemesState(
        memes: memes ?? this.memes, loading: loading ?? this.loading);
  }

  @override
  List<Object> get props => [];
}

class MemesInitialState extends MemesState {
  MemesInitialState() : super(loading: false, memes: const []);
}
