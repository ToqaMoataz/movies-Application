import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Core/Models/user_model.dart';
import 'package:movie_app/Features/Update%20and%20Delete%20profile/persentation/components/dialog_to_show.dart';
import 'package:movie_app/Features/Update%20and%20Delete%20profile/persentation/update%20and%20delete%20cubit/cubit.dart';
import 'package:movie_app/Features/Update%20and%20Delete%20profile/persentation/update%20and%20delete%20cubit/states.dart';
import '../../../../Core/Theme/app_colors.dart';
import '../../../Authentication/persentation/Screens/Forget Password Screen/forget_password_screen.dart';
import '../../../Authentication/persentation/Screens/Login Screen/login_screen.dart';
import '../../../HomeScreen/persentation/Home Screen/Screen/home_Screen.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = "updateProfile";

  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context)!.settings.arguments as UserModel;
    final cubit = UpdateProfileCubit.get(context);
    cubit.getUserImage(user);
    nameController.text = user.name;
    phoneController.text = user.phoneNumber;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)?.settings.arguments as UserModel;
    return BlocListener<UpdateProfileCubit, UpdateProfileStates>(
      listener: (context, state) {
        if (UpdateProfileCubit.get(context).state.deleteProfileRequestState ==
            RequestState.success) {
          Navigator.of(
            context,
            rootNavigator: true,
          ).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
        }
        if (UpdateProfileCubit.get(context).state.deleteProfileRequestState ==
            RequestState.error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("error_deleting_account_text".tr())));
        }
        if (UpdateProfileCubit.get(context).state.updateProfileRequestState == RequestState.error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("error_updating_account_text".tr())));
        }
        if (UpdateProfileCubit.get(context).state.updateProfileRequestState == RequestState.success) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      },
      child: BlocBuilder<UpdateProfileCubit, UpdateProfileStates>(
        builder: (context, state) {
          var cubit = UpdateProfileCubit.get(context);

          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(title: Text("pick_avatar_heading".tr())),
            body: Stack(
              children: [
                Opacity(
                  opacity: cubit.state.showDialog ? 0.3 : 1,
                  child: InkWell(
                    onTap: () => cubit.showImagesDialog(false),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 22,
                        horizontal: 16,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: InkWell(
                                onTap: () => cubit.showImagesDialog(true),
                                child: Container(
                                  height: 120.h,
                                  width: 120.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/${cubit.state.selectedImage}.png",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Name TextField inlined
                            Container(
                              height: 56.h,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: AppColors.getPrimaryColor(),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: AppColors.getIconColor(),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: TextField(
                                      controller: nameController,
                                      keyboardType: TextInputType.text,
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20.sp,
                                        color: AppColors.getPrimaryTextColor(),
                                        height: 1.2,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: user.name,
                                        border: InputBorder.none,
                                        hintStyle: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp,
                                          color:
                                              AppColors.getPrimaryTextColor(),
                                          height: 1.2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            // Phone TextField inlined
                            Container(
                              height: 56.h,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: AppColors.getPrimaryColor(),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: AppColors.getIconColor(),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: TextFormField(
                                      controller: phoneController,
                                      keyboardType: TextInputType.phone,
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20.sp,
                                        color: AppColors.getPrimaryTextColor(),
                                        height: 1.2,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: user.phoneNumber,
                                        border: InputBorder.none,
                                        hintStyle: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp,
                                          color:
                                              AppColors.getPrimaryTextColor(),
                                          height: 1.2,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return "phone_required_text".tr();
                                        }
                                        if (value.length < 11) {
                                          return "phone_min_length_text".tr();
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 26.h),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  ForgetPasswordScreen.routeName,
                                );
                              },
                              child: Text(
                                "reset_password_text".tr(),
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.sp,
                                  color: AppColors.getPrimaryTextColor(),
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Delete Button inlined
                                InkWell(
                                  onTap: () =>
                                      _showDeleteDialog(context, cubit),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.getActionColor(),
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    child: Text(
                                      "delete_account_text".tr(),
                                      style: GoogleFonts.roboto(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.getPrimaryTextColor(),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                // Update Button inlined
                                InkWell(
                                  onTap: () => cubit.updateUser(
                                    nameController.text,
                                    phoneController.text,
                                    cubit.state.selectedImage,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.getAccentColor(),
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    child: Text(
                                      "update_data_text".tr(),
                                      style: GoogleFonts.roboto(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            AppColors.getSecondaryTextColor(),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (cubit.state.showDialog)
                  Positioned(
                    bottom: 18,
                    right: 16,
                    left: 16,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .4,
                      child: DialogToShow(),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, UpdateProfileCubit cubit) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.getDarkerPrimaryColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
          side: BorderSide(color: AppColors.getAccentColor(), width: 2),
        ),
        title: Text(
          "delete_account_text".tr(),
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: AppColors.getAccentColor(),
          ),
        ),
        content: Text(
          "delete_account_confirm_text".tr(),
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: AppColors.getPrimaryTextColor(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "cancel_text".tr(),
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.getPrimaryTextColor(),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.of(context).pop();
              cubit.deleteUser();
            },
            child: Text(
              "delete_text".tr(),
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColors.getPrimaryTextColor(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
