import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Core/Dependency%20Injection/di.dart';
import 'package:movie_app/Core/Hive/hive_manager.dart';
import 'package:movie_app/Core/Theme/app_colors.dart';
import '../../../../Core/assets/App Components/movie_card.dart';
import '../../../../Core/assets/App Images/app_images.dart';
import '../Components/cast_component.dart';
import '../Components/small_info_card.dart';
import '../MovieDetailsScreen cubit/cubit.dart';
import '../MovieDetailsScreen cubit/states.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = "movieDetailsScreen";

  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var movieId = ModalRoute.of(context)?.settings.arguments as int;

    return Scaffold(
      body: BlocProvider<MovieDetailsCubit>(
        create: (context) => getIt<MovieDetailsCubit>()
              ..getMovieById(movieId),

        child: BlocBuilder<MovieDetailsCubit, MovieDetailsStates>(
          builder: (context, state) {
            var cubit = MovieDetailsCubit.get(context);
            cubit.addToList('history', movieId, true);
            final movie = cubit.state.movieResponse;
            if (state.movieRequestState == RequestState.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.getAccentColor(),
                ),
              );
            }
            if (state.movieRequestState == RequestState.success &&
                state.movieResponse != null) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Movie title, img, add to watch list and year
                      Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 645.h,
                            child: Stack(
                              children: [
                                // 1. The Background Image
                                Positioned.fill(
                                  child: ClipRRect(
                                    child: (movie?.moviePoster != null)
                                        ? Image.network(
                                            movie!.moviePoster!,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Image.asset(
                                                      AppImages.noImage,
                                                      fit: BoxFit.cover,
                                                    ),
                                          )
                                        : Image.asset(
                                            AppImages.noImage,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),

                                // 2. The Dark Gradient Overlay
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          const Color(0x33121312,),
                                          // 20% opacity at top
                                          const Color(0xE6121312)
                                          // Darker at bottom for text
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: AppColors.getIconColor(),
                                          size: 30,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          // HiveManager.printToWatchList();
                                          MovieDetailsCubit.get(
                                            context,
                                          ).toggleBookmark();
                                          MovieDetailsCubit.get(
                                            context,
                                          ).addToList(
                                            'toWatchList',
                                            movieId,
                                            (MovieDetailsCubit.get(
                                                  context,
                                                ).state.bookMarkTabbed ||
                                                HiveManager.isMovieInToWatchList(
                                                  movieId,
                                                )),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.bookmark,
                                          color:
                                              (MovieDetailsCubit.get(
                                                    context,
                                                  ).state.bookMarkTabbed ||
                                                  HiveManager.isMovieInToWatchList(
                                                    movieId,
                                                  ))
                                              ? AppColors.getAccentColor()
                                              : AppColors.getIconColor(),
                                          size: 35,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Image.asset(
                                    AppImages.playButtonImage,
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 28.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        movie!.movieTitle,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color:
                                              AppColors.getPrimaryTextColor(),
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w700,
                                          height: 1.39,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                      Text(
                                        movie.releaseDate ?? "0000",
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //rest of data
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          spacing: 16.h,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ////////// Watch Button
                            ElevatedButton(
                              onPressed: () async {
                                try {
                                  if (movie.url != null) {
                                    await MovieDetailsCubit.get(
                                      context,
                                    ).goToWatchMovie(movie.url!);
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Could not open link"),
                                    ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SmallInfoCard(
                                    icon: Icons.favorite,
                                    info: movie.likes.toString(),
                                  ),
                                  SmallInfoCard(
                                    icon: Icons.watch_later_rounded,
                                    info: movie.watchListNumber.toString(),
                                  ),
                                  SmallInfoCard(
                                    icon: Icons.star,
                                    info: movie.rating.toString(),
                                  ),
                                ],
                              ),
                            ),
                            ////////// Screenshots
                            Text(
                              "screenshots_text".tr(),
                              style: GoogleFonts.roboto(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.getPrimaryTextColor(),
                              ),
                              textAlign: TextAlign.start,
                            ),
                            (movie.screenshots != null)
                                ? MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(
                                                16.r,
                                              ),
                                          child: Image.network(
                                            movie.screenshots![index],
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Image.asset(
                                                    AppImages.noImage,
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 14.h),
                                      itemCount: movie.screenshots!.length,
                                    ),
                                  )
                                : Text("No ScreenShots"),

                            ////////// Similar
                            Text(
                              "similar_text".tr(),
                              style: GoogleFonts.roboto(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.getPrimaryTextColor(),
                              ),
                            ),
                            (movie.similar==null || movie.similar!.isEmpty)
                                ? Text("No Similar")

                                : MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 8,
                                            childAspectRatio: 2 / 3,
                                          ),
                                      itemCount: movie.similar?.length,
                                      itemBuilder: (context, index) {
                                        final moviee = movie.similar?[index];
                                        return MovieCard(
                                          rating: moviee?.rating ?? 0.0,
                                          imgURL: moviee?.moviePoster ?? "",
                                          movieId: moviee!.id,
                                        );
                                      },
                                    ),
                                  ),

                            ////////// Summary
                            Text(
                              "summary_text".tr(),
                              style: GoogleFonts.roboto(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.getPrimaryTextColor(),
                              ),
                            ),
                            Text(
                              movie.summary!,
                              style: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.getPrimaryTextColor(),
                              ),
                            ),
                            ////////// Cast
                            Text("cast_text".tr(),style:GoogleFonts.roboto(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.getPrimaryTextColor()
                            ),),
                            (movie.cast != null && movie.cast!.isNotEmpty)
                                ? MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: movie.cast!.length,
                                  itemBuilder: (context, index) {
                                    final actor = movie.cast![index];
                                    return CastComponent(
                                      imgUrl: actor.profilePath,
                                      actorName: actor.name ?? "Unknown",
                                      characterName: actor.character ?? "Unknown",
                                    );
                                  },
                                separatorBuilder: (context, index) => SizedBox(height: 8.h,),
                              ),
                            ) : const SizedBox.shrink(),

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
                            (movie.genres!=null && movie.genres!.isNotEmpty) ?
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.13,
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    childAspectRatio: 2.5,
                                  ),
                                  itemCount: movie.genres!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColors.getPrimaryColor(),
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                      child: Text(
                                        movie.genres![index],
                                        style: GoogleFonts.roboto(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.getPrimaryTextColor(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ) : SizedBox.shrink()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: Text(
                "something_went_wrong_text".tr(),
                style: GoogleFonts.roboto(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.getAccentColor(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
