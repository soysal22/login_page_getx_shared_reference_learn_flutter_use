// ignore_for_file: avoid_print, unrelated_type_equality_checks, unused_element, unnecessary_brace_in_string_interps

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:login_page_controller/core/constants/constants.dart';
import 'package:get/get.dart';
import 'package:login_page_controller/core/controller/checkBox_controller.dart';
import 'package:login_page_controller/core/controller/obsource_text_controller.dart';
import 'package:login_page_controller/core/controller/login_controller.dart';
import 'package:login_page_controller/core/mixins/validation_mixin.dart';
import 'package:login_page_controller/core/service/todos_api_post_service_http.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final LoginController textFieldController = Get.put(LoginController());
final CheckBoxController checkboxController = Get.put(CheckBoxController());
final ObsourceTextController obsourcetext = Get.put(ObsourceTextController());
final TodosApiPostService serviceController = Get.put(TodosApiPostService());

final formKey = GlobalKey<FormState>();

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
late SharedPreferences prefs;
String? savedTokens;

class _LoginPageState extends State<LoginPage> {
  getValue() async {
    prefs = await _prefs;
    savedTokens = prefs.getString('savedTokens');
  }

  @override
  void initState() {
    getValue();
    super.initState();
  }

  /*  
        "email": "eve.holt@reqres.in",
        "password": "cityslicka"
      */
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: null,
        backgroundColor: Constants.colorGrey,
        extendBody: true,
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [_title(context)],
                    )),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      _emailCardTextfield(),
                      Constants.sizedBoxHeight20,
                      _passwordCardTextfield(),
                      Constants.sizedBoxHeight20,
                      _rowCheckBoxAnfForgetText(context),
                      Constants.sizedBoxHeight20,
                      _loginButton(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Checkbox _checkBox() {
    return Checkbox(
      tristate: true,
      value: checkboxController.CheckBool.value,
      activeColor: Colors.orange,
      onChanged: (newBool) {
        setState(() {
          checkboxController.CheckBool.value =
              !checkboxController.CheckBool.value;
          log("checkBoxController.CheckBool.value  :  ${checkboxController.CheckBool.value}");
        });
      },
    );
  }

  CupertinoButton _loginButton(BuildContext context) {
    return CupertinoButton.filled(
      /*  
        "email": "eve.holt@reqres.in",
        "password": "cityslicka"
      */
      onPressed: () async {
        if (formKey.currentState?.validate() == true) {
          textFieldController.fecthLogin(context);
        }
      },
      child: _buttonText(context),
    );
  }

  Row _rowCheckBoxAnfForgetText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [_checkBox(), _rememberText(context)],
        ),
        _forgetTextButton(context)
      ],
    );
  }

  Text _title(BuildContext context) {
    return Text(
      "Welcome To Login Page ",
      style: Theme.of(context)
          .textTheme
          .headline5
          ?.copyWith(color: Constants.colorWhite, fontWeight: FontWeight.bold),
    );
  }

  Card _passwordCardTextfield() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Center(
          child: TextFormField(
            validator: ValidationMixin().validatePassword,
            keyboardType: TextInputType.name,
            obscureText: obsourcetext.checkObsourceText.value,
            controller: textFieldController.passwordcontroller,
            decoration: InputDecoration(
                hintText: "Please Write to a Password ",
                suffixIcon: GestureDetector(
                  onTap: () {
                    obsourcetext.checkObsourceText.value =
                        !obsourcetext.checkObsourceText.value;
                    print(
                        "obsourceTextCheckedcontroller ın değeri  :  ${obsourcetext.checkObsourceText.value}");
                  },
                  child: obsourcetext.checkObsourceText.value
                      ? const Icon(
                          Icons.remove_red_eye,
                          size: 30,
                        )
                      : const Icon(
                          Icons.close_rounded,
                          size: 30,
                        ),
                ),
                labelText: "Passsword "),
          ),
        ),
      ),
    );
  }

  Card _emailCardTextfield() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Center(
          child: TextFormField(
            validator: ValidationMixin().validateEmailName,
            keyboardType: TextInputType.emailAddress,
            controller: textFieldController.emailcontroller,
            decoration: const InputDecoration(
                hintText: "Please Write to an Email ",
                suffixIcon: Icon(
                  Icons.email_sharp,
                  size: 30,
                ),
                labelText: "Email"),
          ),
        ),
      ),
    );
  }

  Text _rememberText(BuildContext context) {
    return Text(
      "Remember Me !",
      style: Theme.of(context)
          .textTheme
          .subtitle1
          ?.copyWith(color: Constants.colorWhite, fontWeight: FontWeight.bold),
    );
  }

  TextButton _forgetTextButton(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Text(
          "Forget to Password ?",
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: Constants.colorBlue, fontWeight: FontWeight.bold),
        ));
  }

  Text _buttonText(BuildContext context) {
    return Text(
      "Login",
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
          color: Constants.colorWhite,
          fontSize: 25,
          fontWeight: FontWeight.bold),
    );
  }
}
