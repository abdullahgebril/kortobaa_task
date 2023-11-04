import 'package:dio/dio.dart';
import 'package:flutter_task/core/network/api_manager.dart';
import 'package:flutter_task/core/network/request_body.dart';
import 'package:flutter_task/features/login/model/token_model.dart';

class LoginRepository {
  Future<TokenModel> login(String username, String password) async {
    RequestBody requestBody = RequestBody({
      "username": username,
      "password": password,
    });
    final response = await ApiManager.sendRequest(
        link: 'users/login/',
        body: requestBody,
        formData: FormData.fromMap(requestBody.body),
        method: Method.POST);
    return TokenModel.fromJson(response!.data!);
  }
}
