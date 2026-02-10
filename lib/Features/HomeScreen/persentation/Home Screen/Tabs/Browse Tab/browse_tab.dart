import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Core/Theme/app_colors.dart';
import '../../../../../../../Core/assets/App Components/movie_card.dart';
import '../../../../data/Data Source/local_data.dart';
import '../../../HomeScreen cubit/cubit.dart';
import '../../../HomeScreen cubit/state.dart';

class BrowseTab extends StatelessWidget {
  BrowseTab({super.key});
  List<String> genre=AppData.getMoviesGenres();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
             left:16,
             top: 38,
             bottom:12
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height*0.05,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: genre.length,
                itemBuilder: (context,i){
                  return InkWell(
                    onTap: (){
                       HomeCubit.get(context).setGenreTabIndex(i);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,),
                        decoration: BoxDecoration(
                          color: (HomeCubit.get(context).state.genreIndex==i) ? AppColors.getAccentColor() : Colors.transparent,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppColors.getAccentColor(),
                            width: 2,
                            style: (HomeCubit.get(context).state.genreIndex==i) ? BorderStyle.none : BorderStyle.solid
                          ),
                        ),
                        child: Text(
                          genre[i],
                          style: GoogleFonts.inter(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: (HomeCubit.get(context).state.genreIndex==i) ? AppColors.getSecondaryTextColor() : AppColors.getAccentColor(),
                          ),
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
        ),
        // Result Movies Section
        Expanded(
          child: BlocBuilder<HomeCubit, HomeStates>(
            builder: (context, state) {
              var cubit = HomeCubit.get(context);
              var movies = cubit.state.moviesBrowseResponse?.data?.movies;
              if (cubit.state.browseMoviesRequestState==RequestState.loading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.getAccentColor(),
                  ),
                );
              }
              else if (cubit.state.browseMoviesRequestState==RequestState.success) {
                if (movies == null || movies.isEmpty) {
                  return Center(
                    child: Text(
                      "no_movies_found_text".tr(),
                      style: GoogleFonts.roboto(
                        fontSize: 24.sp,
                        color: AppColors.getAccentColor(),
                      ),
                    ),
                  );
                }
                return GridView.builder(
                  padding: EdgeInsets.all(12.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(
                      imgURL: movies[index].mediumCoverImage ?? "",
                      rating: movies[index].rating ?? 0.0,
                      movieId: movies[index].id ?? 0,
                    );
                  },
                );
              }
              else if (cubit.state.browseMoviesRequestState==RequestState.error) {
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
              }
              return SizedBox.shrink();
            },
          ),
        ),

      ],
    );
  }
}
