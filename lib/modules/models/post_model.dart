import 'dart:convert';

class PostModel {
  final String? postDate;
  final String? postAbout;
  final int? postFavoriteCount;
  final int? postShowCount;
  final String? postImage;
  final String? postLocation;
  final String? postTitle;
  final String? userMail;

  PostModel({
    this.postDate,
    this.postAbout,
    this.postFavoriteCount,
    this.postShowCount,
    this.postImage,
    this.postLocation,
    this.postTitle,
    this.userMail,
  });

  PostModel copyWith({
    String? postDate,
    String? postAbout,
    int? postFavoriteCount,
    int? postShowCount,
    String? postImage,
    String? postLocation,
    String? postTitle,
    String? userMail,
  }) {
    return PostModel(
      postDate: postDate ?? this.postDate,
      postAbout: postAbout ?? this.postAbout,
      postFavoriteCount: postFavoriteCount ?? this.postFavoriteCount,
      postShowCount: postShowCount ?? this.postShowCount,
      postImage: postImage ?? this.postImage,
      postLocation: postLocation ?? this.postLocation,
      postTitle: postTitle ?? this.postTitle,
      userMail: userMail ?? this.userMail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postDate': postDate,
      'postAbout': postAbout,
      'postFavoriteCount': postFavoriteCount,
      'postShowCount': postShowCount,
      'postImage': postImage,
      'postLocation': postLocation,
      'postTitle': postTitle,
      'userMail': userMail,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      postDate: map['postDate'] != null ? map['postDate'] as String : null,
      postAbout: map['postAbout'] != null ? map['postAbout'] as String : null,
      postFavoriteCount: map['postFavoriteCount'] != null
          ? map['postFavoriteCount'] as int
          : null,
      postShowCount:
          map['postShowCount'] != null ? map['postShowCount'] as int : null,
      postImage: map['postImage'] != null ? map['postImage'] as String : null,
      postLocation:
          map['postLocation'] != null ? map['postLocation'] as String : null,
      postTitle: map['postTitle'] != null ? map['postTitle'] as String : null,
      userMail: map['userMail'] != null ? map['userMail'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(postDate: $postDate, postAbout: $postAbout, postFavoriteCount: $postFavoriteCount, postShowCount: $postShowCount, postImage: $postImage, postLocation: $postLocation, postTitle: $postTitle, userMail: $userMail)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostModel &&
        other.postDate == postDate &&
        other.postAbout == postAbout &&
        other.postFavoriteCount == postFavoriteCount &&
        other.postShowCount == postShowCount &&
        other.postImage == postImage &&
        other.postLocation == postLocation &&
        other.postTitle == postTitle &&
        other.userMail == userMail;
  }

  @override
  int get hashCode {
    return postDate.hashCode ^
        postAbout.hashCode ^
        postFavoriteCount.hashCode ^
        postShowCount.hashCode ^
        postImage.hashCode ^
        postLocation.hashCode ^
        postTitle.hashCode ^
        userMail.hashCode;
  }
}
