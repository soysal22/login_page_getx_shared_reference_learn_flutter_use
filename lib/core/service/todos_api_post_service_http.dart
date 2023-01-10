// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print, body_might_complete_normally_nullable, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:login_page_controller/core/constants/constants.dart';
import 'package:login_page_controller/core/models/login_model.dart';
import 'package:login_page_controller/view/login_page.dart';
import 'package:login_page_controller/view/splash_page.dart';

class TodosApiPostService extends GetxController {
  Future<LoginModel?> LoginCall(
      {required BuildContext context, String? email, String? password}) async {
    log("email :  ${email!}");
    log("password :  ${password!}");

    var uri = Uri.parse(Constants.LOGIN_URL);

    var response =
        await http.post(uri, body: ({'email': email, 'password': password}));

    log("  response.statusCode  : ${response.statusCode} ");

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);

      var map = LoginModel.fromJson(decode);

      /*  
        "email": "eve.holt@reqres.in",
        "password": "cityslicka"
      */

      if (checkboxController.CheckBool.value == true) {
        log("gelen token  : ${map.token} ");

        prefs.setString('savedTokens', map.token ?? "");

        return map;
      }
    }
  }
}
