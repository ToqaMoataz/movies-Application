import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Core/assets/App%20Components/movie_card.dart';
import 'package:movie_app/Features/HomeScreen/persentation/widgets/genre_card.dart';
import '../../../../../../Core/Theme/app_colors.dart';
import '../../../../../../Core/assets/App Images/app_images.dart';
import '../../../../../../Core/assets/language_setter.dart';
import '../../../../data/Data Source/local_data.dart';
import '../../../HomeScreen cubit/cubit.dart';
import '../../../HomeScreen cubit/state.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = HomeCubit.get(context);
        final recentMovies = state.recentMoviesResponse?.movies;

        if (state.recentMoviesRequestState == RequestState.loading ||
            state.moviesByGenreRequestState == RequestState.loading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.getAccentColor()),
          );
        } else if (state.recentMoviesRequestState == RequestState.error ||
            state.moviesByGenreRequestState == RequestState.error) {
          return Center(
            child: Text(state.errorMessage??"",
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                color: AppColors.getAccentColor(),
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        } else {
          return SingleChildScrollView(
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: [
                          Positioned.fill(
                            child: cubit.state.carouselBackgroundImg != null
                                ? Image.network(
                              cubit.state.carouselBackgroundImg!,
                              fit: BoxFit.cover,
                              // Adding an error builder prevents crashes if the URL is invalid
                              errorBuilder: (context, error, stackTrace) => Container(color: Colors.black),
                            )
                                : Container(color: Colors.black),
                          ),
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: const [0.0, 0.4, 1.0],
                                  colors: [
                                    const Color(0xCC121312),
                                    const Color(0x99121312),
                                    Colors.black,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Column(
                            children: [
                              SizedBox(height: 36.h),
                              Image.asset(
                                AppImages.availableNow,
                                width: double.infinity,
                                height: 50.h,
                                alignment: Alignment.center,
                                fit: BoxFit.none,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 22),
                                child: SizedBox(
                                  height: 250.h,
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      height: 250.h,
                                      enlargeCenterPage: true,
                                      enableInfiniteScroll: true,
                                      viewportFraction: 0.55,
                                      autoPlay: true,
                                      autoPlayInterval: const Duration(
                                        seconds: 3,
                                      ),
                                      onPageChanged: (index, reason) {
                                        cubit.setCarouselIndex(
                                          index,
                                          recentMovies?[index].moviePoster ?? "",
                                        );
                                      },
                                    ),
                                    items: recentMovies?.map((movie) {
                                      return MovieCard(
                                        rating: movie.rating ?? 0.0,
                                        imgURL: movie.moviePoster ?? "",
                                        movieId: movie.id,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const Image(image: AssetImage(AppImages.watchNow)),
                            ],
                          ),
                        ],
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final genreMap = state.moviesByGenreList[index];
                          String genre = genreMap.keys.first;
                  
                          final genreIndex = AppData.tmdbGenresList.indexWhere(
                            (g) => g.values.first == genre,
                          );
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: GenreCard(
                              genre: genre,
                              movies: genreMap.values.first.movies ?? [],
                              onTap: () {
                                cubit.setGenreTabIndex(genreIndex);
                                cubit.setTabIndex(2);
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 4.h),
                        itemCount: state.moviesByGenreList.length,
                      ),
                    ],
                  ),
                  Positioned(
                    top: 8,
                    right: 16,
                    child: GestureDetector(
                      onTap: (){LanguageChanger.changeLan(context);},
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.getAccentColor(),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          (context.locale.toString() == 'en') ? "EN" : "AR",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color: AppColors.getPrimaryColor(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
