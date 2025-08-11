import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:evently/core/app_routes/app_routes.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/modules/firebase_manager/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  UserCredential? user;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> createAccount(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.transparent,
            title: Center(
                child: CircularProgressIndicator(
              color: AppColors.purple,
            )),
          );
        },
      );
      try {
        user = await FirebaseAuthManager.createAccount(
            mail: emailController.text,
            password: passwordController.text,
            name: nameController.text);
        Navigator.pop(context);
        if (user?.user != null) {
          const snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'success login',
              message: "Hi",
              contentType: ContentType.success,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.LayoutScreen,
            (route) => false,
          );
        } else {
          const snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'ops..',
              message: "try again",
              contentType: ContentType.failure,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> login(BuildContext context) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          title: Center(
              child: CircularProgressIndicator(
            color: AppColors.purple,
          )),
        );
      },
    );
    try {
      user = await FirebaseAuthManager.login(
        mail: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
      if (user?.user != null) {
        const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'success login',
            message: "Hi",
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.LayoutScreen,
          (route) => false,
        );
      } else {
        const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'ops..',
            message: "Invalid Email or Password",
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
    await FirebaseAuthManager.resetPassword(mail: emailController.text);
    Navigator.pop(context);
    const snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Success Send',
        message: "Check Your Email",
        contentType: ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
