import 'package:evently/core/constant/app_assets.dart';
import 'package:evently/core/manager/app_provider.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/modules/authentication/manager/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<AppProvider>(context);
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: provider.themeMode== ThemeMode.light ?AppColors.black:AppColors.purple,
        title: const Text("Forget Password",style:
        TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22
        ),),
      ),
      body:ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: Consumer<AuthProvider>(
          builder: (context, prov, child) {
            return Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      Center(child: Image.asset(AppAssets.forget_password)),
                      const SizedBox(height: 24,),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextFormField(
                          controller: prov.emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: provider.themeMode == ThemeMode.light
                                        ? AppColors.gray
                                        : AppColors.purple),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: provider.themeMode == ThemeMode.light
                                        ? AppColors.gray
                                        : AppColors.purple),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: provider.themeMode == ThemeMode.light
                                        ? AppColors.gray
                                        : AppColors.purple),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              prefixIcon: Icon(
                                Icons.mail,
                                color: provider.themeMode == ThemeMode.light
                                    ? null
                                    : AppColors.lightBg,
                              ),
                              labelText: "Email",labelStyle: TextStyle(color: provider.themeMode == ThemeMode.light
                              ? null
                              : AppColors.lightBg,)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.purple,
                                      padding: const EdgeInsets.all(16),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16))),
                                  onPressed: () {
                                    prov.resetPassword(context);
                                  },
                                  child: Text(
                                    "Reset Password",
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                        color: AppColors.lightBg,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            );
          } ,
        ),
      ),
    );
  }
}
