import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Core/Theme/app_colors.dart';
import 'package:movie_app/Core/assets/App%20Components/movie_card.dart';
import 'package:movie_app/Core/assets/App%20Images/app_images.dart';
import '../../../../../Authentication/persentation/Screens/Login Screen/Screen/login_screen.dart';
import '../../../../../Update and Delete profile/persentation/Update Profile Screen/update_profile_screen.dart';
import '../../../HomeScreen cubit/cubit.dart';
import '../../../HomeScreen cubit/state.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileTab>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<HomeCubit, HomeStates>(
          listener: (context, state) {
            if (HomeCubit.get(context).state.signOutRequestState ==
                RequestState.success) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                LoginScreen.routeName,
                (route) => false,
              );
            } else if (HomeCubit.get(context).state.signOutRequestState ==
                RequestState.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("sign_out_failed_text".tr()),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<HomeCubit, HomeStates>(
            builder: (context, state) {
              var cubit = HomeCubit.get(context);
              var user = cubit.state.user;
              if (cubit.state.profileMoviesRequestState ==
                      RequestState.loading ||
                  cubit.state.historyMoviesRequestState ==
                      RequestState.loading ||
                  cubit.state.toWatchMoviesRequestState ==
                      RequestState.loading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.getAccentColor(),
                  ),
                );
              } else if (cubit.state.profileMoviesRequestState ==
                  RequestState.success) {
                if (user == null) {
                  return Center(
                    child: Text(
                      "no_user_signed_in_text".tr(),
                      style: GoogleFonts.roboto(
                        fontSize: 24.sp,
                        color: AppColors.getAccentColor(),
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: cubit.state.isVisible,
                        child: Container(
                          color: AppColors.getDarkerPrimaryColor(),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 50.r,
                                          child: ClipOval(
                                            child: Image.asset(
                                              "assets/images/${user.image}.png",
                                              width: 100.w,
                                              height: 100.h,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 6.h),
                                        Text(
                                          user.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.roboto(
                                            color:
                                                AppColors.getPrimaryTextColor(),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Text(
                                          (user.toWatchList?.length ?? 0)
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                            fontSize: 26.sp,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                AppColors.getPrimaryTextColor(),
                                          ),
                                        ),
                                        SizedBox(height: 6.h),
                                        Text(
                                          "watch_list_text".tr(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.roboto(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                AppColors.getPrimaryTextColor(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          (user.historyList?.length ?? 0)
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                            fontSize: 26.sp,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                AppColors.getPrimaryTextColor(),
                                          ),
                                        ),
                                        SizedBox(height: 6.h),
                                        Text(
                                          "history_text".tr(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.roboto(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                AppColors.getPrimaryTextColor(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 16.h),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      height: 50.h,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            UpdateProfileScreen.routeName,
                                            arguments: user,
                                          );
                                        },

                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.getAccentColor(),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadiusGeometry.circular(
                                                  16.r,
                                                ),
                                          ),
                                        ),
                                        child: Text(
                                          "edit_profile_text".tr(),
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 50.h,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _showSignOutDialog(context, cubit);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.getActionColor(),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              16.r,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "exit_text".tr(),
                                              style: GoogleFonts.roboto(
                                                color:
                                                    AppColors.getPrimaryTextColor(),
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                            Icon(
                                              Icons.logout_outlined,
                                              color: AppColors.getIconColor(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 12.h,
                        color: AppColors.getDarkerPrimaryColor(),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                              onDoubleTap: () {
                                cubit.toggleVisibility();
                              },
                              child: Container(
                                color: AppColors.getDarkerPrimaryColor(),
                                child: TabBar(
                                  dividerColor: AppColors.getPrimaryColor(),
                                  controller: _tabController,
                                  indicatorColor: AppColors.getAccentColor(),
                                  indicatorPadding: EdgeInsets.symmetric(
                                    horizontal: -50,
                                  ),
                                  tabs: [
                                    Tab(
                                      icon: Icon(
                                        Icons.list,
                                        color: AppColors.getAccentColor(),
                                        size: 35.sp,
                                      ),
                                      child: Text(
                                        "watch_list_text".tr(),
                                        style: GoogleFonts.roboto(
                                          color:
                                              AppColors.getPrimaryTextColor(),
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      icon: Icon(
                                        Icons.folder,
                                        color: AppColors.getAccentColor(),
                                        size: 35.sp,
                                      ),
                                      child: Text(
                                        "history_text".tr(),
                                        style: GoogleFonts.roboto(
                                          color:
                                              AppColors.getPrimaryTextColor(),
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: (cubit.state.isVisible)
                                        ? MediaQuery.of(context).size.height *
                                              0.6
                                        : MediaQuery.of(context).size.height *
                                              0.9,
                                    child:
                                        (cubit.state.toWatchMoviesResponse ==
                                                null ||
                                            cubit
                                                .state
                                                .toWatchMoviesResponse!
                                                .isEmpty)
                                        ? Center(
                                            child: Image(
                                              image: AssetImage(
                                                AppImages.emptyList,
                                              ),
                                            ),
                                          )
                                        : GridView.builder(
                                            padding: EdgeInsets.all(12.w),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  crossAxisSpacing: 12.w,
                                                  mainAxisSpacing: 12.h,
                                                  childAspectRatio: 0.65,
                                                ),
                                            itemCount:
                                                cubit
                                                    .state
                                                    .toWatchMoviesResponse
                                                    ?.length ??
                                                0,
                                            itemBuilder: (context, index) {
                                              return MovieCard(
                                                rating:
                                                    cubit
                                                        .state
                                                        .toWatchMoviesResponse![index]
                                                        .rating ??
                                                    0.0,
                                                imgURL:
                                                    cubit
                                                        .state
                                                        .toWatchMoviesResponse![index]
                                                        .moviePoster ??
                                                    AppImages.noImage,
                                                movieId: cubit
                                                    .state
                                                    .toWatchMoviesResponse![index]
                                                    .id,
                                              );
                                            },
                                          ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: (cubit.state.isVisible)
                                        ? MediaQuery.of(context).size.height *
                                              0.6
                                        : MediaQuery.of(context).size.height *
                                              0.9,
                                    child:
                                        (cubit.state.historyMoviesResponse ==
                                                null ||
                                            cubit
                                                .state
                                                .historyMoviesResponse!
                                                .isEmpty)
                                        ? Center(
                                            child: Image(
                                              image: AssetImage(
                                                "assets/images/empty.png",
                                              ),
                                            ),
                                          )
                                        : GridView.builder(
                                            padding: EdgeInsets.all(12.w),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  crossAxisSpacing: 12.w,
                                                  mainAxisSpacing: 12.h,
                                                  childAspectRatio: 0.65,
                                                ),
                                            itemCount:
                                                cubit
                                                    .state
                                                    .historyMoviesResponse
                                                    ?.length ??
                                                0,
                                            itemBuilder: (context, index) {
                                              return MovieCard(
                                                rating:
                                                    cubit
                                                        .state
                                                        .historyMoviesResponse![index]
                                                        .rating ??
                                                    0.0,
                                                imgURL:
                                                    cubit
                                                        .state
                                                        .historyMoviesResponse![index]
                                                        .moviePoster ??
                                                    AppImages.noImage,
                                                movieId: cubit
                                                    .state
                                                    .historyMoviesResponse![index]
                                                    .id,
                                              );
                                            },
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: Text(
                  "something_went_wrong_text".tr(),
                  style: GoogleFonts.roboto(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context, HomeCubit cubit) {
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
          "sign_out_text".tr(),
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: AppColors.getAccentColor(),
          ),
        ),
        content: Text(
          "sign_out_confirm_text".tr(),
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
            onPressed: () async {
              Navigator.of(context).pop();
              await cubit.signOut();
            },
            child: Text(
              "sign_out_text".tr(),
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
