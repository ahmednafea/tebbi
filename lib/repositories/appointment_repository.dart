import 'package:dio/dio.dart';
import 'package:tebbi/configs/api_config.dart';
import 'package:tebbi/models/appointment_request_model.dart';
import 'package:tebbi/models/appointments_data_response_model.dart';
import 'package:tebbi/shared/services/network/dio_api_service.dart';

import '../models/appointment_details_data_response_model.dart';

class AppointmentsRepository {
  static final DioApiService _dioApiService = DioApiService();

  const AppointmentsRepository();

  Future<AppointmentDataResponse> getAppointments() async {
    final Response<Map<String, dynamic>> response = await _dioApiService.get(
      path: ApiRoutes.appointmentData,
      authorizationRequired: true,
    );

    return AppointmentDataResponse.fromMap(response.data!);
  }

  Future<AppointmentDetailsDataResponseModel> addAppointment(
    AppointmentRequest request,
  ) async {
    final Response<Map<String, dynamic>> response = await _dioApiService.post(
      path: ApiRoutes.addAppointment,
      authorizationRequired: true,
      formData: FormData.fromMap(request.toMap()),
    );

    return AppointmentDetailsDataResponseModel.fromMap(response.data!);
  }
}
