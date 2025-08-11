import 'package:animate_do/animate_do.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/core/app_routes/app_routes.dart';
import 'package:evently/core/constant/app_assets.dart';
import 'package:evently/core/manager/app_provider.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: FadeIn(
        duration: const Duration(seconds: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInLeftBig(
                    delay: const Duration(milliseconds: 2),
                    child: Image.asset(
                      AppAssets.splashLogo,
                      height: 159,
                      width: 50,
                    )),
                const SizedBox(
                  width: 8,
                ),
                FadeInRightBig(
                  delay: const Duration(milliseconds: 2),
                  child: Text(
                    "Evently",
                    style: TextStyle(
                        fontSize: 36,
                        color: AppColors.purple,
                        fontWeight: FontWeight.w400,
                        fontFamily: GoogleFonts.jockeyOne().fontFamily),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Center(
                child: Image.asset(
                  provider.themeMode == ThemeMode.dark
                      ? AppAssets.onboarding_D_one
                      : AppAssets.onboarding_L_one,
                  width: 361,
                  height: 361,
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              height: 28,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                context.tr.start_tittle,
                style: const TextStyle(
                    color: AppColors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                context.tr.start_desc,
                style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.primaryColorDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  Row(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.tr.language,
                        style: const TextStyle(
                          color: AppColors.purple,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      AnimatedToggleSwitch<String>.rolling(
                        textDirection: TextDirection.ltr,
                        current: provider.lang,
                        values: const ["EN", "AR"],
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
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.tr.theme,
                        style: const TextStyle(
                          color: AppColors.purple,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      AnimatedToggleSwitch<ThemeMode>.rolling(
                        textDirection: TextDirection.ltr,
                        current: provider.themeMode,
                        values: const [ThemeMode.light, ThemeMode.dark],
                        height: 40,
                        indicatorSize: const Size(40, 40),
                        onChanged: (value) {
                          provider.changeTheme(value);
                        },
                        iconList: [
                          Image.asset(
                            AppAssets.sun,
                            color: provider.themeMode == ThemeMode.dark
                                ? AppColors.lightBg
                                : null,
                          ),
                          Image.asset(AppAssets.moon,
                              color: provider.themeMode == ThemeMode.dark
                                  ? AppColors.lightBg
                                  : null),
                        ],
                        style: const ToggleStyle(
                            backgroundColor: Colors.transparent,
                            borderColor: AppColors.purple,
                            indicatorColor: AppColors.purple),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.purple,
                                padding: const EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),),),
                            onPressed: () async {
                              var prefs =
                                  await SharedPreferences.getInstance();
                              var onboarding =
                                  prefs.getBool("onboarding") ?? false;
                              if (onboarding) {
                                provider.setOnTime();
                                Navigator.pushReplacementNamed(
                                    context, AppRoutes.loginPage);
                              } else {
                                Navigator.pushReplacementNamed(
                                    context, AppRoutes.onboardingView);
                              }
                            },
                            child: Text(
                              context.tr.l_start,
                              style: theme.textTheme.bodyLarge!.copyWith(
                                  color: AppColors.lightBg,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
