abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String message;
  final String? emailError;
  final String? passError;
  LoginFailure(this.message, {this.emailError, this.passError});
}

class LoginSuccess extends LoginState {}
