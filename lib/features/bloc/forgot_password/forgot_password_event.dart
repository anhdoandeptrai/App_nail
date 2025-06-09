import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object?> get props => [];
}

class FindAccountEvent extends ForgotPasswordEvent {
  final String value;

  const FindAccountEvent(this.value);

  @override
  List<Object?> get props => [value];
}
