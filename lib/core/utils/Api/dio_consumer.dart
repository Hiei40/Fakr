import 'package:dio/dio.dart';
import 'api_consumer.dart';
import 'endpoint.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;
  DioConsumer({required this.dio}) {
    // dio.options.baseUrl = EndPoint.baseUrl;
    // dio.options.headers = {
    //   'Content-Type': 'application/json',  // Default header for JSON APIs
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer ${EndPoint.bearetoken}',
    //
    //   // Accept JSON responses
    // };

    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  // Function to set the Authorization token (for protected routes)
  void setAuthorizationToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  Future delete(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        bool isFromData = false,
      }) async {
    try {
      //print("Sending DELETE request to: $path");
      final response = await dio.delete(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      //print("DioException: ${e.response?.data}");
      handleDioExceptions(e);
      rethrow;
    }
  }

  @override
  Future get(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      // print("Sending GET request to: $path");
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      //print("DioException: ${e.response?.data}");
      handleDioExceptions(e);
      rethrow;
    }
  }

  @override
  Future patch(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        bool isFromData = false,
      }) async {
    try {
      //print("Sending PATCH request to: $path");
      final response = await dio.patch(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      //print("DioException: ${e.response?.data}");
      handleDioExceptions(e);
      rethrow;
    }
  }

  @override
  Future post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        bool isFromData = false,
      }) async {
    try {
      final response = await dio.post(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      //print("DioException: ${e.response?.data}");
      handleDioExceptions(e);
      rethrow;
    }
  }

  // Handle Dio exceptions and log errors appropriately
  void handleDioExceptions(DioException e) {
    if (e.response != null) {
      //    print("Error Response: ${e.response?.data}");
      if (e.response?.statusCode == 401) {
      }
    } else {
      //    print("Error: ${e.message}");
    }
  }
}