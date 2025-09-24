import 'package:dio/dio.dart';
import 'package:tebbi/configs/api_config.dart';
import 'package:tebbi/models/autentication_response_model.dart';
import 'package:tebbi/models/login_request_model.dart';
import 'package:tebbi/models/registration_request_model.dart';
import 'package:tebbi/shared/services/network/dio_api_service.dart';

class AuthenticationRepository {
  static final DioApiService _dioApiService = DioApiService();

  const AuthenticationRepository();

  Future<AuthenticationResponse> login({required LoginRequest request}) async {
    final Response<Map<String, dynamic>> response = await _dioApiService.post(
      path: ApiRoutes.login,
      formData: FormData.fromMap(request.toMap()),
    );

    return AuthenticationResponse.fromMap(response.data!);
  }

  Future<AuthenticationResponse> register({
    required RegistrationRequest request,
  }) async {
    final Response<Map<String, dynamic>> response = await _dioApiService.post(
      path: ApiRoutes.register,
      formData: FormData.fromMap(request.toMap()),
    );

    return AuthenticationResponse.fromMap(response.data!);
  }

  Future<int> logout() async {
    await _dioApiService.post(
      path: ApiRoutes.logout,
      authorizationRequired: true,
    );

    return 200;
  }
}
