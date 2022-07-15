// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? displayName;
  final String? email;
  final String? id;
  final String? photoUrl;
  final String? loginDate;

  UserModel({
    this.displayName,
    this.email,
    this.id,
    this.photoUrl,
    this.loginDate,
  });

  UserModel copyWith({
    String? displayName,
    String? email,
    String? id,
    String? photoUrl,
    String? loginDate,
  }) {
    return UserModel(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      id: id ?? this.id,
      photoUrl: photoUrl ?? this.photoUrl,
      loginDate: loginDate ?? this.loginDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'email': email,
      'id': id,
      'photoUrl': photoUrl,
      'loginDate': loginDate,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'UserModel(displayName: $displayName, email: $email, id: $id, photoUrl: $photoUrl, loginDate: $loginDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.displayName == displayName &&
        other.email == email &&
        other.id == id &&
        other.photoUrl == photoUrl &&
        other.loginDate == loginDate;
  }

  @override
  int get hashCode {
    return displayName.hashCode ^
        email.hashCode ^
        id.hashCode ^
        photoUrl.hashCode ^
        loginDate.hashCode;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      loginDate: map['loginDate'] != null ? map['loginDate'] as String : null,
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
