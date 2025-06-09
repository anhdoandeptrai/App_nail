import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_nail/core/network/dio_client.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<FindAccountEvent>(_onFindAccount);
  }

  Future<void> _onFindAccount(
    FindAccountEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    final value = event.value.trim();
    final isEmail = value.contains('@');
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegex = RegExp(r'^(0|\+84)[0-9]{9,10}$');

    if (value.isEmpty ||
        (!isEmail && !phoneRegex.hasMatch(value)) ||
        (isEmail && !emailRegex.hasMatch(value))) {
      emit(
        const ForgotPasswordFailure(
          'Vui lòng nhập đúng email hoặc số điện thoại hợp lệ!',
        ),
      );
      return;
    }

    emit(ForgotPasswordLoading());

    try {
      final dio = DioClient().dio;
      final res = await dio.post(
        '/auth/check-email-phone',
        data: {"value": value, "type": isEmail ? "email" : "phone"},
      );
      if (res.statusCode == 200 && res.data['status'] == 200) {
        emit(ForgotPasswordSuccess(value));
      } else {
        emit(
          ForgotPasswordFailure(
            res.data['message'] ?? "Không tìm thấy tài khoản.",
          ),
        );
      }
    } catch (e) {
      emit(const ForgotPasswordFailure("Không tìm thấy tài khoản."));
    }
  }
}
