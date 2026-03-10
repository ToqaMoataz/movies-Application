import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Core/Dependency%20Injection/di.dart';
import 'package:movie_app/Core/assets/App%20Images/app_images.dart';
import 'package:movie_app/Features/Authentication/data/Repository%20Implementation/repo_implemantation.dart';
import 'package:movie_app/Features/Authentication/data/data%20source/data%20source.dart';
import 'package:movie_app/Features/Authentication/domain/Use%20Cases/register_usecase.dart';
import 'package:movie_app/Features/Authentication/persentation/Screens/Regiser%20Screen/Register%20Cubit/cubit.dart';
import 'package:movie_app/Features/Authentication/persentation/Screens/Regiser%20Screen/Register%20Cubit/states.dart';
import 'package:movie_app/Features/HomeScreen/persentation/Home%20Screen/Screen/home_screen.dart';
import '../../../../../../Core/Models/User/user_model.dart';
import '../../../../../../Core/Theme/app_colors.dart';
import '../../Login Screen/Screen/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "registerScreen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
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
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("register_heading".tr())),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => getIt<RegisterCubit>(),
            child: BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state.registerRequestState == RequestState.success) {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                } else if (state.registerRequestState == RequestState.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage ?? "something_went_wrong_text".tr()),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(
                      height: 180.h,
                      child: PageView.builder(
                        controller: PageController(
                          viewportFraction: 0.35,
                          initialPage: state.currentIndex,
                        ),
                        itemCount: state.profileImages.length,
                        onPageChanged: (index) => RegisterCubit.get(context).setUserImage(index),
                        padEnds: true,
                        itemBuilder: (context, index) {
                          double scale = state.currentIndex == index ? 1.0 : 0.7;
                          String imagePath = state.profileImages[index];

                          return TweenAnimationBuilder(
                            duration: const Duration(milliseconds: 300),
                            tween: Tween(begin: scale, end: scale),
                            curve: Curves.easeOutQuart,
                            builder: (context, double value, child) {
                              return Transform.scale(
                                scale: value,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 60.r,
                                      backgroundImage: AssetImage("assets/images/$imagePath.png"),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    SizedBox(height: 10.h),
                                    Visibility(
                                      visible: state.currentIndex == index,
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      child: Text(
                                        state.avatar,
                                        style: GoogleFonts.roboto(
                                          color: AppColors.getPrimaryTextColor(),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                    // Form
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Name TextField
                            _buildInputField(
                              controller: _nameController,
                              hint: "name_text".tr(),
                              icon: Icons.perm_identity,
                              onChanged: (val) => RegisterCubit.get(context).editUserName(val),
                              validator: (value) => (value == null || value.trim().isEmpty) ? "name_required_text".tr() : null,
                            ),
                            SizedBox(height: 20.h),

                            // Email TextField
                            _buildInputField(
                              controller: _emailController,
                              hint: "email_text".tr(),
                              icon: Icons.mail_rounded,
                              validator: (value) {
                                final RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.(com)$');
                                if (value == null || value.isEmpty) return "email_required_text".tr();
                                if (!emailRegex.hasMatch(value)) return "email_not_valid_text".tr();
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),

                            // Password TextField
                            _buildInputField(
                              controller: _passwordController,
                              hint: "password_text".tr(),
                              icon: Icons.lock,
                              isPassword: true,
                              isVisible: state.passwordVisible,
                              onVisibilityToggle: () => RegisterCubit.get(context).toggleVisibility(),
                              validator: (value) {
                                if (value == null || value.isEmpty) return "password_required_text".tr();
                                if (value.length < 6) return "password_min_length_text".tr();
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),

                            // Re-Password TextField
                            _buildInputField(
                              controller: _rePasswordController,
                              hint: "re_password_text".tr(),
                              icon:Icons.lock,
                              isPassword: true,
                              isVisible: state.rePasswordVisible,
                              onVisibilityToggle: () => RegisterCubit.get(context).toggleReVisibility(),
                              validator: (value) {
                                if (value == null || value.isEmpty) return "confirm_password_text".tr();
                                if (value != _passwordController.text) return "passwords_mismatch_text".tr();
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),

                            // Phone TextField
                            _buildInputField(
                              controller: _phoneController,
                              hint: "mobile_number_text".tr(),
                              icon: Icons.phone_android_rounded,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                final RegExp phoneRegex = RegExp(r'^[0-9]{10,15}$');
                                if (value == null || value.trim().isEmpty) return "phone_required_text".tr();
                                if (!phoneRegex.hasMatch(value.trim())) return "phone_min_length_text".tr();
                                return null;
                              },
                            ),
                            SizedBox(height: 30.h),

                            // Register Button
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  UserModel user = UserModel(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      phoneNumber: _phoneController.text,
                                      image: state.selectedImage);
                                  RegisterCubit.get(context).register(
                                      user: user, password: _passwordController.text);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.getAccentColor(),
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                              ),
                              child: Text(
                                "register_heading".tr(),
                                style: GoogleFonts.roboto(
                                  color: AppColors.getSecondaryTextColor(),
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),

                            SizedBox(height: 24.h),

                            // Login Redirect
                            Center(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "already_have_account_text".tr(),
                                      style: GoogleFonts.roboto(color: AppColors.getPrimaryTextColor(), fontSize: 14.sp),
                                    ),
                                    TextSpan(
                                      text: "login_text".tr(),
                                      style: GoogleFonts.roboto(color: AppColors.getAccentColor(), fontSize: 14.sp, fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => Navigator.pushReplacementNamed(context, LoginScreen.routeName),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 24.h),

                            // Language Selector
                            _buildLanguageSelector(context),
                            SizedBox(height: 40.h), // Extra space at bottom
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? onVisibilityToggle,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      constraints: BoxConstraints(minHeight: 56.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.getPrimaryColor(),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.getIconColor()),
          SizedBox(width: 12.w),
          Expanded(
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              validator: validator,
              obscureText: isPassword && !isVisible,
              keyboardType: keyboardType,
              style: GoogleFonts.roboto(fontSize: 16.sp, color: AppColors.getPrimaryTextColor()),
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                hintStyle: GoogleFonts.roboto(color: AppColors.getPrimaryTextColor()),
                errorStyle:TextStyle(height: 0.8),
              ),
            ),
          ),
          if (isPassword)
            IconButton(
              onPressed: onVisibilityToggle,
              icon: Icon(
                isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: AppColors.getIconColor(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    return Center(
      child: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: Container(
          width: 85.w,
          height: 38.h,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: AppColors.getAccentColor()),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _langToggle(context, 'en', AppImages.lr),
              _langToggle(context, 'ar', AppImages.eg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _langToggle(BuildContext context, String langCode, String asset) {
    bool isActive = context.locale.toString() == langCode;
    return InkWell(
      onTap: () => context.setLocale(Locale(langCode)),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.getAccentColor(), width: 2, style: isActive ? BorderStyle.solid : BorderStyle.none),
        ),
        child: ClipOval(child: Image.asset(asset, width: 24, height: 24, fit: BoxFit.cover)),
      ),
    );
  }
}