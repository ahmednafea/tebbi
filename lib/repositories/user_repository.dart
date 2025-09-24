import 'package:dio/dio.dart';
import 'package:tebbi/configs/api_config.dart';
import 'package:tebbi/models/profile_data_response_model.dart';
import 'package:tebbi/models/update_profile_request_model.dart';
import 'package:tebbi/shared/services/network/dio_api_service.dart';

class UserRepository {
  static final DioApiService _dioApiService = DioApiService();

  const UserRepository();

  Future<ProfileDataResponse> getUserProfile() async {
    final Response<Map<String, dynamic>> response = await _dioApiService.get(
      path: ApiRoutes.userProfile,
      authorizationRequired: true,
    );

    return ProfileDataResponse.fromMap(response.data!);
  }

  Future<ProfileDataResponse> updateProfile({
    required UpdateProfileRequest request,
  }) async {
    final Response<Map<String, dynamic>> response = await _dioApiService.post(
      path: ApiRoutes.updateProfile,
      formData: FormData.fromMap(request.toMap()),
    );

    return ProfileDataResponse.fromMap(response.data!);
  }
}
