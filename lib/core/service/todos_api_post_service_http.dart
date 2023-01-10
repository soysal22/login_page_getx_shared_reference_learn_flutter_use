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

    log("  response.statusCode  : ${response.statusCode} "); // giriş başarılı mı değil mi görebilmek için yaptım

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);

      var map = LoginModel.fromJson(decode);

      if (checkboxController.CheckBool.value == true) {
        //kullanıcının sürekli olarak giriş ekranını görmesini önlemek için yaptım bunu

        log("Kullanıcı Kaydı Yapıldı ");
        log("gelen token  : ${map.token} ");

        prefs.setString(
            'savedTokens', map.token!); // token shared reference a kaydettim s

        log(" shared a kaydedilen tokens : ${prefs.getString('savedTokens')}");
      } else {
        // kullanıcı kayıtlı kalmasını istemiyorsa tekrardan shared ın içini boşaltması için yazdım
        log("Kullanıcı Kaydedilmedi ");
        prefs.clear(); // shared ın içini boşaltmaya yardımcı olur
        log(" shared a kaydedilen tokens : ${prefs.getString('savedTokens')}");
      }

      return map;
    }
  }
}
