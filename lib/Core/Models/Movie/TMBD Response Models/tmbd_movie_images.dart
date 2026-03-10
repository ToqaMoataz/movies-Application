class MovieImagesResponse {
  final int id;
  final List<MovieImage> backdrops;


  MovieImagesResponse({
    required this.id,
    required this.backdrops,
  });

  factory MovieImagesResponse.fromJson(Map<String, dynamic> json) {
    return MovieImagesResponse(
      id: json['id'],
      backdrops: (json['backdrops'] as List)
          .map((e) => MovieImage.fromJson(e))
          .toList(),
    );
  }
}
class MovieImage {
  final double aspectRatio;
  final int height;
  final int width;
  final String filePath;

  MovieImage({
    required this.aspectRatio,
    required this.height,
    required this.width,
    required this.filePath,
  });

  factory MovieImage.fromJson(Map<String, dynamic> json) {
    return MovieImage(
      aspectRatio: (json['aspect_ratio'] as num).toDouble(),
      height: json['height'],
      width: json['width'],
      filePath: json['file_path'],
    );
  }
}