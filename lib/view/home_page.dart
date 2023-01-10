import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_page_controller/core/constants/constants.dart';
import 'package:login_page_controller/view/login_page.dart';
import 'package:login_page_controller/view/splash_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.colorGrey,
      appBar: _appBarDesign(),
      body: Center(
        child: Column(
          children: [
            _cliprrectImage(),
            Constants.sizedBoxHeight20,
            _title(),
          ],
        ),
      ),
    );
  }

  TextTitle _title() {
    return const TextTitle(
        title:
            "This App  designer I am\nİbrahim Halil Soysal\nisoysal12@gmail.com\nPhone : 0507 597 82 22");
  }

  ClipRRect _cliprrectImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(500),
      child: Image.asset(
        height: 400,
        width: 400,
        alignment: Alignment.topRight,
        Constants.homeImage,
        fit: BoxFit.cover,
      ),
    );
  }

  AppBar _appBarDesign() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 100,
      backgroundColor: Constants.colorGrey,
      centerTitle: true,
      title: const TextTitle(title: "Welcome to Home Page"),
      actions: [
        GestureDetector(
          onTap: () {
            log("Kullanıcı Çıkış Yaptı ");
            prefs.setString('savedTokens', '');
            Get.to(() => const LoginPage());
          },
          child: const Icon(
            size: 25,
            Icons.logout,
            color: Constants.colorWhite,
          ),
        )
      ],
    );
  }
}

class TextTitle extends StatelessWidget {
  const TextTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline4?.copyWith(
            color: Constants.colorGreen,
            fontSize: 30,
            fontWeight: FontWeight.bold));
  }
}
