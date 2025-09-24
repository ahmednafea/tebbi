import 'package:dio/dio.dart';
import 'package:tebbi/configs/api_config.dart';
import 'package:tebbi/models/city_data_response_model.dart';
import 'package:tebbi/shared/services/network/dio_api_service.dart';

class CityRepository {
  static final DioApiService _dioApiService = DioApiService();

  const CityRepository();

  Future<CityDataResponse> getCities() async {
    final Response<Map<String, dynamic>> response = await _dioApiService.get(
      path: ApiRoutes.cityData,
      authorizationRequired: true,
    );

    return CityDataResponse.fromMap(response.data!);
  }

  Future<CityDataResponse> getCityDetails(int id) async {
    final Response<Map<String, dynamic>> response = await _dioApiService.get(
      path: ApiRoutes.cityDetailsData(id),
      authorizationRequired: true,
    );

    return CityDataResponse.fromMap(response.data!);
  }
}
