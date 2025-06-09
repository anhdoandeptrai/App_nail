import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:app_nail/core/network/dio_client.dart';
import 'verify_otp_event.dart';
import 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  Timer? _timer;
  int _seconds = 60;

  VerifyOtpBloc() : super(const VerifyOtpInitial()) {
    on<OtpSubmitted>(_onOtpSubmitted);
    on<OtpResendRequested>(_onOtpResendRequested);
  }

  Future<void> _onOtpSubmitted(
    OtpSubmitted event,
    Emitter<VerifyOtpState> emit,
  ) async {
    emit(VerifyOtpLoading());
    try {
      final dio = DioClient().dio;
      final options = event.accessToken.isNotEmpty
          ? Options(headers: {"Authorization": "Bearer ${event.accessToken}"})
          : null;
      final res = await dio.post(
        '/auth/verification-otp',
        data: {"value": event.email, "type": "email", "otp": event.otp},
        options: options,
      );
      if (res.statusCode == 200 && res.data['data'] == true) {
        emit(VerifyOtpSuccess());
      } else {
        emit(const VerifyOtpFailure("Mã không đúng"));
      }
    } catch (e) {
      emit(const VerifyOtpFailure("Mã không đúng"));
    }
  }

  Future<void> _onOtpResendRequested(
    OtpResendRequested event,
    Emitter<VerifyOtpState> emit,
  ) async {
    emit(VerifyOtpResending(_seconds));
    try {
      final dio = DioClient().dio;
      final options = event.accessToken.isNotEmpty
          ? Options(headers: {"Authorization": "Bearer ${event.accessToken}"})
          : null;
      final res = await dio.post(
        '/auth/resend-otp',
        data: {"value": event.email, "type": "email"},
        options: options,
      );
      if (res.statusCode == 200) {
        _seconds = 60;
        _timer?.cancel();
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (_seconds > 0) {
            _seconds--;
            emit(VerifyOtpResent(_seconds));
          } else {
            timer.cancel();
            emit(const VerifyOtpInitial(seconds: 0));
          }
        });
        emit(VerifyOtpResent(_seconds));
      }
    } catch (e) {
      emit(const VerifyOtpFailure("Không gửi lại được mã OTP"));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
