import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Features/Authentication/data/Repository%20Implementation/repo_implemantation.dart';
import 'package:movie_app/Features/Authentication/data/data%20source/data%20source.dart';
import 'package:movie_app/Features/Authentication/domain/Use%20Cases/forgetPass_usecase.dart';
import 'package:movie_app/Features/Authentication/persentation/Screens/Forget%20Password%20Screen/Forget%20Password%20Cubit/cubit.dart';

import '../../../../../Core/Theme/app_colors.dart';
import '../../../../HomeScreen/persentation/HomeScreen cubit/state.dart';
import '../Login Screen/login_screen.dart';
import 'Forget Password Cubit/states.dart' hide RequestState;



class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = "forgetPasswordScreen";
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            BlocProvider(
              create: (context) => ForgetPassCubit(
                ForgetPasswordUseCase(
                  AuthRepositoryImplementation(AuthDataSource()),
                ),
              ),
              child: BlocConsumer<ForgetPassCubit, ForgetPassState>(
                listener: (context, state) {
                  if (state.forgetPassRequestState == RequestState.success) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginScreen.routeName,
                          (route) => false,
                    );
                  }

                  if (state.forgetPassRequestState == RequestState.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage ?? "Error occurred")),
                    );
                  }
                },
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      ForgetPassCubit.get(context)
                          .forgetPass(_emailController.text);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.getAccentColor(),
                        borderRadius: BorderRadius.circular(15.r),
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
                  );
                },
              ),
            ),


          ],
        ),
      ),
    );
  }






}
