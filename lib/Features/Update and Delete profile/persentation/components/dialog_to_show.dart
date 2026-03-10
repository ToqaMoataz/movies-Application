import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/Core/Theme/app_colors.dart';
import 'package:movie_app/Core/assets/App%20Images/app_images.dart';

import '../update and delete cubit/cubit.dart';
import '../update and delete cubit/states.dart';

class DialogToShow extends StatelessWidget {
  DialogToShow({super.key});
   List<String> userImages=AppImages.getUserImages();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit,UpdateProfileStates>(
      builder: (BuildContext context, state) {
        String image=UpdateProfileCubit.get(context).state.selectedImage;
        return Container(
          decoration: BoxDecoration(
            color: AppColors.getPrimaryColor(),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              padding: EdgeInsets.all(12.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 0.65,
              ),
              itemCount: userImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      UpdateProfileCubit.get(context).setSelectedImage(userImages[index]);
                      print("user image${userImages[index]}");
                      print("user image${UpdateProfileCubit.get(context).state.selectedImage}");
                    },
                    child:Container(
                      height: 10.h,
                      width: 100.w,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: (userImages[index]==UpdateProfileCubit.get(context).state.selectedImage)
                            ? AppColors.getAccentColor()
                            : Colors.transparent,
                        border: Border.all(
                          color: Color(0X8FF6BD00),
                          style: (userImages[index]==UpdateProfileCubit.get(context).state.selectedImage)
                            ? BorderStyle.none
                            : BorderStyle.solid
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: SizedBox(
                          height: 70.h, // أصغر من 100
                          width: 70.w,
                          child: Image.asset(
                            "assets/images/${userImages[index]}.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    )

                );
              },
            ),
          ),
        );
      },
    );
  }
}
