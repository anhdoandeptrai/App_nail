import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_event.dart';
import 'signup_state.dart';
import 'package:app_nail/core/auth/getIt.dart';
import 'package:app_nail/core/auth/AuthRemoteDatasource.dart';
import 'package:app_nail/core/auth/ServerException.dart';
import 'package:dio/dio.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupSubmitted>((event, emit) async {
      emit(SignupLoading());
      final dio = getIt<Dio>();
      final authDatasource = getIt<AuthRemoteDatasource>();

      try {
        final checkRes = await dio.post(
          '/auth/check-email-phone',
          data: {"email": event.email, "phone": event.phone},
        );
        final data = checkRes.data['data'];
        final emailExists = data?['email_exists'] == true;
        final phoneExists = data?['phone_exists'] == true;

        if (checkRes.statusCode == 200 && (emailExists || phoneExists)) {
          String msg = '';
          if (emailExists) msg += 'Email đã tồn tại. ';
          if (phoneExists) msg += 'Số điện thoại đã tồn tại.';
          emit(SignupFailure(msg.trim()));
          return;
        }
      } catch (e) {
        emit(
          SignupFailure(
            'Không thể kiểm tra email/số điện thoại. Vui lòng thử lại.',
          ),
        );
        return;
      }

      try {
        final result = await authDatasource.signup(
          fullname: event.fullname,
          email: event.email,
          phone: event.phone,
          password: event.password,
          passwordConfirmation: event.passwordConfirmation,
        );
        if (result['status'] == 200) {
          emit(
            SignupSuccess(
              email: event.email,
              accessToken: result['access_token'] ?? '',
            ),
          );
        } else {
          emit(SignupFailure(result['message'] ?? 'Đăng ký thất bại'));
        }
      } on ServerException catch (e) {
        emit(SignupFailure(e.message ?? 'Đăng ký thất bại'));
      } on DioException catch (e) {
        emit(
          SignupFailure(
            'Không thể đăng ký. Vui lòng thử lại! Chi tiết: ${e.response?.data['message'] ?? e.message}',
          ),
        );
      } catch (e) {
        emit(SignupFailure('Lỗi không xác định'));
      }
    });
  }
}
