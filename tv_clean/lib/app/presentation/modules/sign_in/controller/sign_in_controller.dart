import '../../../../domain/either/either.dart';
import '../../../../domain/failures/sign_in/sign_in_failure.dart';
import '../../../../domain/models/user/user.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../../global/controllers/favorites/favorites_controller.dart';
import '../../../global/controllers/session_controller.dart';
import '../../../global/state_notifier.dart';
import 'state/sign_in_state.dart'; // Importar de foundation (no de material)

/* En los controladores, NUNCA USAR widgets (vistas, context, etc) */
class SignInController extends StateNotifier<SignInState> {
  SignInController(
    super.state, {
    required this.authenticationRepository,
    required this.sessionController,
    required this.favoritesController,
  });

  final AuthenticationRepository authenticationRepository;
  final SessionController sessionController;
  final FavoritesController favoritesController;

  void onUsernameChanged(String text) {
    onlyUpdate(state.copyWith(username: text.trim().toLowerCase()));
  }

  void onPasswordChanged(String text) {
    onlyUpdate(state.copyWith(password: text.replaceAll(' ', '')));
  }

  Future<Either<SignInFailure, User>> submit() async {
    state = state.copyWith(fetching: true);
    final result =
        await authenticationRepository.signIn(state.username, state.password);

    result.when(
        left: (_) => state = state.copyWith(fetching: false),
        right: (user) {
          sessionController.setUser(user);
          favoritesController.init();
        });

    return result;

    /* final result = await context
        .read<AuthenticationRepository>()
        .signIn(controller.state.username, controller.state.password); */
  }
}
