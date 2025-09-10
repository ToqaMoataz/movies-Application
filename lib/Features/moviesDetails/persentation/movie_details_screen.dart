import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Core/Hive/hive_manager.dart';
import 'package:movie_app/Core/Theme/app_colors.dart';
import '../domain/movie_details_repo.dart';
import 'Components/cast_component.dart';
import 'Components/movie_suggestions_component.dart';
import 'Components/small_info_card.dart';
import 'MovieDetailsScreen cubit/cubit.dart';
import 'MovieDetailsScreen cubit/states.dart';
import 'package:url_launcher/url_launcher.dart';


class MovieDetailsScreen extends StatelessWidget {
  static const String routeName="movieDetailsScreen";
  const MovieDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var movieId=ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      body: BlocProvider<MovieDetailsCubit>(
        create: (context)=>MovieDetailsCubit(MovieDetailsRepoImp())..getMovieById(movieId),
        child: BlocConsumer<MovieDetailsCubit,MovieDetailsStates>(
            builder: (context,state){
              MovieDetailsCubit.get(context).addToList('history',movieId,true);
              print("Exists >>>>>>>>> ${HiveManager.isMovieInToWatchList(movieId)}");
              print("current ID: $movieId");
              print("ToWatch List"); HiveManager.printToWatchList();
              var movie=MovieDetailsCubit.get(context).state.movieResponse?.data.movie;
              if (state.movieRequestState == RequestState.loading || state.suggestionsRequestState == RequestState.loading){
                return Center(child: CircularProgressIndicator(color: AppColors.getAccentColor(),));
              }
              if (state.movieRequestState == RequestState.success && state.movieResponse != null){
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        children: [
                          //Movie title, img, add to watch list and year
                          Stack(
                            children: [
                              SizedBox(
                                //height: 645.h,
                                width: double.infinity,
                                child: Opacity(
                                  opacity: 0.2,
                                  child: ClipRRect(
                                    child: (movie?.largeCoverImage != null && movie!.largeCoverImage.isNotEmpty)
                                        ? Image.network(
                                      movie.largeCoverImage,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.asset(
                                          "assets/images/no image.png",
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                        : Image.asset(
                                      "assets/images/no image.png",
                                      fit: BoxFit.cover,
                                    ),
                                  )

                                ),

                              ),
                              Positioned(
                                top: 30,
                                right: 16,
                                left: 16,
                                bottom: 16,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(Icons.arrow_back_ios,color: AppColors.getIconColor(),size: 30,)
                                          ),
                                          IconButton(
                                            onPressed: (){
                                              HiveManager.printToWatchList();
                                              MovieDetailsCubit.get(context).toggleBookmark();
                                              MovieDetailsCubit.get(context).addToList( 'toWatchList',movieId,(MovieDetailsCubit.get(context).state.bookMarkTabbed || HiveManager.isMovieInToWatchList(movieId)));
                                            },
                                            icon: Icon(Icons.bookmark,color:(MovieDetailsCubit.get(context).state.bookMarkTabbed || HiveManager.isMovieInToWatchList(movieId)) ? AppColors.getAccentColor() : AppColors.getIconColor(),size: 35,),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: IconButton(
                                        onPressed: () {

                                        },
                                        icon: Image.asset(
                                          "assets/images/play button.png",
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),

                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            movie?.title??"Movie Title",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                              color: AppColors.getPrimaryTextColor(),
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.w700,
                                              height: 1.39,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          Text(
                                            "${movie?.year}",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                              color: Color(0XFFADADAD),
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w700,
                                              height: 1.39,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          //rest data
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 16.h,
                              children: [
                                ////////// Watch Button
                                ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      await MovieDetailsCubit.get(context).goToWatchMovie(movie!.url);
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Could not open link"))
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.getActionColor(),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 16.h),
                                  ),
                                  child: Text(
                                    "watch_text".tr(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      color: AppColors.getPrimaryTextColor(),
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                ////////// Movie Info
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SmallInfoCard(icon: Icons.favorite, info: movie!.likeCount.toString()),
                                      SmallInfoCard(icon: Icons.watch_later_rounded, info: movie.runtime.toString()),
                                      SmallInfoCard(icon: Icons.star, info: movie.rating.toString())
                                    ],
                                  ),
                                ),
                                ////////// Screenshots
                                SizedBox(
                                    child: Column(
                                      spacing: 12.h,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("screenshots_text".tr(),style:GoogleFonts.roboto(
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.getPrimaryTextColor()
                                        ),),
                                        ClipRRect(
                                          borderRadius: BorderRadiusGeometry.circular(16.r),
                                          child: Image.network(
                                            movie.largeScreenshot1,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Image.asset(
                                                "assets/images/no image.png",
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadiusGeometry.circular(16.r),
                                          child: Image.network(
                                            movie.largeScreenshot2,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Image.asset(
                                                "assets/images/no image.png",
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadiusGeometry.circular(16.r),
                                          child: Image.network(
                                            movie.largeScreenshot3,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Image.asset(
                                                "assets/images/no image.png",
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                ),
                                ////////// Similar
                                Text("similar_text".tr(),style:GoogleFonts.roboto(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.getPrimaryTextColor()
                                ),),
                                MovieSuggestionsComponent(),
                                ////////// Summary
                                Text("summary_text".tr(),style:GoogleFonts.roboto(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.getPrimaryTextColor()
                                ),),
                                Text(movie.descriptionFull,
                                  style:GoogleFonts.roboto(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.getPrimaryTextColor()
                                  ),
                                ),
                                ////////// Cast
                                Text("cast_text".tr(),style:GoogleFonts.roboto(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.getPrimaryTextColor()
                                ),),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height*0.13,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),

                                      itemCount: movie.cast.length,
                                      itemBuilder: (context,index){
                                        return CastComponent(
                                          imgUrl:movie.cast[index].urlSmallImage,
                                          actorName: movie.cast[index].name,
                                          characterName:movie.cast[index].characterName,
                                        );
                                      }
                                  ),
                                ),
                                ////////// Genres
                                // Genres
                                Text(
                                  "genres_text".tr(),
                                  style: GoogleFonts.roboto(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.getPrimaryTextColor(),
                                  ),
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    childAspectRatio: 2.5,
                                  ),
                                  itemCount: movie.genres.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColors.getPrimaryColor(),
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                      child: Text(
                                        movie.genres[index],
                                        style: GoogleFonts.roboto(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.getPrimaryTextColor(),
                                        ),
                                      ),
                                    );
                                  },
                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Center(child: Text("Something Went Wrong",style:GoogleFonts.roboto(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.getAccentColor()
              ),),);
            },

            listener: (context,state){})
      ),
    );
  }
}
