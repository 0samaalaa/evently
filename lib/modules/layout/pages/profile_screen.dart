import 'package:evently/core/app_routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/app_assets.dart';
import '../../../core/manager/app_provider.dart';
import '../../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: provider.themeMode == ThemeMode.light
            ? AppColors.purple
            : AppColors.darkBg,
        toolbarHeight: 180,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60),
          ),
        ),
        leadingWidth: double.infinity,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    height: 124,
                    width: 124,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppAssets.routee),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            bottomRight: Radius.circular(1000),
                            bottomLeft: Radius.circular(1000),
                            topRight: Radius.circular(1000))),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser?.displayName ?? "",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.lightBg,
                            fontFamily: GoogleFonts.inter().fontFamily),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser?.email ?? "",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightBg,
                            fontFamily: GoogleFonts.inter().fontFamily),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Language",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  color: provider.themeMode == ThemeMode.light
                      ? AppColors.black
                      : AppColors.lightBg),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.purple, width: 2),
              ),
              child: DropdownButton(
                underline: const SizedBox(),
                isExpanded: true,
                value: provider.lang,
                icon: const Icon(
                  Icons.arrow_drop_down_rounded,
                  color: AppColors.purple,
                ),
                iconSize: 40,
                dropdownColor: provider.themeMode == ThemeMode.light
                    ? AppColors.lightBg
                    : AppColors.darkBg,
                style: TextStyle(
                    color: AppColors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: GoogleFonts.inter().fontFamily),
                items: const [
                  DropdownMenuItem(
                    value: "ar",
                    child: Text(
                      "Arabic",
                    ),
                  ),
                  DropdownMenuItem(
                    value: "en",
                    child: Text("English"),
                  ),
                ],
                onChanged: (value) {
                  provider.changeLanguage(value);
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Theme",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  color: provider.themeMode == ThemeMode.light
                      ? AppColors.black
                      : AppColors.lightBg),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.purple, width: 2),
              ),
              child: DropdownButton(
                underline: const SizedBox(),
                isExpanded: true,
                value: provider.themeMode,
                icon: const Icon(
                  Icons.arrow_drop_down_rounded,
                  color: AppColors.purple,
                ),
                iconSize: 40,
                dropdownColor: provider.themeMode == ThemeMode.light
                    ? AppColors.lightBg
                    : AppColors.darkBg,
                style: TextStyle(
                    color: AppColors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: GoogleFonts.inter().fontFamily),
                items: const [
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text(
                      "Light",
                    ),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text("Dark"),
                  ),
                ],
                onChanged: (value) {
                  provider.changeTheme(value);
                },
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    const Icon(Icons.logout,color: AppColors.lightBg,),
                    const SizedBox(width: 8,),
                    Text(
                      "Logout",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.lightBg,
                          fontWeight: FontWeight.w500,
                          fontFamily: GoogleFonts.inter().fontFamily),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
