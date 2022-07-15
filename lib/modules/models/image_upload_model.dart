import 'dart:convert';

class ImageUploadModel {
  final String? imageName;
  final String? imageUrl;
  final String? imageCode;

  ImageUploadModel({
    this.imageName,
    this.imageUrl,
    this.imageCode,
  });

  ImageUploadModel copyWith({
    String? imageName,
    String? imageUrl,
    String? imageCode,
  }) {
    return ImageUploadModel(
      imageName: imageName ?? this.imageName,
      imageUrl: imageUrl ?? this.imageUrl,
      imageCode: imageCode ?? this.imageCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageName': imageName,
      'imageUrl': imageUrl,
      'imageCode': imageCode,
    };
  }

  factory ImageUploadModel.fromMap(Map<String, dynamic> map) {
    return ImageUploadModel(
      imageName: map['imageName'] != null ? map['imageName'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      imageCode: map['imageCode'] != null ? map['imageCode'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageUploadModel.fromJson(String source) =>
      ImageUploadModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ImageUploadModel(imageName: $imageName, imageUrl: $imageUrl, imageCode: $imageCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImageUploadModel &&
        other.imageName == imageName &&
        other.imageUrl == imageUrl &&
        other.imageCode == imageCode;
  }

  @override
  int get hashCode =>
      imageName.hashCode ^ imageUrl.hashCode ^ imageCode.hashCode;
}
