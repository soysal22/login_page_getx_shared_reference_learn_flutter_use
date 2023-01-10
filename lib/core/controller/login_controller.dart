import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_page_controller/core/service/todos_api_post_service_http.dart';
import 'package:login_page_controller/view/home_page.dart';

class LoginController extends GetxController {
  final service = TodosApiPostService();

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  fecthLogin(context) async {
    //then içinde apiden veri geliyor

    /*  
        "email": "eve.holt@reqres.in",
        "password": "cityslicka"
      */
    service.LoginCall(
      context: context,
      email: emailcontroller.text,
      password: passwordcontroller.text,
    ).then((value) {
      if (value?.token != null) {
        Future.delayed(const Duration(microseconds: 1), () {
          Get.to(() => const HomePage());
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "Kullanıcı bilgileri Hatalı Lütfen Tekrar Deneyiniz  ...   ",
        )));
      }
    });
  }
}
