import '../../../../domain/repositories/rick_and_morty_repository.dart';
import '../../../global/state_notifier.dart';
import 'state/home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  HomeController(super.state, {required this.repository});

  final RickAndMortyRepository repository;

  Future<void> init() async {
    state = HomeState.loading();
    final result = await repository.getCharacters();
    state = await result.when(
      left: (_) => HomeState.failed(),
      right: (characters) => HomeState.loaded(characters: characters),
    );
  }
}
