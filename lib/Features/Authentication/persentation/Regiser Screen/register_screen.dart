import 'dart:ui' as ui;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Core/assets/app_images.dart';
import 'package:movie_app/Core/MVVM%20Base/base.dart';
import 'package:movie_app/Features/Authentication/persentation/Regiser%20Screen/register_connector.dart';
import 'package:movie_app/Features/Authentication/persentation/Regiser%20Screen/register_viewModel.dart';
import 'package:provider/provider.dart';
import '../../../../Core/Models/user_model.dart';
import '../../../../Core/Theme/app_colors.dart';
import '../Login Screen/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "registerScreen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseView<RegisterScreen,RegisterViewModel> implements RegisterConnector {
  String avatar="Avatar";
  int _currentIndex = 0;
  late String _selectedImage;
  final _formKey = GlobalKey<FormState>();

  List<String> profileImages = AppImages.getUserImages();

  bool passwordVisible = false;
  bool rePasswordVisible = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _rePasswordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _selectedImage = profileImages[0];
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
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(title: Text("register_heading".tr())),
        body: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.3,
              child: CarouselSlider(
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  enlargeFactor: 0.4,
                  autoPlay: false,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.4,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                      _selectedImage=profileImages[index];
                    });
                  },
                ),
                items: profileImages.asMap().entries.map((entry) {
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
                              radius: 60,
                              backgroundImage: AssetImage(
                                "assets/images/$imagePath.png",
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(height: 10),
                            if (_currentIndex == index)
                              Text(
                                avatar,
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
            SizedBox(height: 12.h,),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.55,
              child: SingleChildScrollView(
                child: Form(
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
                                    setState(() {
                                      avatar=_nameController.text;
                                    });
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
                                  obscureText: !passwordVisible,
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
                        //create account button
                        GestureDetector(
                          onTap: (){
                            if (_formKey.currentState!.validate()) {
                              UserModel user=UserModel(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  phoneNumber: _phoneController.text,
                                  image: _selectedImage
                              );
                              viewModel.register(
                                user:  user,
                                password: _passwordController.text,
                              );
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
                        // create account
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  goToSignIn() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  @override
  initializeViewModel() {
    return RegisterViewModel();
  }
}
