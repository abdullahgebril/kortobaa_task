import 'package:dio/dio.dart';
import 'package:flutter_task/core/network/api_manager.dart';
import 'package:flutter_task/core/network/request_body.dart';
import 'package:flutter_task/features/registration/model/user_model.dart';

class RegistrationRepository {
  Future<UserModel> registerAccount(
      {required String username,
      required String email,
      required String firstName,
      required String lastName,
      required String password}) async {
    RequestBody requestBody = RequestBody({
      "password": password,
      "username": username,
      "email": email,
      "first_name": firstName,
      "last_name": lastName
    });
    final response = await ApiManager.sendRequest(
        link: 'users/register/',
        body: requestBody,
        formData: FormData.fromMap(requestBody.body),
        method: Method.POST);
    return UserModel.fromJson(response!.data!);
  }
}
