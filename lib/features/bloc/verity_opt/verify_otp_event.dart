import 'package:equatable/equatable.dart';

abstract class VerifyOtpEvent extends Equatable {
  const VerifyOtpEvent();

  @override
  List<Object?> get props => [];
}

class OtpChanged extends VerifyOtpEvent {
  final String otp;
  const OtpChanged(this.otp);

  @override
  List<Object?> get props => [otp];
}

class OtpSubmitted extends VerifyOtpEvent {
  final String email;
  final String accessToken;
  final String otp;
  const OtpSubmitted({
    required this.email,
    required this.accessToken,
    required this.otp,
  });

  @override
  List<Object?> get props => [email, accessToken, otp];
}

class OtpResendRequested extends VerifyOtpEvent {
  final String email;
  final String accessToken;
  const OtpResendRequested({required this.email, required this.accessToken});

  @override
  List<Object?> get props => [email, accessToken];
}
