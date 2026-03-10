import '../../../../Core/Entities/movie_entity.dart';
import '../Models/Movie/YTS  Response Models/yts_movies_response.dart';


extension YTSListMapper on MoviesResponse {
  MoviesEntity toEntity() {
    return MoviesEntity(
      moviesCount: data?.movieCount ?? 0,
      pageNumber: data?.pageNumber ?? 1,
      totalPages: ((data?.movieCount ?? 0) / (data?.limit ?? 20)).ceil(),
      movies: data?.movies?.map((m) => MovieSimpleEntity(
        id: m.id ?? 0,
        moviePoster: m.mediumCoverImage,
        movieTitle: m.title ?? "",
        rating: m.rating,
      )).toList(),
    );
  }
}