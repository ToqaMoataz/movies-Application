import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Core/Theme/app_colors.dart';
import 'package:movie_app/Core/assets/App%20Images/app_images.dart';
import 'package:movie_app/Features/Authentication/persentation/Screens/Login%20Screen/Login%20Cubit/cubit.dart';
import 'package:movie_app/Features/HomeScreen/persentation/Home%20Screen/Screen/home_screen.dart';
import '../../../../../../Core/Dependency Injection/di.dart';
import '../../Forget Password/Screen/forget_password_screen.dart';
import '../../Regiser Screen/Screen/register_screen.dart';
import '../Login Cubit/states.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName="loginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  final _formKey = GlobalKey<FormState>();


  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();


  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (context) => getIt<LoginCubit>(),
        child: BlocConsumer<LoginCubit, LoginState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Logo
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Image(
                        image: AssetImage(AppImages.movieAppIcon),
                        height: 118.h,
                        width: 121.w,
                      ),
                    ),
                    SizedBox(height: 50.h,),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [

                          // Email TextField
                          Container(
                            height: 56.h,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: AppColors.getPrimaryColor(),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.mail_rounded, color: AppColors.getIconColor()),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: TextFormField(
                                    controller: _emailController,
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                      color: AppColors.getPrimaryTextColor(),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "email_text".tr(),
                                      border: InputBorder.none,
                                      hintStyle: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp,
                                        color: AppColors.getPrimaryTextColor(),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "email_required_text".tr();
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 22.h),

                          // Password TextField
                          Container(
                            height: 56.h,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: AppColors.getPrimaryColor(),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.lock, color: AppColors.getIconColor()),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: TextFormField(
                                    controller: _passwordController,
                                    obscureText: !state.passVisible,
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                      color: AppColors.getPrimaryTextColor(),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "password_text".tr(),
                                      border: InputBorder.none,
                                      hintStyle: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: AppColors.getPrimaryTextColor(),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "password_required_text";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                   LoginCubit.get(context).togglePassVisibility();
                                  },
                                  icon: Icon(
                                    state.passVisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.getIconColor(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: (){
                              Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
                            },
                            child: Text(
                              "forget_password_text".tr(),
                              style: GoogleFonts.roboto(
                                color: AppColors.getAccentColor(),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                              ),
                            )
                        ),
                      ],
                    ),
                    //login button
                    GestureDetector(
                      onTap: (){
                        if(_formKey.currentState!.validate()){
                          LoginCubit.get(context).login(email: _emailController.text, password: _passwordController.text);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            color: AppColors.getAccentColor(),
                            borderRadius: BorderRadius.circular(15.r)
                        ),
                        child: Text(
                          "login_text".tr(),
                          style: GoogleFonts.roboto(
                            fontSize: 20.sp,
                            color: AppColors.getSecondaryTextColor(),
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height:22.h,),
                    // create account
                    Align(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: "no_account_text".tr(),
                                style: GoogleFonts.roboto(
                                  color:AppColors.getPrimaryTextColor(),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                )
                            ),
                            TextSpan(
                              text: "create_account_text".tr(),
                              style: GoogleFonts.roboto(
                                color: AppColors.getAccentColor(),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w900,
                                height: 1.h,
                                letterSpacing: 0,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, RegisterScreen.routeName);
                                },
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height:28.h,),
                    // --- Or separator Row ---
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Color(0XFFF6BD00),
                            thickness: 1,
                            indent: 20,
                            endIndent: 10,
                          ),
                        ),
                        Text(
                          "or_text".tr(),
                          style: TextStyle(
                            color: AppColors.getAccentColor(),
                            fontSize: 16.sp,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.getAccentColor(),
                            thickness: 1,
                            indent: 10,
                            endIndent: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:28.h,),
                    //Google login
                    InkWell(
                      onTap: (){
                        LoginCubit.get(context).loginWithGoogle();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.getAccentColor(),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(AppImages.googleIcon),
                              height: 24,
                              width: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "google_login_text".tr(),
                              style: TextStyle(
                                  color: AppColors.getSecondaryTextColor(),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 34.h,),
                    //select Language
                    Align(
                      alignment: Alignment.center,
                      child: Directionality(
                        textDirection: ui.TextDirection.ltr,
                        child: Container(
                          width: 75,
                          height: 32,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: AppColors.getAccentColor(),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  context.setLocale(Locale('en'));
                                },
                                borderRadius: BorderRadius.circular(100.r),
                                child: Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.getAccentColor(),
                                      width: 2,
                                      style: (context.locale.toString()=='en') ? BorderStyle.solid : BorderStyle.none,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      AppImages.lr,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.setLocale(Locale('ar'));
                                },
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.getAccentColor(),
                                      width: 2,
                                      style: (context.locale.toString()=='ar') ? BorderStyle.solid : BorderStyle.none,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      AppImages.eg,
                                      fit: BoxFit.cover,
                                      width: 22,
                                      height: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {
            if(state.loginRequestState==RequestState.success || state.loginWithGoogleRequestState==RequestState.success){
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            }
            else if(state.loginRequestState==RequestState.error||state.loginWithGoogleRequestState==RequestState.error){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage ?? "something_went_wrong_text".tr(),
                    style: TextStyle(color: AppColors.getAccentColor()),
                  ),
                  backgroundColor: Colors.black,
                ),
              );
            }
          },
        ),
      ),

    );
  }



}
