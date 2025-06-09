import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'dart:convert';
import 'package:app_nail/core/auth/AuthService.dart';
import 'package:app_nail/core/auth/getIt.dart';
import 'package:dio/dio.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      final dio = getIt<Dio>();
      String? emailError;
      String? passError;

      try {
        final checkRes = await dio.post(
          '/auth/check-email-phone',
          data: {"email": event.email},
        );
        final exists = checkRes.data['data']?['email_exists'] == true;
        if (checkRes.statusCode != 200 || !exists) {
          emit(
            LoginFailure(
              'Không tìm thấy tài khoản',
              emailError:
                  'Có vẻ tài khoản hoặc mật khẩu sai. Vui lòng kiểm tra lại',
            ),
          );
          return;
        }
      } catch (e) {
        emit(
          LoginFailure(
            'Không thể kiểm tra tài khoản',
            emailError: 'Lỗi kết nối hoặc tài khoản không tồn tại',
          ),
        );
        return;
      }

      final authService = getIt<AuthService>();
      final result = await authService.login(event.email, event.password);

      result.fold(
        (l) {
          try {
            final error = jsonDecode(l);
            if (error['status'] == 400) {
              emailError = error['message_validate']?['email']?.join(', ');
              passError = error['message_validate']?['password']?.join(', ');
              String msg = error['message'] ?? 'Lỗi đăng nhập';
              if (error['message_validate'] != null) {
                msg += '\n';
                error['message_validate'].forEach((key, value) {
                  msg += '${value.join(', ')}\n';
                });
              }
              if ((emailError == null || emailError!.isEmpty) &&
                  (passError != null && passError!.isNotEmpty)) {
                msg = 'Sai mật khẩu';
              }
              emit(
                LoginFailure(
                  msg.trim(),
                  emailError: null,
                  passError: (msg == 'Sai mật khẩu')
                      ? 'Sai mật khẩu'
                      : passError,
                ),
              );
            } else if (error['status'] == 401) {
              emit(LoginFailure('Sai mật khẩu', passError: 'Sai mật khẩu'));
            } else {
              emit(LoginFailure(error['message'] ?? l.toString()));
            }
          } catch (_) {
            emit(LoginFailure('Sai mật khẩu', passError: 'Sai mật khẩu'));
          }
        },
        (r) {
          emit(LoginSuccess());
        },
      );
    });
  }
}
