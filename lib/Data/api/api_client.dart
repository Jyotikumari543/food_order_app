import 'package:get/get.dart';

import '../../app_constant.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl,required this.token}) {
    baseUrl = appBaseUrl;
    token=AppConstants.TOKEN;
    timeout = Duration(seconds: 30);
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }
  void updateHeader(String token){
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri) async {
    try {
      Response response = await get(uri);
    //  print("API Response status code: ${response.statusCode}"); // Add this line
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri,dynamic body) async {
    print(body.toString());
    try {
      Response response = await post(uri,body, headers: _mainHeaders);
      print(response.toString());
    //  print("API Response status code: ${response.statusCode}"); // Add this line
      return response;
    } catch (e) {
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

}