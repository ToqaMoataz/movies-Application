import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Core/Theme/app_colors.dart';
import 'package:movie_app/Core/assets/App%20Images/app_images.dart';

class CastComponent extends StatelessWidget {
  CastComponent({super.key, this.imgUrl,required this.actorName,required this.characterName});
  String? imgUrl;
  String actorName;
  String characterName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(11),
      height: 92.h,
      decoration: BoxDecoration(
        color: AppColors.getPrimaryColor(),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: (imgUrl!=null) ? Image.network(
              imgUrl!,
              height: 70.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/images/no image.png",
                  height: 70.h,
                  fit: BoxFit.cover,
                );
              },
            ) : Image.asset(AppImages.noImage)
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name: $actorName",
                  style: GoogleFonts.roboto(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.getPrimaryTextColor(),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Character: $characterName",
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.getPrimaryTextColor(),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
