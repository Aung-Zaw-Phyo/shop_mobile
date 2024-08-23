import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_mobile/core/helper.dart';
import 'package:shop_mobile/features/auth/domain/usecases/login.dart';
import 'package:shop_mobile/features/auth/domain/usecases/register.dart';
import 'package:shop_mobile/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:shop_mobile/features/auth/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthBloc(
    this.loginUseCase,
    this.registerUseCase,
  ) : super(AuthInitial()) {
    on<AuthLogin>(
      onLogin,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<AuthLogout>(
      onLogout,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<AuthRegister>(
      onRegister,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  void onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUseCase.execute(
        email: event.email, password: event.password);
    final prefs = await sharedPrefs();
    result.fold(
      (failure) {
        emit(AuthFailed(failure.messages));
      },
      (data) {
        prefs.setString('token', data.accessToken!);
        emit(const AuthLoaded());
      },
    );
  }

  void onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final prefs = await sharedPrefs();
    prefs.remove('token');
    emit(const AuthLoaded());
  }

  void onRegister(AuthRegister event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await registerUseCase.execute(
      name: event.name,
      email: event.email,
      password: event.password,
    );
    final prefs = await sharedPrefs();

    result.fold(
      (failure) {
        emit(AuthFailed(failure.messages));
      },
      (data) {
        prefs.setString('token', data.accessToken!);
        emit(const AuthLoaded());
      },
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
