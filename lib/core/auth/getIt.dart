import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../network/dio_client.dart';
import 'AuthRemoteDatasource.dart';
import 'AuthService.dart';
import 'package:app_nail/domain/repositories/auth_repository.dart';
import 'package:app_nail/data/repositories/auth_repository_impl.dart';

final getIt = GetIt.instance;

void setupDI() {
  getIt.registerLazySingleton<Dio>(() => DioClient().dio);
  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDatasource: getIt<AuthRemoteDatasource>()),
  );
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(authRemoteDatasource: getIt<AuthRemoteDatasource>()),
  );
}
