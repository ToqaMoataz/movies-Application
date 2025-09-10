import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Core/MVVM%20Base/base.dart';
import 'package:provider/provider.dart';

import '../../../../Core/Theme/app_colors.dart';
import '../../../../Core/assets/App Components/widgets.dart';
import '../Login Screen/login_screen.dart';
import 'forget_password_connector.dart';
import 'forget_password_viewModel.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = "forgetPasswordScreen";
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends BaseView<ForgetPasswordScreen,ForgetPasswordViewModel> implements ForgetPasswordConnector {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Forget Password"),
          leading: IconButton(icon:Icon(Icons.arrow_back),onPressed: (){
            Navigator.pop(context);
          },),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            spacing: 24.h,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(image: AssetImage("assets/images/Forgot password-bro 1.png")),
              Container(
                height: 56.h,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: AppColors.getPrimaryColor()
                ),
                child: Row(
                  children: [
                    Icon(Icons.mail_rounded, color: AppColors.getIconColor()),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: TextField(
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: AppColors.getPrimaryTextColor(),
                        ),
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: AppColors.getPrimaryTextColor(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                   viewModel.sendPasswordResetEmail(_emailController.text);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      color: AppColors.getAccentColor(),
                      borderRadius: BorderRadius.circular(15.r)
                  ),
                  child: Text(
                    "Verify Email",
                    style: GoogleFonts.roboto(
                      fontSize: 20.sp,
                      color: AppColors.getSecondaryTextColor(),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  ForgetPasswordViewModel initializeViewModel() {
    return ForgetPasswordViewModel();
  }

  @override
  goToSignIn({String? message}) {
    AppWidgets.successDialogWidget(
      context,
      message: message,
      onComplete: () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
    );
  }




}
