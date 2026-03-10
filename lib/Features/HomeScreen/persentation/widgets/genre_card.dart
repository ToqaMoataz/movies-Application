import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Core/Entities/movie_entity.dart';
import '../../../../Core/Theme/app_colors.dart';
import '../../../../Core/assets/App Components/movie_card.dart';


class GenreCard extends StatelessWidget {
  final String genre;
  final List<MovieSimpleEntity> movies;
  final Function onTap;

  const GenreCard({
    super.key,
    required this.genre,
    required this.movies,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Text("No movies available for $genre"),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(genre, style: GoogleFonts.roboto(
                color: AppColors.getPrimaryTextColor(),
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                height: 1.2,
                letterSpacing: 0,
              )),
              InkWell(
                onTap: (){
                 onTap();
                 },
                child: Text("See More", style: GoogleFonts.roboto(
                  color: AppColors.getAccentColor(),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  letterSpacing: 0,
                )),
              ),
            ],
          ),
          SizedBox(height: 4.h,),
          SizedBox(
            height: 150.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: MovieCard(
                    rating: movie.rating ?? 0.0,
                    imgURL: movie.moviePoster ?? "",
                    movieId: movie.id,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
