import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_task/core/cache/cache_manger.dart';
import 'package:flutter_task/core/cache/user_pref_manager.dart';
import 'package:flutter_task/core/exception/api_exception.dart';
import 'package:flutter_task/core/network/api_response.dart';
import 'package:flutter_task/core/network/request_body.dart';
import 'package:flutter_task/core/utils/app_constants.dart';

class ApiManager {
  static final Dio _dio = Dio();
  static const bool _isTestMode = true;

  ///function to refresh the access token
  static Future<String> refreshToken() async {
    return 'your_new_access_token';
  }

  static void init() {
    //  default configs
    _dio.options.baseUrl = ApiManager.getBaseUrl();
    _dio.options.connectTimeout = const Duration(milliseconds: 30000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 30000);
    _dio.options.responseType = ResponseType.plain;
    _dio.options.followRedirects = false;
    if (_isTestMode) {
      _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          requestBody: true,
          error: true,
          requestHeader: true,
          responseHeader: false));
    }

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          /*
          if (CacheManager.contains(AppConstants.ACCESS_TOKEN)) {
            final accessToken =await UserPrefManager.getCurrentUserAccessToken();
            // Add the access token to the request header
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          */

          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) async {
          if (e.response?.statusCode == 401) {
            // If a 401 response is received, refresh the access token
            String newAccessToken = await refreshToken();

            // Update the request header with the new access token
            e.requestOptions.headers['Authorization'] =
                'Bearer $newAccessToken';
          }
          return handler.next(e);
        },
      ),
    );
  }

  static Future<ApiResponse?> sendRequest(
      {required String link,
      RequestBody? body,
      Map<String, dynamic>? queryParams,
      FormData? formData,
      Method method = Method.POST}) async {
    Map<String, dynamic> headers = {};

    headers.putIfAbsent("Content-Type", () => "application/json");

    if (CacheManager.contains(AppConstants.ACCESS_TOKEN)) {
      final accessToken = await UserPrefManager.getCurrentUserAccessToken();
      // Add the access token to the request header
      headers.putIfAbsent("Authorization", () => "Bearer $accessToken");
    }

    try {
      Response? response;
      if (method == Method.POST) {
        response = await _dio.post(link,
            data: formData ?? body?.getBody(),
            queryParameters: queryParams,
            options: Options(headers: headers));
      } else if (method == Method.PUT) {
        response = await _dio.put(link,
            data: formData ?? body?.getBody(),
            queryParameters: queryParams,
            options: Options(headers: headers));
      } else if (method == Method.GET) {
        response = await _dio.get(link,
            queryParameters: queryParams,
            options: Options(headers: headers, followRedirects: true));
      } else if (method == Method.DELETE) {
        response = await _dio.delete(link,
            data: body,
            queryParameters: queryParams,
            options: Options(headers: headers));
      } else if (method == Method.PATCH) {
        response = await _dio.patch(link,
            data: formData ?? body?.getBody(),
            queryParameters: queryParams,
            options: Options(headers: headers));
      }

      var responseData = getResponseData(response!.data);

      return ApiResponse(
          response.statusCode, jsonDecode(responseData.toString()), "");
    } on DioError catch (e) {
      if (e.response != null && e.response?.statusCode == 401) {
        throw ApiException(
            e.response!.statusCode!, getErrorMsg(e.response?.data));
      } else if (e.response != null &&
          (e.response?.statusCode == 400 ||
              e.response?.statusCode == 404 ||
              e.response?.statusCode == 402 ||
              e.response?.statusCode == 422)) {
        throw ApiException(
            e.response!.statusCode!, getErrorMsg(e.response?.data));
      } else {
        // cannot reach server , server may be down or no internet connection.
        throw ApiException(-1, "Error in server");
      }
    }
  }

  static String getBaseUrl() {
    if (_isTestMode) {
      return 'https://flutterapi.kortobaa.net/';
    } else {
      return 'https://flutterapi.kortobaa.net/';
    }
  }

  static String buildFileUrl(String filePatUrl) {
    return getBaseUrl() + filePatUrl;
  }

  static dynamic getResponseData(dynamic data) {
    bool isDataList = jsonDecode(data) is List;
    var responseData;
    if (isDataList) {
      final result = jsonDecode(data);
      responseData = json.encode(result[0]);
    } else {
      responseData = data;
    }
    return responseData;
  }

  static getErrorMsg(dynamic data) {
    if (data == null || data == "") {
      return "Error in server";
    }
    var error = "";
    final map = jsonDecode(data);
    map.keys.forEach((key) {
      if (key == "detail") {
        error = map['detail'];
      } else {
        var exceptions = map[key] as List<dynamic>;
        error += "${exceptions[0]}\n";
      }
    });
    if (error == "") {
      if (map["message"] != null) {
        error = map["message"];
      }
    }
    return error;
  }
}

// ignore: constant_identifier_names
enum Method { POST, PUT, GET, DELETE, PATCH }
