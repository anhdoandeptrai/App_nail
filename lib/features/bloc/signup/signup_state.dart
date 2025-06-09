import 'package:equatable/equatable.dart';

abstract class SignupState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final String email;
  final String accessToken;
  SignupSuccess({required this.email, required this.accessToken});
  @override
  List<Object?> get props => [email, accessToken];
}

class SignupFailure extends SignupState {
  final String message;
  SignupFailure(this.message);
  @override
  List<Object?> get props => [message];
}
