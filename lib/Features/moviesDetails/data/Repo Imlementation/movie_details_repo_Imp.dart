import 'package:injectable/injectable.dart';
import 'package:movie_app/Core/Entities/movie_entity.dart';
import 'package:movie_app/Core/Mappers/tmdb_simple_movie_mapper.dart';
import 'package:movie_app/Core/Mappers/yts_movie_mapper.dart';
import 'package:movie_app/Core/Models/Movie/TMBD%20Response%20Models/tmdb_movie_cast.dart';
import 'package:movie_app/Core/Models/Movie/TMBD%20Response%20Models/tmdb_movies_response_model.dart';
import 'package:movie_app/Core/Models/Movie/YTS%20%20Response%20Models/yts_movies_response.dart';
import 'package:movie_app/Features/moviesDetails/data/Data%20Sources/dataSource.dart';
import '../../../../Core/Mappers/tmdb_movie_mapper.dart';
import '../../domain/Movies Details Repo/movie_details_repo.dart';

@Injectable(as: MovieDetailsRepo)
class MovieDetailsRepoImp extends MovieDetailsRepo {
  final MoviesDetailsTMBDImpDs tmbdDS;
  final MoviesDetailsYTSImpDs ytsDS;

  MovieDetailsRepoImp(
    @Named("tmdbDetailsDS") this.tmbdDS,
    @Named("ytsDetailsDS") this.ytsDS,
  );

  @override
  Future<MovieEntity> getMovieByID(int id) async {
    try {
      var response1 = await ytsDS.getMovieByID(id);
      MoviesResponse ytsSimilarResponse= await ytsDS.getMovieSuggestionsById(id);
      List<MovieSimpleEntity> similarList = ytsSimilarResponse.data?.movies
          ?.map((movie) => MovieSimpleEntity(
        id: movie.id ?? 0,
        movieTitle: movie.title ?? '',
        moviePoster: movie.mediumCoverImage,
        rating: movie.rating,
      )).toList() ?? [];
      MovieEntity moviee=response1.toEntity(similar: similarList);
      return moviee;

    } catch (primaryError) {
      print("Error with YTS");
      try {
        var response = await tmbdDS.getMovieByID(id);
        List<String>? screenshots = await tmbdDS.getMovieImages(id);

        List<CastResponse> castResponse = await tmbdDS.getMovieCast(id);

        List<CastEntity>? castEntities = castResponse.map((cast) {
          return CastEntity(
            name: cast.name,
            character: cast.character,
            profilePath: cast.profilePath != null
                ? "https://image.tmdb.org/t/p/w500${cast.profilePath}"
                : null,
          );
        }).toList();

        TMDBMovieResponse tmdbSimilarResponse= await tmbdDS.getMovieSuggestionsById(id);

        List<MovieSimpleEntity> similarList = tmdbSimilarResponse.results.map((movie) => movie.toSimpleMovieEntity()).toList();

        MovieEntity movie = response.toMovieEntity(
          screenshots: screenshots,
          cast: castEntities,
          similar: similarList
        );

        return movie;
      } catch (backupError) {
        throw Exception(
          "Both APIs failed.",
        );
      }
    }

  }

  @override
  Future<void> watchMovieFromUrl(String url) async {
    try {
      await tmbdDS.watchMovieFromUrl(url);
    } catch (e) {
      rethrow;
    }
  }

  //update watch List and history
  @override
  Future<void> updateUserList(String listName, int id, bool isAdd) async {
    try {
      tmbdDS.updateUserList(listName, id, isAdd);
    } catch (e) {
      rethrow;
    }
  }
}
