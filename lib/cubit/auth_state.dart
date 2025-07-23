sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class RegisterLoading extends AuthState {}

final class Registersuccess extends AuthState {}

final class RegeisterFailure extends AuthState {
  final String message;

  RegeisterFailure(this.message);
}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginFailure extends AuthState {
  final String message;

  LoginFailure({required this.message});
}
