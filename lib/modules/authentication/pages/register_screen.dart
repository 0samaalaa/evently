import 'package:animate_do/animate_do.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/core/app_routes/app_routes.dart';
import 'package:evently/core/constant/app_assets.dart';
import 'package:evently/core/manager/app_provider.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/modules/authentication/manager/auth_provider.dart';
import 'package:evently/modules/authentication/widgets/custom_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    var theme = Theme.of(context);
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: Consumer<AuthProvider>(
          builder: (context, prov, child) {
            return Scaffold(
              appBar: AppBar(
                foregroundColor: provider.themeMode == ThemeMode.light
                    ? AppColors.black
                    : AppColors.purple,
                title: const Text(
                  "Register",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                ),
              ),
              body: Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: prov.formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: ZoomIn(
                                    duration: const Duration(seconds: 2),
                                    child: Image.asset(AppAssets.splashLogo))),
                            ZoomIn(
                              duration: const Duration(seconds: 2),
                              child: Text(
                                "Evently",
                                style: TextStyle(
                                    fontSize: 36,
                                    color: AppColors.purple,
                                    fontWeight: FontWeight.w400,
                                    fontFamily:
                                        GoogleFonts.jockeyOne().fontFamily),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            CustomTextFiled(
                              maxLines: 1,
                              controller: prov.nameController,
                              labelText: "Name",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Can Not Be Empty  ";
                                } else {
                                  return null;
                                }
                              },
                              prefixIcon: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Image.asset(
                                  AppAssets.user,
                                  color: provider.themeMode == ThemeMode.light
                                      ? AppColors.gray
                                      : AppColors.lightBg,
                                  height: 26,
                                  width: 26,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextFiled(
                              maxLines: 1,
                              controller: prov.emailController,
                              labelText: "Email",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Can Not Be Empty";
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return "Invalid Email";
                                } else {
                                  return null;
                                }
                              },
                              prefixIcon: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Image.asset(
                                  AppAssets.mail,
                                  color: provider.themeMode == ThemeMode.light
                                      ? AppColors.gray
                                      : AppColors.lightBg,
                                  height: 26,
                                  width: 26,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextFiled(
                              maxLines: 1,
                              controller: prov.passwordController,
                              labelText: "Password",
                              isPassword: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "can not be empty";
                                }else if(value.length < 8){
                                  return "Passowrd Is Less Than 8 Digits";
                                } else {
                                  return null;
                                }
                              },
                              prefixIcon: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Image.asset(
                                  AppAssets.lock,
                                  color: provider.themeMode == ThemeMode.light
                                      ? AppColors.gray
                                      : AppColors.lightBg,
                                  height: 26,
                                  width: 26,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextFiled(
                              maxLines: 1,
                              controller: prov.rePasswordController,
                              labelText: "Re-Password",
                              isPassword: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "can not be empty";
                                }else if(value.length < 8){
                                  return "Passowrd Is Less Than 8 Digits";
                                }else if(value !=prov.passwordController.text){
                                  return "Password Not Match";
                                }
                                else {
                                  return null;
                                }
                              },
                              prefixIcon: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Image.asset(
                                  AppAssets.lock,
                                  color: provider.themeMode == ThemeMode.light
                                      ? AppColors.gray
                                      : AppColors.lightBg,
                                  height: 26,
                                  width: 26,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.purple,
                                          padding: const EdgeInsets.all(16),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16))),
                                      onPressed: () {
                                        prov.createAccount(context);
                                      },
                                      child: Text(
                                        "Create Account",
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(
                                                color: AppColors.lightBg,
                                                fontWeight: FontWeight.w500),
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already Have Account ?",
                                  style: TextStyle(
                                      color:
                                          provider.themeMode == ThemeMode.light
                                              ? AppColors.black
                                              : AppColors.lightBg,
                                      fontWeight: FontWeight.w500,
                                      fontFamily:
                                          GoogleFonts.inter().fontFamily),
                                ),
                                TextButton(
                                    style: ButtonStyle(
                                      overlayColor: WidgetStatePropertyAll(
                                          AppColors.gray.withOpacity(0.1)),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: AppColors.purple,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        fontFamily:
                                            GoogleFonts.inter().fontFamily,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.purple,
                                      ),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            AnimatedToggleSwitch<String>.rolling(
                              textDirection: TextDirection.ltr,
                              current: provider.lang,
                              values: ["en", "ar"],
                              height: 40,
                              indicatorSize: const Size(40, 40),
                              onChanged: (i) {
                                provider.changeLanguage(i);
                              },
                              iconList: [
                                Image.asset(AppAssets.en),
                                Image.asset(AppAssets.ar),
                              ],
                              style: const ToggleStyle(
                                  backgroundColor: Colors.transparent,
                                  borderColor: AppColors.purple,
                                  indicatorColor: AppColors.purple),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
