import 'dart:convert';
import 'dart:io';
import 'package:challanmcbjava/service/pref_service.dart';
import 'package:challanmcbjava/util/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class HomepageService {
  final String noInternetMessage =
      'Connection to API server failed due to internet connection';
  Future<Response> apiGetReasons() async {
    var ur = Uri.parse(AppUrl.reasonsApi);
    var token = PreferenceUtils.getUserToken();

    try {
      final response = await http.get(ur, headers: {
        "Content-Type": "application/json; charset=utf-8",
        'Authorization': 'Bearer $token',
      });

      print(response.body);

      return Response(
        statusCode: response.statusCode,
        body: utf8.decode(response.body.codeUnits),
      );
    } on SocketException catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> apiGetCategory() async {
    var ur = Uri.parse(AppUrl.categoryApi);
    var token = PreferenceUtils.getUserToken();

    try {
      final response = await http.get(ur, headers: {
        "Content-Type": "application/json; charset=utf-8",
        'Authorization': 'Bearer $token',
      });

      print(response.body);

      return Response(
        statusCode: response.statusCode,
        body: utf8.decode(response.body.codeUnits),
      );
    } on SocketException catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> apiGetDashboard(type) async {
    var ur = Uri.parse(AppUrl.getDashboard + "?CreatedUserId=$type");
    var token = PreferenceUtils.getUserToken();

    try {
      final response = await http.get(ur, headers: {
        "Content-Type": "application/json; charset=utf-8",
        'Authorization': 'Bearer $token',
      });

      print(response.body);

      return Response(
        statusCode: response.statusCode,
        body: utf8.decode(response.body.codeUnits),
      );
    } on SocketException catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> apiGetPaymodes() async {
    var ur = Uri.parse(AppUrl.paymodes);
    var token = PreferenceUtils.getUserToken();

    try {
      final response = await http.get(ur, headers: {
        "Content-Type": "application/json; charset=utf-8",
        'Authorization': 'Bearer $token',
      });

      print(response.body);

      return Response(
        statusCode: response.statusCode,
        body: utf8.decode(response.body.codeUnits),
      );
    } on SocketException catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> apiGetChallan() async {
    var ur = Uri.parse(AppUrl.getChallan);
    var token = PreferenceUtils.getUserToken();

    try {
      final response = await http.get(ur, headers: {
        "Content-Type": "application/json; charset=utf-8",
        'Authorization': 'Bearer $token',
      });

      print(response.body);

      return Response(
        statusCode: response.statusCode,
        body: utf8.decode(response.body.codeUnits),
      );
    } on SocketException catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> apiGetReceipt() async {
    var ur = Uri.parse(AppUrl.getReceipt);
    var token = PreferenceUtils.getUserToken();

    try {
      final response = await http.get(ur, headers: {
        "Content-Type": "application/json; charset=utf-8",
        'Authorization': 'Bearer $token',
      });

      print(response.body);

      return Response(
        statusCode: response.statusCode,
        body: utf8.decode(response.body.codeUnits),
      );
    } on SocketException catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> apiAddChallan(int? amount, int? reason, int? category,
      String Vehicle, String image1, String imag32) async {
    var ur = Uri.parse(AppUrl.addChallan);
    try {
      var token = PreferenceUtils.getUserToken();
      var session = PreferenceUtils.getString("localSession") == ""
          ? "0"
          : PreferenceUtils.getString("localSession");
      final response2 = await http.post(ur,
          body: json.encode({
            "vehicleToeEntryId": 0,
            "vehicleCategoryId": category,
            "vehicleNo": Vehicle,
            "challanReasonId": reason,
            "amount": amount,
            "image1": image1,
            "image2": imag32,
            "imagePath": ""
          }),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
            'Authorization': 'Bearer $token',
          });
      return Response(
        statusCode: response2.statusCode,
        body: response2.body,
      );
    } on SocketException catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> apiAddReceipt(
      double? amount, int? paymode, String mobile, String challanNo) async {
    var ur = Uri.parse(AppUrl.addReceipt);
    try {
      var token = PreferenceUtils.getUserToken();
      var session = PreferenceUtils.getString("localSession") == ""
          ? "0"
          : PreferenceUtils.getString("localSession");
      final response2 = await http.post(ur,
          body: json.encode({
            "paymentRecEntryId": 0,
            "challanNo": challanNo,
            "mobileNo": mobile,
            "paymodeId": paymode,
            "amount": amount,
            "paymentTag": 1
          }),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
            'Authorization': 'Bearer $token',
          });
      return Response(
        statusCode: response2.statusCode,
        body: response2.body,
      );
    } on SocketException catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }
}
