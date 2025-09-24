import 'package:dio/dio.dart';
import 'package:tebbi/configs/api_config.dart';
import 'package:tebbi/models/specialization_data_response_model.dart';
import 'package:tebbi/shared/services/network/dio_api_service.dart';

class HomeRepository {
  static final DioApiService _dioApiService = DioApiService();

  const HomeRepository();

  Future<SpecializationDataResponse> getHome() async {
    final Response<Map<String, dynamic>> response = await _dioApiService.get(
      path: ApiRoutes.homeData,
      authorizationRequired: true,
    );

    return SpecializationDataResponse.fromMap(response.data!);
  }
}
