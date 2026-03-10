class MovieResponse {
  String status;
  String statusMessage;
  MovieData data;
  Meta meta;

  MovieResponse({
    required this.status,
    required this.statusMessage,
    required this.data,
    required this.meta,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      status: json['status'],
      statusMessage: json['status_message'],
      data: MovieData.fromJson(json['data']),
      meta: Meta.fromJson(json['@meta']),
    );
  }
}

class MovieData {
  Movie movie;

  MovieData({required this.movie});

  factory MovieData.fromJson(Map<String, dynamic> json) {
    return MovieData(
      movie: Movie.fromJson(json['movie']),
    );
  }
}

class Movie {
  int id;
  String url;
  String imdbCode;
  String title;
  String titleEnglish;
  String titleLong;
  String slug;
  int year;
  double rating;
  int runtime;
  List<String> genres;
  int likeCount;
  String descriptionIntro;
  String descriptionFull;
  String ytTrailerCode;
  String language;
  String mpaRating;
  String backgroundImage;
  String backgroundImageOriginal;
  String smallCoverImage;
  String mediumCoverImage;
  String largeCoverImage;

  String mediumScreenshot1;
  String mediumScreenshot2;
  String mediumScreenshot3;
  String largeScreenshot1;
  String largeScreenshot2;
  String largeScreenshot3;

  List<Cast> cast;

  List<Torrent> torrents;
  String dateUploaded;
  int dateUploadedUnix;

  Movie({
    required this.id,
    required this.url,
    required this.imdbCode,
    required this.title,
    required this.titleEnglish,
    required this.titleLong,
    required this.slug,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.likeCount,
    required this.descriptionIntro,
    required this.descriptionFull,
    required this.ytTrailerCode,
    required this.language,
    required this.mpaRating,
    required this.backgroundImage,
    required this.backgroundImageOriginal,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.mediumScreenshot1,
    required this.mediumScreenshot2,
    required this.mediumScreenshot3,
    required this.largeScreenshot1,
    required this.largeScreenshot2,
    required this.largeScreenshot3,
    required this.cast,
    required this.torrents,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      url: json['url'],
      imdbCode: json['imdb_code'],
      title: json['title'],
      titleEnglish: json['title_english'],
      titleLong: json['title_long'],
      slug: json['slug'],
      year: json['year'],
      rating: (json['rating'] as num).toDouble(),
      runtime: json['runtime'],
      genres: List<String>.from(json['genres']),
      likeCount: json['like_count'],
      descriptionIntro: json['description_intro'],
      descriptionFull: json['description_full'],
      ytTrailerCode: json['yt_trailer_code'],
      language: json['language'],
      mpaRating: json['mpa_rating'],
      backgroundImage: json['background_image'],
      backgroundImageOriginal: json['background_image_original'],
      smallCoverImage: json['small_cover_image'],
      mediumCoverImage: json['medium_cover_image'],
      largeCoverImage: json['large_cover_image'],
      mediumScreenshot1: json['medium_screenshot_image1'],
      mediumScreenshot2: json['medium_screenshot_image2'],
      mediumScreenshot3: json['medium_screenshot_image3'],
      largeScreenshot1: json['large_screenshot_image1'],
      largeScreenshot2: json['large_screenshot_image2'],
      largeScreenshot3: json['large_screenshot_image3'],
      cast: (json['cast'] as List).map((e) => Cast.fromJson(e)).toList(),
      torrents: (json['torrents'] as List).map((e) => Torrent.fromJson(e)).toList(),
      dateUploaded: json['date_uploaded'],
      dateUploadedUnix: json['date_uploaded_unix'],
    );
  }
}

class Cast {
  String name;
  String characterName;
  String urlSmallImage;
  String imdbCode;

  Cast({
    required this.name,
    required this.characterName,
    required this.urlSmallImage,
    required this.imdbCode,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      name: json['name'],
      characterName: json['character_name'],
      urlSmallImage: json['url_small_image'] ?? "",
      imdbCode: json['imdb_code'],
    );
  }
}

class Torrent {
  String url;
  String hash;
  String quality;
  String type;
  String isRepack;
  String videoCodec;
  String bitDepth;
  String audioChannels;
  int seeds;
  int peers;
  String size;
  int sizeBytes;
  String dateUploaded;
  int dateUploadedUnix;

  Torrent({
    required this.url,
    required this.hash,
    required this.quality,
    required this.type,
    required this.isRepack,
    required this.videoCodec,
    required this.bitDepth,
    required this.audioChannels,
    required this.seeds,
    required this.peers,
    required this.size,
    required this.sizeBytes,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  factory Torrent.fromJson(Map<String, dynamic> json) {
    return Torrent(
      url: json['url'],
      hash: json['hash'],
      quality: json['quality'],
      type: json['type'],
      isRepack: json['is_repack'],
      videoCodec: json['video_codec'],
      bitDepth: json['bit_depth'],
      audioChannels: json['audio_channels'],
      seeds: json['seeds'],
      peers: json['peers'],
      size: json['size'],
      sizeBytes: json['size_bytes'],
      dateUploaded: json['date_uploaded'],
      dateUploadedUnix: json['date_uploaded_unix'],
    );
  }
}

class Meta {
  int serverTime;
  String serverTimezone;
  int apiVersion;
  String executionTime;

  Meta({
    required this.serverTime,
    required this.serverTimezone,
    required this.apiVersion,
    required this.executionTime,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      serverTime: json['server_time'],
      serverTimezone: json['server_timezone'],
      apiVersion: json['api_version'],
      executionTime: json['execution_time'],
    );
  }
}
