import 'dart:developer';
import 'dart:convert';
import 'package:app_nail/core/auth/ServerException.dart';
import 'package:dio/dio.dart';
import '../../common/models/login_response.dart';

abstract interface class AuthRemoteDatasource {
  Future<LoginResponse> signin({
    required String email,
    required String password,
  });

  Future<Map<String, dynamic>> signup({
    required String fullname,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  });
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasourceImpl({required this.dio});

  @override
  Future<LoginResponse> signin({
    required String email,
    required String password,
  }) async {
    try {
      final res = await dio.post(
        '/auth/login',
        data: {"email": email, "password": password},
      );
      log('Login response: statusCode=${res.statusCode}, data=${res.data}');
      if (res.statusCode != 200) {
        throw ServerException(
          message: res.data is String ? res.data : jsonEncode(res.data),
        );
      }
      final returnedData = LoginResponse.fromJson(res.data);
      if (returnedData.accessToken.isEmpty) {
        throw ServerException(message: 'Sai tài khoản hoặc mật khẩu');
      }
      return returnedData;
    } on ServerException {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw ServerException(message: 'Lỗi kết nối');
    }
  }

  @override
  Future<Map<String, dynamic>> signup({
    required String fullname,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final res = await dio.post(
        '/users/register',
        data: {
          'fullname': fullname,
          'email': email,
          'phone': phone,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );
      log('Register response: statusCode=${res.statusCode}, data=${res.data}');
      if (res.statusCode == 200 && res.data['status'] == 200) {
        return {
          'status': 200,
          'email': email,
          'access_token': res.data['access_token'] ?? '',
        };
      } else {
        String message = res.data['message'] ?? 'Đăng ký thất bại';
        if (res.data['message_validate'] != null) {
          final validate = res.data['message_validate'] as Map<String, dynamic>;
          final details = validate.entries
              .map((e) => (e.value as List).join(', '))
              .join('\n');
          message += '\n$details';
        }
        throw ServerException(message: message);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw ServerException(message: 'Lỗi kết nối');
    }
  }
}
