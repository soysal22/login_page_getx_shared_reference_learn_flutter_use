// ignore_for_file: unused_element, unused_local_variable

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_page_controller/core/constants/constants.dart';
import 'package:login_page_controller/view/home_page.dart';
import 'package:login_page_controller/view/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
late SharedPreferences prefs;

String? finalToken = "";

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getValue().whenComplete(() async {
      Future.delayed(const Duration(microseconds: 8), () {
        finalToken == ""
            ? Get.to(() => const LoginPage())
            : Get.to(() => const HomePage());
      });
    });
    super.initState();
    /* 
       "email": "eve.holt@reqres.in"
        "password": "cityslicka"
      */
  }

  Future getValue() async {
    prefs = await _prefs;

    // finalToken = "";
    var gelenToken = prefs.getString('savedTokens');
    setState(() {
      finalToken = gelenToken;
    });

    log("final Token: $finalToken");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.colorGrey,
      body: const Center(
          child: Text(
        "Hoşgeldiniz ... ",
        style: TextStyle(fontSize: 30, color: Constants.colorWhite),
      )),
    );
  }
}
