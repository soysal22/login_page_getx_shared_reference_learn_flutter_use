import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_page_controller/core/constants/constants.dart';
import 'package:login_page_controller/view/home_page.dart';
import 'package:login_page_controller/view/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    /*  
        "email": "eve.holt@reqres.in",
        "password": "cityslicka"
      */

    if (savedTokens == null) {
      Future.delayed(const Duration(milliseconds: 4), () {
        Get.to(
          () => const LoginPage(),
        );
        log(savedTokens ?? "boşşşşş");
      });
    } else {
      Future.delayed(const Duration(milliseconds: 4), () {
        Get.to(
          () => const HomePage(),
        );
        log(savedTokens ?? "Doluuu    : $savedTokens ");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.colorGrey,
      body: const Center(
          child: Text(
        "Hoşgelginiz",
        style: TextStyle(fontSize: 30, color: Constants.colorWhite),
      )),
    );
  }
}
