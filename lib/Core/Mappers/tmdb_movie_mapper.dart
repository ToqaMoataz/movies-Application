
import '../../../../Core/Entities/movie_entity.dart';
import '../Models/Movie/TMBD Response Models/tmdb_movie_details_response.dart';

extension TmdbDetailsMapper on TmdbMovieDetailsModel {
  MovieEntity toMovieEntity({List<String>? screenshots,List<CastEntity>? cast,List<MovieSimpleEntity>? similar}) {
    return MovieEntity(
      id: id ?? 0,
      movieTitle: title ?? originalTitle ?? "Unknown",
      summary: overview,
      cast: cast?.take(10).toList(),
      similar:similar,
      screenshots: screenshots,
      genres: genres?.map((g) => g.name ?? "").toList() ?? [],
      rating: voteAverage,
      adults: adult,
      releaseDate: releaseDate.toString().substring(0,4),
      moviePoster: "https://image.tmdb.org/t/p/w500$posterPath",
      likes: voteCount,
      url: "https://www.themoviedb.org/movie/$id",
      watchListNumber: runtime,
    );
  }
}