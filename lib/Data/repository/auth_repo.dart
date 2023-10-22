import 'package:food_order_app/app_constant.dart';
import 'package:food_order_app/models/signup_body_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> registration(SignUpBody signUpBody) async {
    try {
      final response = await apiClient.postData(
        AppConstants.REGISTRATION_URI,
        signUpBody.toJson(),
      );
      return response;
    } catch (e) {
      // Handle any exceptions or errors here
      throw e;
    }
  }

  Future<Response> login(String email,String password) async {
    try {
      final response = await apiClient.postData(
        AppConstants.LOGIN_URI,
        {"email":email,"password":password}
      );
      return response;
    } catch (e) {
      // Handle any exceptions or errors here
      throw e;
    }
  }

  Future<void> saveUserToken(String token) async {
    try {
      apiClient.token = token;
      apiClient.updateHeader(token);
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      // Handle any exceptions or errors here
      throw e;
    }
  }

  Future<void> saveUserNumberAndPassword(String number,String password) async {
    try {

      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      // Handle any exceptions or errors here
      throw e;
    }
  }
}
