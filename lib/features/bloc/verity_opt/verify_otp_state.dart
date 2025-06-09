import 'package:equatable/equatable.dart';

abstract class VerifyOtpState extends Equatable {
  const VerifyOtpState();

  @override
  List<Object?> get props => [];
}

class VerifyOtpInitial extends VerifyOtpState {
  final int seconds;
  const VerifyOtpInitial({this.seconds = 60});

  @override
  List<Object?> get props => [seconds];
}

class VerifyOtpLoading extends VerifyOtpState {}

class VerifyOtpSuccess extends VerifyOtpState {}

class VerifyOtpFailure extends VerifyOtpState {
  final String error;
  const VerifyOtpFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class VerifyOtpResending extends VerifyOtpState {
  final int seconds;
  const VerifyOtpResending(this.seconds);

  @override
  List<Object?> get props => [seconds];
}

class VerifyOtpResent extends VerifyOtpState {
  final int seconds;
  const VerifyOtpResent(this.seconds);

  @override
  List<Object?> get props => [seconds];
}
