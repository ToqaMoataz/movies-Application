class UserModel {
  late String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String image;
  List<int>? historyList;
  List<int>? toWatchList;

  UserModel({
    this.id = "",
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.image,
    this.historyList,
    this.toWatchList,
  });

  /// Convert Firestore JSON → UserModel
  static UserModel fromJson(Map<String, dynamic> json, {String id = ""}) {
    return UserModel(
      id: id,
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
      image: json['image'] ?? "",
      historyList: json['history'] != null
          ? List<int>.from(json['history'])
          : <int>[],
      toWatchList: json['toWatchList'] != null
          ? List<int>.from(json['toWatchList'])
          : <int>[],
    );
  }

  /// Convert UserModel → Firestore JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'image': image,
      'history': historyList ?? <String>[],  
      'toWatchList': toWatchList ?? <String>[],
    };
  }
}
