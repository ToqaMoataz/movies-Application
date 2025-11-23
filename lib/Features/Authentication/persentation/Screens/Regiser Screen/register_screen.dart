import 'dart:ui' as ui;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Core/assets/app_images.dart';
import 'package:movie_app/Features/Authentication/data/Repository%20Implementation/repo_implemantation.dart';
import 'package:movie_app/Features/Authentication/data/data%20source/data%20source.dart';
import 'package:movie_app/Features/Authentication/domain/Use%20Cases/register_usecase.dart';
import 'package:movie_app/Features/Authentication/persentation/Screens/Regiser%20Screen/Register%20Cubit/cubit.dart';
import 'package:movie_app/Features/Authentication/persentation/Screens/Regiser%20Screen/Register%20Cubit/states.dart';
import 'package:movie_app/Features/HomeScreen/persentation/Home%20Screen/home_Screen.dart';
import '../../../../../Core/Models/user_model.dart';
import '../../../../../Core/Theme/app_colors.dart';
import '../Login Screen/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "registerScreen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool passwordVisible = false;
  bool rePasswordVisible = false;

  final _formKey = GlobalKey<FormState>();


  late TextEditingController _nameController ;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _rePasswordController;
  late TextEditingController _phoneController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _rePasswordController = TextEditingController();
   _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("register_heading".tr())),
      body: SafeArea(
        child: SingleChildScrollView(
          //physics: CarouselScrollPhysics(),
          child: BlocProvider(
            create: (context) => RegisterCubit(RegisterUseCase(AuthRepositoryImplementation(AuthDataSource()))),
            child: BlocConsumer<RegisterCubit,RegisterState>(
              builder: (context, state) {
                 return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 161.h,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            enlargeFactor: 0.4,
                            autoPlay: false,
                            enableInfiniteScroll: true,
                            viewportFraction: 0.4,
                            onPageChanged: (index, reason) {
                              RegisterCubit.get(context).setUserImage(index);
                            },
                          ),
                          items: state.profileImages.asMap().entries.map((entry) {
                            int index = entry.key;
                            String imagePath = entry.value;
                            return Builder(
                              builder: (BuildContext context) {
                                return Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 60.r,
                                        backgroundImage: AssetImage(
                                          "assets/images/$imagePath.png",
                                        ),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      SizedBox(height: 10),
                                        if(state.currentIndex==index)
                                        Text(
                                          state.avatar,
                                          style: GoogleFonts.roboto(
                                              color: AppColors.getPrimaryTextColor(),
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      // SizedBox(height: 12.h,),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              //name text field
                              Container(
                                height: 56.h,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: AppColors.getPrimaryColor(),
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.perm_identity, color: AppColors.getIconColor()),
                                    SizedBox(width: 5.w,),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _nameController,
                                        onChanged: (val){
                                          RegisterCubit.get(context).editUserName(val);

                                        },
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp,
                                          color: AppColors.getPrimaryTextColor(),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return "Name is required";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "name_text".tr(),
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
                              SizedBox(height: 24.h,),
                              // Email TextField
                              Container(
                                height: 56.h,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: AppColors.getPrimaryColor()
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.mail_rounded, color: AppColors.getIconColor()),
                                    SizedBox(width: 5.w),
                                    Expanded(
                                      child: TextFormField(
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp,
                                          color: AppColors.getPrimaryTextColor(),
                                        ),
                                        validator: (value) {
                                          final RegExp emailRegex = RegExp(
                                            r'^[\w\.-]+@[\w\.-]+\.(com)$',
                                          );
                                          if (value == null || value.isEmpty) {
                                            return "Email is required";
                                          } else if (!emailRegex.hasMatch(value)) {
                                            return "Email is not valid";
                                          }
                                          return null;
                                        },
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                          hintText: "email_text".tr(),
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
                              SizedBox(height: 24.h,),
                              // Password text field
                              Container(
                                height: 56.h,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: AppColors.getPrimaryColor()
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.lock, color: AppColors.getIconColor()),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: TextFormField(
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp,
                                          color: AppColors.getPrimaryTextColor(),
                                        ),
                                        controller: _passwordController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Password is required";
                                          } else if (value.length < 6) {
                                            return "Password must be at least 6 characters";
                                          }
                                          return null;
                                        },
                                        obscureText: !passwordVisible,
                                        decoration: InputDecoration(
                                          hintText: "password_text".tr(),
                                          border: InputBorder.none,
                                          hintStyle: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.sp,
                                            color: AppColors.getPrimaryTextColor(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          passwordVisible = !passwordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        passwordVisible
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color:  AppColors.getIconColor(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 24.h,),
                              // Re Password TextField
                              Container(
                                height: 56.h,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: AppColors.getPrimaryColor(),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.lock, color:  AppColors.getIconColor()),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: TextFormField(
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp,
                                          color: AppColors.getPrimaryTextColor(),
                                        ),
                                        controller: _rePasswordController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Confirm your password";
                                          } else if (value != _passwordController.text) {
                                            return "Passwords do not match";
                                          }
                                          return null;
                                        },
                                        obscureText: !rePasswordVisible,
                                        decoration: InputDecoration(
                                          hintText: "re_password_text".tr(),
                                          border: InputBorder.none,
                                          hintStyle: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.sp,
                                            color: AppColors.getPrimaryTextColor(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          rePasswordVisible = !rePasswordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        rePasswordVisible
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color:  AppColors.getIconColor(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 24.h,),
                              //phone text field
                              Container(
                                height: 56.h,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: AppColors.getPrimaryColor()
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.phone_android_rounded,
                                      color: AppColors.getIconColor(),
                                    ),
                                    SizedBox(width: 5.w),
                                    Expanded(
                                      child: TextFormField(
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp,
                                          color: AppColors.getPrimaryTextColor(),
                                        ),
                                        controller: _phoneController,
                                        keyboardType: TextInputType.phone,
                                        validator: (value) {
                                          final RegExp phoneRegex = RegExp(
                                            r'^[0-9]{10,15}$',
                                          );
                                          if (value == null || value.trim().isEmpty) {
                                            return "Phone number is required";
                                          } else if (!phoneRegex.hasMatch(value.trim())) {
                                            return "Enter a valid phone number";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Phone Number",
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
                              SizedBox(height: 24.h,),
                              //Register button
                              GestureDetector(
                                onTap: (){
                                  if (_formKey.currentState!.validate()) {
                                    UserModel user=UserModel(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        phoneNumber: _phoneController.text,
                                        image: state.selectedImage
                                    );
                                    RegisterCubit.get(context).register(user: user, password: _passwordController.text);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    color: AppColors.getAccentColor(),
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: Text(
                                    "register_heading".tr(),
                                    style: GoogleFonts.roboto(
                                      color: AppColors.getSecondaryTextColor(),
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w400,
                                      height: 1.h,
                                      letterSpacing: 0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(height: 24.h,),
                              // Login
                              Align(
                                alignment: Alignment.center,
                                child: Text.rich(
                                  TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "already_have_account_text".tr(),
                                        style: GoogleFonts.roboto(
                                          color: AppColors.getPrimaryTextColor(),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          height: 1.h,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "login_text".tr(),
                                        style: GoogleFonts.roboto(
                                          color: AppColors.getAccentColor(),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w900,
                                          height: 1.h,
                                          letterSpacing: 0,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              LoginScreen.routeName,
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 24.h,),
                              //Language section
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
                                            setState(() {

                                            });
                                          },
                                          borderRadius: BorderRadius.circular(100),
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
                                                "assets/images/LR.png",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            context.setLocale(Locale('ar'));
                                            setState(() {

                                            });
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
                                                "assets/images/EG.png",
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
                      ),
                    ],
                  );
              },
              listener: (context, state) {
                  if(state.registerRequestState==RequestState.success){
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  }
                  else if(state.registerRequestState==RequestState.error){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage ??"No Error"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
              }
            ),
          ),
        
        ),
      ),
    );
  }

}
