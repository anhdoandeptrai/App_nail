import 'package:app_nail/common/models/login_response.dart';
import 'package:app_nail/core/auth/AuthRemoteDatasource.dart';
import 'package:dartz/dartz.dart';

import 'ServerException.dart';

class AuthService {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthService({required this.authRemoteDatasource});

  Future<Either<String, LoginResponse>> login(
    String email,
    String password,
  ) async {
    try {
      final result = await authRemoteDatasource.signin(
        email: email,
        password: password,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(e.message ?? 'Sai tài khoản hoặc mật khẩu');
    } catch (e) {
      return left('Lỗi kết nối');
    }
  }
}
