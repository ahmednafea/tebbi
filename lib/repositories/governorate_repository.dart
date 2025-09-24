import 'package:dio/dio.dart';
import 'package:tebbi/configs/api_config.dart';
import 'package:tebbi/models/governate_data_response_model.dart';
import 'package:tebbi/shared/services/network/dio_api_service.dart';

class GovernorateRepository {
  static final DioApiService _dioApiService = DioApiService();

  const GovernorateRepository();

  Future<GovernorateDataResponse> getGovernoratesList() async {
    final Response<Map<String, dynamic>> response = await _dioApiService.get(
      path: ApiRoutes.governorateData,
      authorizationRequired: true,
    );

    return GovernorateDataResponse.fromMap(response.data!);
  }
}
