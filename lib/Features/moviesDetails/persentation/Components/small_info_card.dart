import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../Core/Theme/app_colors.dart';

class SmallInfoCard extends StatelessWidget {
  const SmallInfoCard({super.key,required this.icon,required this.info});
  final String info;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4,horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.getPrimaryColor(),
        borderRadius: BorderRadiusGeometry.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon,color: AppColors.getAccentColor(),),
          SizedBox(width:8.w,),
          Text(
            info,
            style:GoogleFonts.roboto(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.getPrimaryTextColor()
            ),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
