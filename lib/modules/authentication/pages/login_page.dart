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

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: Consumer<AuthProvider>(
          builder: (context, prov, child) {
            return Scaffold(
              body: Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
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
                                  fontFamily: GoogleFonts.jockeyOne().fontFamily),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          CustomTextFiled(
                            maxLines: 1,
                            controller: prov.emailController,
                            labelText: "Email",
                            prefixIcon: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Image.asset(AppAssets.mail,color: provider.themeMode==ThemeMode.light?AppColors.gray:AppColors.lightBg,
                              height: 26,
                              width: 26,),
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
                            prefixIcon: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Image.asset(AppAssets.lock,color: provider.themeMode==ThemeMode.light?AppColors.gray:AppColors.lightBg,
                                height: 26,
                                width: 26,),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  style: ButtonStyle(
                                    overlayColor: WidgetStatePropertyAll(
                                        AppColors.gray.withOpacity(0.1)),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, AppRoutes.ForgetPasswordScreen);
                                  },
                                  child: Text(
                                    "Forget Password?",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.purple,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: GoogleFonts.inter().fontFamily,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.purple),
                                  )),
                            ],
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
                                            borderRadius: BorderRadius.circular(16))),
                                    onPressed: () {
                                      prov.login(context);
                                    },
                                    child: Text(
                                      "Login",
                                      style: theme.textTheme.bodyLarge!.copyWith(
                                          color: AppColors.lightBg,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don’t Have Account ?",
                                style: TextStyle(
                                    color: provider.themeMode == ThemeMode.light
                                        ? AppColors.black
                                        : AppColors.lightBg,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: GoogleFonts.inter().fontFamily),
                              ),
                              TextButton(
                                  style: ButtonStyle(
                                    overlayColor: WidgetStatePropertyAll(
                                        AppColors.gray.withOpacity(0.1)),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, AppRoutes.RegisterScreen);
                                  },
                                  child: Text(
                                    "Create Account",
                                    style: TextStyle(
                                      color: AppColors.purple,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: GoogleFonts.inter().fontFamily,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.purple,
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                    indent: 15,
                                    endIndent: 15,
                                    color: AppColors.purple,
                                  )),
                              Text(
                                "OR",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Expanded(
                                  child: Divider(
                                    indent: 15,
                                    endIndent: 15,
                                    color: AppColors.purple,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 18,),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        overlayColor: AppColors.gray.withOpacity(0.1),
                                        backgroundColor: theme.scaffoldBackgroundColor,
                                        padding: const EdgeInsets.all(16),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                            side: const BorderSide(color: AppColors.purple))),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          AppAssets.google,height: 26,width: 26,),
                                        const SizedBox(width: 10,),
                                        Text(
                                          textDirection: TextDirection.ltr,
                                          "Login With Google",
                                          style: theme.textTheme.bodyLarge!.copyWith(
                                              color: AppColors.purple,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18,),
                          AnimatedToggleSwitch<String>.rolling(
                            textDirection: TextDirection.ltr,
                            current: provider.lang,
                            values: const ["en", "ar"],
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
                                backgroundColor:Colors.transparent,
                                borderColor: AppColors.purple,
                                indicatorColor: AppColors.purple),
                          ),
                        ],
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
