import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Core/Theme/app_colors.dart';
import 'package:movie_app/Features/moviesDetails/persentation/movie_details_screen.dart';

class MovieCard extends StatelessWidget {
  String imgURL;
  double rating;
  int movieId;
  MovieCard({super.key,required this.movieId,required this.rating,required this.imgURL});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, MovieDetailsScreen.routeName,arguments: movieId);
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.network(
              imgURL,
              height: 279.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/images/no image.png",
                  height: 279.h,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),

          Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4,horizontal: 6),
                decoration: BoxDecoration(
                  color: Color(0XB5121312),
                  borderRadius: BorderRadiusGeometry.circular(10.r)
                ),
                child: Row(
                  children: [
                    Text(
                        "$rating",
                      style: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.getPrimaryTextColor(),
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Icon(Icons.star,color: AppColors.getAccentColor(),)
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
