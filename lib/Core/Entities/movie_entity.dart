
class MoviesEntity{
  List<MovieSimpleEntity>? movies;
  int? moviesCount;
  int? pageNumber;
  int? totalPages;

  MoviesEntity({
    this.movies,
    this.moviesCount,
    this.pageNumber,
    this.totalPages
  });
}

class MovieSimpleEntity {
  final int id;
  final String movieTitle;
  final String? moviePoster;
  final double? rating;

  MovieSimpleEntity({
    required this.id,
    required this.movieTitle,
    this.moviePoster,
    this.rating,
  });
}

class MovieEntity {
  final int id;
  final String movieTitle;
  final String? moviePoster;
  final String? releaseDate;
  final String? summary;
  final List<String>? screenshots;
  final List<CastEntity>? cast;
  final List<String>? genres;
  final bool? adults;
  final double? rating;
  final int? likes;
  final int? watchListNumber;
  final String? url;
  final List<MovieSimpleEntity>? similar;


  MovieEntity({
    required this.id,
    required this.movieTitle,
    this.summary,
    this.moviePoster,
    this.screenshots,
    this.cast,
    this.genres,
    this.adults,
    this.rating,
    this.likes,
    this.watchListNumber,
    this.url,
    this.releaseDate,
    this.similar
  });
}

class CastEntity{
  final String? name;
  final String? profilePath;
  final String? character;

  CastEntity({this.name,this.character,this.profilePath});
}