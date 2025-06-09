import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupSubmitted extends SignupEvent {
  final String fullname;
  final String email;
  final String phone;
  final String password;
  final String passwordConfirmation;

  SignupSubmitted({
    required this.fullname,
    required this.email,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  List<Object?> get props => [
    fullname,
    email,
    phone,
    password,
    passwordConfirmation,
  ];
}
