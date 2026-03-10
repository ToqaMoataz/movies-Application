import '../../../../Core/Entities/movie_entity.dart';
import '../Models/Movie/YTS  Response Models/yts_movie_response.dart';

extension YTSDetailMapper on MovieResponse {
  List<CastEntity> toCastEntity(List<Cast> castList) {
    return castList.map((c) {
      return CastEntity(
        name: c.name,
        character: c.characterName,
        profilePath: c.urlSmallImage,
      );
    }).toList();
  }
  MovieEntity toEntity({List<MovieSimpleEntity>? similar}) {
    final m = data.movie;
    return MovieEntity(
      id: m.id,
      movieTitle: m.title,
      summary: m.descriptionFull,
      genres: m.genres,
      releaseDate: m.year.toString(),
      rating: m.rating,
      likes: m.likeCount,
      url:m.url ,
      moviePoster: m.mediumCoverImage,
      watchListNumber: m.runtime,
      cast: toCastEntity(m.cast),
      screenshots: [
        m.mediumScreenshot1,
        m.mediumScreenshot2,
        m.mediumScreenshot3
      ].where((s) => s.isNotEmpty).toList(),
      adults: m.mpaRating.contains("R"),
      similar: similar
    );
  }
}