import 'package:dio/dio.dart';
import 'package:tebbi/configs/api_config.dart';
import 'package:tebbi/models/city_data_response_model.dart';
import 'package:tebbi/models/specialization_data_response_model.dart';
import 'package:tebbi/models/specialization_details_data_response.dart';
import 'package:tebbi/shared/services/network/dio_api_service.dart';

class SpecializationsRepository {
  static final DioApiService _dioApiService = DioApiService();

  const SpecializationsRepository();

  Future<SpecializationDataResponse> getSpecializations() async {
    final Response<Map<String, dynamic>> response = await _dioApiService.get(
      path: ApiRoutes.specializationData,
      authorizationRequired: true,
    );

    return SpecializationDataResponse.fromMap(response.data!);
  }

  Future<SpecializationDetailsDataResponse> getSpecializationDetails(
    int id,
  ) async {
    final Response<Map<String, dynamic>> response = await _dioApiService.get(
      path: ApiRoutes.specializationDetailsData(id),
      authorizationRequired: true,
    );

    return SpecializationDetailsDataResponse.fromMap(response.data!);
  }
}
