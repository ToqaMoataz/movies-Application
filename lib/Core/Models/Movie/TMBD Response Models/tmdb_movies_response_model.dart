class TMDBMovieResponse {
  final int page;
  final List<TMDBMovie> results;
  final int totalPages;
  final int totalResults;

  TMDBMovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TMDBMovieResponse.fromJson(Map<String, dynamic> json) {
    return TMDBMovieResponse(
      page: json['page'],
      results: List<TMDBMovie>.from(
        (json['results'] as List<dynamic>).map((movieJson) => TMDBMovie.fromJson(movieJson)),
      ),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}
class TMDBMovie {
  final int id;
  final String title;
  final double voteAverage;
  final String? posterPath;

  TMDBMovie({
    required this.id,
    required this.title,
    required this.voteAverage,
    this.posterPath,
  });

  factory TMDBMovie.fromJson(Map<String, dynamic> json) {
    return TMDBMovie(
      id: json['id'],
      title: json['title'] ?? '',
      voteAverage: (json['vote_average'] as num).toDouble(),
      posterPath: json['poster_path'],
    );
  }
}