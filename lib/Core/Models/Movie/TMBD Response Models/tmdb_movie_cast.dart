class CastResponse {
  final int id;
  final String name;
  final String? character;
  final String? profilePath;

  CastResponse({
    required this.id,
    required this.name,
    this.character,
    this.profilePath,
  });

  factory CastResponse.fromJson(Map<String, dynamic> json) {
    return CastResponse(
      id: json['id'],
      name: json['name'] ?? '',
      character: json['character'],
      profilePath: json['profile_path'],
    );
  }
}

class MovieCreditsResponse {
  final int id;
  final List<CastResponse> cast;

  MovieCreditsResponse({
    required this.id,
    required this.cast,
  });

  factory MovieCreditsResponse.fromJson(Map<String, dynamic> json) {
    return MovieCreditsResponse(
      id: json['id'],
      cast: (json['cast'] as List)
          .map((e) => CastResponse.fromJson(e))
          .toList(),
    );
  }
}