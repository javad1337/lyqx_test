import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repo;

  AuthBloc(this._repo) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(AppStarted _, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final loggedIn = await _repo.isLoggedIn();

    if (loggedIn) {
      final username = await _repo.getUsername() ?? '';

      emit(AuthAuthenticated(username));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested e,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final success = await _repo.login(e.username, e.password);
      if (success) {
        emit(AuthAuthenticated(e.username));
      } else {
        emit(AuthFailure('Invalid credentials'));
      }
    } catch (err) {
      emit(AuthFailure(err.toString()));
    }
  }

  Future<void> _onLoggedOut(LoggedOut _, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _repo.logout();
    emit(AuthUnauthenticated());
  }
}
