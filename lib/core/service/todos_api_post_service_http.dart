// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print, body_might_complete_normally_nullable, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:login_page_controller/core/constants/constants.dart';
import 'package:login_page_controller/core/models/login_model.dart';
import 'package:login_page_controller/view/login_page.dart';

class TodosApiPostService extends GetxController {
  String? tokens;
  Future<LoginModel?> LoginCall(
      {required BuildContext context, String? email, String? password}) async {
    log("email :  ${email!}");
    log("password :  ${password!}");
    /*  
        "email": "eve.holt@reqres.in",
        "password": "cityslicka"
      */

    var uri = Uri.parse(Constants.LOGIN_URL);

    var response =
        await http.post(uri, body: ({'email': email, 'password': password}));

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);

      var map = LoginModel.fromJson(decode);
      tokens = map.token;

      if (checkboxController.CheckBool.value == true &&
          response.statusCode == 200) {
        prefs.setString("savedTokens", map.token ?? "");

        log("savedTokens : $savedTokens ");
      }

      log("Giriş Başarılı  : ${map.token}");

      return map;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Kullanıcı Bilgileri Hatalı Lütfen Tekrar Deneyiniz",
      )));
    }
  }
}
