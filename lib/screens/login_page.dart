import 'package:flutter/material.dart';
import 'package:pdfx_viewer/app_bars/appbar_toggle.dart';
import 'package:pdfx_viewer/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:pdfx_viewer/utils/my_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double boxMargin;
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    boxMargin = kIsWeb ? 150 : 20;
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void delegate(String login, String password) {
    if (login == Constants.loginUser && password == Constants.passwordUser) {
      kIsWeb
          ? Get.toNamed(MyRoutes.machine)
          : Navigator.pushNamed(context, MyRoutes.machine);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb ? null : const AppBarToggle(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          Container(
            height: 150.0,
            width: 180.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
            ),
            child: Center(
              child: Image.asset('assets/logo.png'),
            ),
          ),
          const Spacer(flex: 1),
          Padding(
            padding: EdgeInsets.fromLTRB(boxMargin, 10.0, boxMargin, 10.0),
            child: TextField(
              controller: loginController,
              onSubmitted: (value) {
                delegate(loginController.text, passwordController.text);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.person,
                ),
                labelText: 'User Name',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(boxMargin, 10.0, boxMargin, 10.0),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              onSubmitted: (value) {
                delegate(loginController.text, passwordController.text);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.vpn_key,
                ),
                labelText: 'Password',
              ),
            ),
          ),
          const Spacer(flex: 1),
          Container(
            height: 50,
            width: 180,
            decoration: BoxDecoration(
                color: Constants.mainColor,
                borderRadius: BorderRadius.circular(20)),
            child: ElevatedButton(
              onPressed: () {
                delegate(loginController.text, passwordController.text);
              },
              child: Text(
                'Login',
                style: TextStyle(color: Constants.txtColor, fontSize: 25),
              ),
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
