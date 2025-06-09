import 'package:app_nail/common/models/login_response.dart';
import 'package:app_nail/core/auth/AuthRemoteDatasource.dart';
import 'package:app_nail/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<LoginResponse> signin({
    required String email,
    required String password,
  }) {
    return remoteDatasource.signin(email: email, password: password);
  }

  @override
  Future<Map<String, dynamic>> signup({
    required String fullname,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) {
    return remoteDatasource.signup(
      fullname: fullname,
      email: email,
      phone: phone,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}
