import 'dart:convert';

class FavoritePostModel {
  final bool favoriteBool;
  final String favoriteDate;
  final String postId;
  final String userMail;
  FavoritePostModel({
    required this.favoriteBool,
    required this.favoriteDate,
    required this.postId,
    required this.userMail,
  });

  FavoritePostModel copyWith({
    bool? favoriteBool,
    String? favoriteDate,
    String? postId,
    String? userMail,
  }) {
    return FavoritePostModel(
      favoriteBool: favoriteBool ?? this.favoriteBool,
      favoriteDate: favoriteDate ?? this.favoriteDate,
      postId: postId ?? this.postId,
      userMail: userMail ?? this.userMail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'favoriteBool': favoriteBool,
      'favoriteDate': favoriteDate,
      'postId': postId,
      'userMail': userMail,
    };
  }

  factory FavoritePostModel.fromMap(Map<String, dynamic> map) {
    return FavoritePostModel(
      favoriteBool: map['favoriteBool'] as bool,
      favoriteDate: map['favoriteDate'] as String,
      postId: map['postId'] as String,
      userMail: map['userMail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoritePostModel.fromJson(String source) =>
      FavoritePostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FavoritePostModel(favoriteBool: $favoriteBool, favoriteDate: $favoriteDate, postId: $postId, userMail: $userMail)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoritePostModel &&
        other.favoriteBool == favoriteBool &&
        other.favoriteDate == favoriteDate &&
        other.postId == postId &&
        other.userMail == userMail;
  }

  @override
  int get hashCode {
    return favoriteBool.hashCode ^
        favoriteDate.hashCode ^
        postId.hashCode ^
        userMail.hashCode;
  }
}
