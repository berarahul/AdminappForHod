import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/RhelperFunction.dart';
import '../../../constant/RspacingStyle.dart';
import '../../../constant/sizes.dart';
import 'Widgets/LoginForm.dart';
import 'Widgets/LoginHeader.dart';



class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final dark = RHelperFunction.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: RSpacingStyle.paddingwithAppbarheight,
          child: Column(
            children: [
              // Logo Title and Sub-title
              Login_header(dark: dark),
              const SizedBox(height: RSizes.lg),
              Form(
                child: Login_form(usernameController: usernameController, passwordController: passwordController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

