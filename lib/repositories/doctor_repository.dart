import 'package:dio/dio.dart';
import 'package:tebbi/configs/api_config.dart';
import 'package:tebbi/models/doctor_details_response_model.dart';
import 'package:tebbi/models/doctors_data_response_model.dart';
import 'package:tebbi/shared/services/network/dio_api_service.dart';

class DoctorsRepository {
  static final DioApiService _dioApiService = DioApiService();

  const DoctorsRepository();

  Future<DoctorsDataResponse> getDoctors() async {
    final Response<Map<String, dynamic>> response = await _dioApiService.get(
      path: ApiRoutes.doctorData,
      authorizationRequired: true,
    );

    return DoctorsDataResponse.fromMap(response.data!);
  }

  Future<DoctorDetailsDataResponse> getSpecializationDetails(int id) async {
    final Response<Map<String, dynamic>> response = await _dioApiService.get(
      path: ApiRoutes.doctorDetailsData(id),
      authorizationRequired: true,
    );

    return DoctorDetailsDataResponse.fromMap(response.data!);
  }

  Future<DoctorsDataResponse> cityDoctors(int cityId) async {
    final Response<Map<String, dynamic>> response = await _dioApiService.get(
      path: ApiRoutes.cityDoctorsData(cityId),
      authorizationRequired: true,
    );

    return DoctorsDataResponse.fromMap(response.data!);
  }

  Future<DoctorsDataResponse> searchDoctors(String query) async {
    final Response<Map<String, dynamic>> response = await _dioApiService.get(
      path: ApiRoutes.doctorSearchData(query),
      authorizationRequired: true,
    );

    return DoctorsDataResponse.fromMap(response.data!);
  }
}
