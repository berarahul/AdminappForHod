
import 'package:attendanceadmin/view/Screens/AdminScreen/AdminScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../constant/AppColors.dart';
import '../../../../constant/RoundButton.dart';
import '../../../../constant/routes/approutes.dart';
import '../../../../constant/sizes.dart';
import '../../../../constant/text_string.dart';
import '../../../../model/login/LoginModel.dart';
import '../../../../viewmodel/service/LoginService/AuthServices.dart';
import '../../../../viewmodel/service/LoginService/LoginController.dart';



class Login_form extends StatelessWidget {
  const Login_form({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    final authService = AuthService(); // Instantiate AuthService

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Username TextFormField
        TextFormField(
          controller: usernameController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.person),
            labelText: RTexts.username,
          ),
        ),
        const SizedBox(height: RSizes.spacebtwInputFields),

        // Password TextFormField
        Obx(
              () => TextFormField(
            controller: passwordController,
            obscureText: loginController.obscureText.value,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.key),
              labelText: RTexts.password,
              suffixIcon: IconButton(
                icon: Icon(
                  loginController.obscureText.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye,
                ),
                onPressed: loginController.togglePasswordVisibility,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),

        // Forget Password Button
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Get.snackbar("Forget Password", "This Features Available on Next Update");
              },
              child: const Text(

                RTexts.Forgetpassword,
                style: TextStyle(fontSize: RSizes.fontSizeLg,color: AppColors.appcolor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 150),

        // Sign In Button
        SizedBox(
          width: double.infinity,
          child: Obx(() {
            return RoundButton(
              height: 45,
              title: 'Login',
              loading: loginController.isLoading.value,
              onPress: () async {
                loginController.setLoading(true);

                String username = usernameController.text.trim();
                String password = passwordController.text.trim();

                try {
                  UserModel? userModel = await authService.login(username, password); // Call the login method with parameters
                  if (userModel != null) {

      Get.to(AdminScreen());


                  } else {
                    // Handle login failure
                    Get.snackbar('Login Failed', 'Invalid credentials');
                  }
                } catch (e) {
                  Get.snackbar('Error', e.toString());
                }

                loginController.setLoading(false);
              },
              width: 160,
            );
          }),
        ),
      ],
    );
  }
}
