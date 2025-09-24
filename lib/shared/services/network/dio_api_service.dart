import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tebbi/configs/api_config.dart';
import 'package:tebbi/shared/utilities/local_storage_utility.dart';

/// A service that provides an instance of Dio HTTP client that can be used to make HTTP requests.
///
/// This service is implemented as a singleton using the factory constructor pattern. The first time this class is
/// used, it will create an instance of Dio and set its base URL to the value of `AppConstants.baseUrl`. It also adds two
/// interceptors to the client: `DioRefreshTokenInterceptorService` and `DioExceptionInterceptorService`. Finally, it adds a
/// `LogInterceptor` with logging enabled for both request and response bodies.
class DioApiService {
  /// A singleton instance of [DioApiService].
  factory DioApiService() => _instance;

  static final DioApiService _instance = DioApiService._internal();

  /// A private constructor for [DioApiService] that initializes [dio] with base URL and interceptors.
  DioApiService._internal() {
    dio = Dio();

    String baseUrl = ApiRoutes.baseUrl;

    dio.options.baseUrl = baseUrl;

    dio.interceptors.addAll(<Interceptor>[
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        logPrint: (Object? object) => log(object.toString(), name: 'HTTP'),
      ),
    ]);
  }

  /// A private instance of [Dio] used to make HTTP requests.
  late final Dio dio;

  /// Sends an HTTP GET request.
  ///
  /// Parameters:
  /// * `path`: The endpoint path for the request.
  /// * `queryParameters`: (optional) The query parameters for the request.
  /// * `options`: (optional) The options for the request.
  /// * `onReceiveProgress`: (optional) A callback function that is called when progress is received.
  /// * `authorizationRequired`: (optional) A flag to indicate whether the request requires authorization.
  /// * `interimTokenRequired`: (optional) A flag to indicate whether the request requires an interim token.
  ///
  /// Returns:
  /// A Future that resolves to a [Response] object containing the response data.
  Future<Response<T>> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    void Function(int, int)? onReceiveProgress,
    bool authorizationRequired = false,
  }) async {
    final Options requestOptions = options ?? Options();

    if (authorizationRequired) {
      final String? accessToken = LocalStorageUtility.userAccessToken;

      if (accessToken != null) {
        requestOptions.headers ??= <String, dynamic>{};
        requestOptions.headers!['Authorization'] = 'Bearer $accessToken';
      }
    }

    return _instance.dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: requestOptions,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Sends an HTTP POST request.
  ///
  /// Parameters:
  /// * `path`: The endpoint path for the request.
  /// * `data`: (optional) The data to send with the request.
  /// * `formData`: (optional) The FormData object to send with the request.
  /// * `queryParameters`: (optional) The query parameters for the request.
  /// * `options`: (optional) The options for the request.
  /// * `onSendProgress`: (optional) A callback function that is called when progress is sent.
  /// * `onReceiveProgress`: (optional) A callback function that is called when progress is received.
  /// * `authorizationRequired`: (optional) A flag to indicate whether the request requires authorization.
  /// * `interimTokenRequired`: (optional) A flag to indicate whether the request requires an interim token.
  ///
  /// Returns:
  /// A Future that resolves to a [Response] object containing the response data.
  Future<Response<T>> post<T>({
    required String path,
    Map<String, dynamic>? data,
    FormData? formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool authorizationRequired = false,
  }) async {
    final Options requestOptions = options ?? Options();

    if (authorizationRequired) {
      final String? accessToken = LocalStorageUtility.userAccessToken;

      if (accessToken != null) {
        requestOptions.headers ??= <String, dynamic>{};
        requestOptions.headers!['Authorization'] = 'Bearer $accessToken';
      }
    }

    return _instance.dio.post<T>(
      path,
      data: data ?? formData,
      queryParameters: queryParameters,
      options: requestOptions,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Sends an HTTP PUT request.
  ///
  /// Parameters:
  /// * `path`: The endpoint path for the request.
  /// * `data`: (optional) The data to send with the request.
  /// * `formData`: (optional) The FormData object to send with the request.
  /// * `queryParameters`: (optional) The query parameters for the request.
  /// * `options`: (optional) The options for the request.
  /// * `onSendProgress`: (optional) A callback function that is called when progress is sent.
  /// * `onReceiveProgress`: (optional) A callback function that is called when progress is received.
  /// * `authorizationRequired`: (optional) A flag to indicate whether the request requires authorization.
  /// * `interimTokenRequired`: (optional) A flag to indicate whether the request requires an interim token.
  ///
  /// Returns:
  /// A Future that resolves to a [Response] object containing the response data.
  Future<Response<T>> put<T>({
    required String path,
    Map<String, dynamic>? data,
    FormData? formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool authorizationRequired = false,
  }) async {
    final Options requestOptions = options ?? Options();

    if (authorizationRequired) {
      final String? accessToken = LocalStorageUtility.userAccessToken;

      if (accessToken != null) {
        requestOptions.headers ??= <String, dynamic>{};
        requestOptions.headers!['Authorization'] = 'Bearer $accessToken';
      }
    }

    return _instance.dio.put<T>(
      path,
      data: data ?? formData,
      queryParameters: queryParameters,
      options: requestOptions,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Sends an HTTP PATCH request.
  ///
  /// Parameters:
  /// * `path`: The endpoint path for the request.
  /// * `data`: (optional) The data to send with the request.
  /// * `formData`: (optional) The FormData object to send with the request.
  /// * `queryParameters`: (optional) The query parameters for the request.
  /// * `options`: (optional) The options for the request.
  /// * `onSendProgress`: (optional) A callback function that is called when progress is sent.
  /// * `onReceiveProgress`: (optional) A callback function that is called when progress is received.
  /// * `authorizationRequired`: (optional) A flag to indicate whether the request requires authorization.
  /// * `interimTokenRequired`: (optional) A flag to indicate whether the request requires an interim token.
  ///
  /// Returns:
  /// A Future that resolves to a [Response] object containing the response data.
  Future<Response<T>> patch<T>({
    required String path,
    Map<String, dynamic>? data,
    FormData? formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool authorizationRequired = false,
  }) async {
    final Options requestOptions = options ?? Options();

    if (authorizationRequired) {
      final String? accessToken = LocalStorageUtility.userAccessToken;

      if (accessToken != null) {
        requestOptions.headers ??= <String, dynamic>{};
        requestOptions.headers!['Authorization'] = 'Bearer $accessToken';
      }
    }

    return _instance.dio.patch<T>(
      path,
      queryParameters: queryParameters,
      options: requestOptions,
      data: data ?? formData,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );
  }

  /// Sends an HTTP DELETE request.
  ///
  /// Parameters:
  /// * `path`: The endpoint path for the request.
  /// * `queryParameters`: (optional) The query parameters for the request.
  /// * `options`: (optional) The options for the request.
  /// * `data`: (optional) The data to send with the request.
  /// * `authorizationRequired`: (optional) A flag to indicate whether the request requires authorization.
  /// * `interimTokenRequired`: (optional) A flag to indicate whether the request requires an interim token.
  ///
  /// Returns:
  /// A Future that resolves to a [Response] object containing the response data.
  Future<Response<T>> delete<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? data,
    bool authorizationRequired = false,
  }) async {
    final Options requestOptions = options ?? Options();

    if (authorizationRequired) {
      final String? accessToken = LocalStorageUtility.userAccessToken;

      if (accessToken != null) {
        requestOptions.headers ??= <String, dynamic>{};
        requestOptions.headers!['Authorization'] = 'Bearer $accessToken';
      }
    }

    return _instance.dio.delete<T>(
      path,
      queryParameters: queryParameters,
      options: requestOptions,
      data: data,
    );
  }
}
