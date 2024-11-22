import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../util/app_url.dart';

class ApiLoginPasswordService {
  Future<dynamic> ApiLoginService(String? username, String? password) async {
    var ur = Uri.parse(AppUrl.login);
    final response2 = await http.post(ur,
        body: json.encode({
          "userName": username,
          "password": password
        }), headers: {
          "Content-Type": "application/json; charset=utf-8",
        });
    switch (response2.statusCode) {
      case 200:
        // loginResponse.add(response2.body);
        return json.decode(response2.body);
        break;

      default:
        return null;
        break;
    }
  }
}
