import 'package:app_nail/common/models/login_response.dart';

abstract class AuthRepository {
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
