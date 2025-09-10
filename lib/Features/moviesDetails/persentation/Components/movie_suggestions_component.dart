import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../Core/assets/App Components/movie_card.dart';
import '../../../../Core/Theme/app_colors.dart';
import '../MovieDetailsScreen cubit/cubit.dart';
import '../MovieDetailsScreen cubit/states.dart';
import '../movie_details_screen.dart';
class MovieSuggestionsComponent extends StatelessWidget {
  const MovieSuggestionsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsCubit, MovieDetailsStates>(
      builder: (context, state) {
        var suggestion = MovieDetailsCubit.get(context).state.movieSuggestions?.data;

        if (suggestion == null || suggestion.movies == null || suggestion.movies!.isEmpty) {
          return const SizedBox.shrink();
        }
        else if(MovieDetailsCubit.get(context).state.movieRequestState==RequestState.loading){
          return Center(child: CircularProgressIndicator(color: AppColors.getAccentColor(),));
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 2 / 3,
          ),
          itemCount: suggestion.movies!.length,
          itemBuilder: (context, index) {
            final movie = suggestion.movies![index];
            return MovieCard(
              rating: movie.rating ?? 0.0,
              imgURL: movie.mediumCoverImage ?? "",
              movieId: movie.id ?? 0,
            );
          },
        );
      },
    );
  }
}

