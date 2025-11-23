import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Core/Theme/app_colors.dart';
import 'package:movie_app/Core/assets/App%20Components/movie_card.dart';
import '../../../../../Authentication/persentation/Screens/Login Screen/login_screen.dart';
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
              if (HomeCubit
                  .get(context)
                  .state
                  .signOutRequestState == RequestState.success) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginScreen.routeName,
                      (route) => false,
                );
              } else if (HomeCubit
                  .get(context)
                  .state
                  .signOutRequestState == RequestState.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Sign out failed"),
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
                  return Center(child: CircularProgressIndicator(
                    color: AppColors.getAccentColor(),));
                } else if (cubit.state.profileMoviesRequestState ==
                    RequestState.success) {
                  if (user == null) {
                    return Center(
                      child: Text(
                        "No User Signed In",
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
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 50.r,
                                          child: ClipOval(
                                            child: Image.asset(
                                              "assets/images/${user.image}.png",
                                              width: 100.w,
                                              // double the radius
                                              height: 100.h,
                                              // double the radius
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          cubit.state.user!.name,
                                          style: GoogleFonts.roboto(
                                            color: AppColors
                                                .getPrimaryTextColor(),
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 12.w,),
                                    Column(
                                      children: [
                                        Text(
                                          (user.toWatchList == null ||
                                              user.toWatchList!.isEmpty)
                                              ? "0"
                                              : "${user.toWatchList?.length}",
                                          style: GoogleFonts.roboto(
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors
                                                .getPrimaryTextColor(),
                                          ),
                                        ),
                                        SizedBox(height: 14),
                                        Text(
                                          "watch_list_text".tr(),
                                          style: GoogleFonts.roboto(
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors
                                                .getPrimaryTextColor(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 12.w,),
                                    Column(
                                      children: [
                                        Text(
                                          (user.historyList == null ||
                                              user.historyList == [])
                                              ? "0"
                                              : "${user.historyList?.length}",
                                          style: GoogleFonts.roboto(
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors
                                                .getPrimaryTextColor(),
                                          ),
                                        ),
                                        SizedBox(height: 14.h),
                                        Text(
                                          "history_text".tr(),
                                          style: GoogleFonts.roboto(
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors
                                                .getPrimaryTextColor(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        height: 50.h,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 6),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushNamed(context, UpdateProfileScreen.routeName,arguments: user);
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
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        height: 50,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 6),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              _showSignOutDialog(context, cubit);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                              AppColors.getActionColor(),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(
                                                  16,
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
                                                    AppColors
                                                        .getPrimaryTextColor(),
                                                    fontSize: 16.sp,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.logout_outlined,
                                                  color: AppColors
                                                      .getIconColor(),
                                                ),
                                              ],
                                            ),
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
                        Container(height: 12.h,
                          color: AppColors.getDarkerPrimaryColor(),),
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
                                            color: AppColors
                                                .getPrimaryTextColor(),
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
                                            color: AppColors
                                                .getPrimaryTextColor(),
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.h,),
                              Expanded(
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: (cubit.state.isVisible)
                                          ? MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.6
                                          : MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.9,
                                      child:
                                      (cubit.state.toWatchMoviesResponse ==
                                          null ||
                                          cubit.state.toWatchMoviesResponse!
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
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 12.w,
                                          mainAxisSpacing: 12.h,
                                          childAspectRatio: 0.65,
                                        ),
                                        itemCount: cubit.state
                                            .toWatchMoviesResponse?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          final movie = cubit.state
                                              .toWatchMoviesResponse![index]
                                              .data.movie;
                                          return MovieCard(
                                            rating: movie.rating ?? 0.0,
                                            imgURL: movie.mediumCoverImage ?? "",
                                            movieId: movie.id ?? 0,
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: (cubit.state.isVisible)
                                          ? MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.6
                                          : MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.9,
                                      child:
                                      (cubit.state.historyMoviesResponse ==
                                          null ||
                                          cubit.state.historyMoviesResponse!
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
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 12.w,
                                          mainAxisSpacing: 12.h,
                                          childAspectRatio: 0.65,
                                        ),
                                        itemCount: cubit.state
                                            .historyMoviesResponse?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          final movie = cubit.state
                                              .historyMoviesResponse![index]
                                              .data.movie;
                                          return MovieCard(
                                            rating: movie.rating ?? 0.0,
                                            imgURL: movie.mediumCoverImage ?? "",
                                            movieId: movie.id ?? 0,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else if (cubit.state.profileMoviesRequestState ==
                    RequestState.error) {
                  return Center(
                    child: Text(
                      "Something went wrong",
                      style: GoogleFonts.roboto(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
        )
    );
  }

  void _showSignOutDialog(BuildContext context, HomeCubit cubit) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          AlertDialog(
            backgroundColor: AppColors.getDarkerPrimaryColor(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
              side: BorderSide(
                color: AppColors.getAccentColor(),
                width: 2,
              ),
            ),
            title: Text(
              "Sign out",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColors.getAccentColor(),
              ),
            ),
            content: Text(
              "Are you sure you want to sign out?",
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
                  "Cancel",
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
                  Navigator.of(context).pop(); // close dialog
                  await cubit.signOut();
                },
                child: Text(
                  "Sign out",
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
