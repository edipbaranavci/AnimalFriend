import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:friend_animals/modules/services/service.dart';
import '../../constant/enums.dart';
import '../models/image_upload_model.dart';

class ImageUploadService {
  final storage = FirebaseStorage.instance;

  String _fileEndGenerator(String fileName) {
    return fileName.substring(fileName.length - 4, fileName.length);
  }

  Future<String> setFile(String imagePath, String imageName) async {
    final File file = File(imagePath);
    final String fileEnd = _fileEndGenerator(imageName);
    final String fileCode = await _randomFileNameGenerator();
    final String fileName = fileCode + fileEnd;

    await _fileUpload(file, fileName);

    final String downloadUrl = await _getImageDownloadUrl(fileName);
    final imageUploadModel = ImageUploadModel(
      imageName: fileName,
      imageUrl: downloadUrl,
      imageCode: fileCode,
    );

    Service().imageNameUpload(imageUploadModel);
    return downloadUrl;
  }

  Future<void> _fileUpload(File file, String fileName) async {
    await storage.ref('${CollectionNames.image.name}/$fileName').putFile(file);
  }

  Future<String> _getImageDownloadUrl(String fileName) async {
    return await storage
        .ref('${CollectionNames.image.name}/$fileName')
        .getDownloadURL();
  }

  Future<bool> _fileExistControl(String fileName) async {
    var collection =
        FirebaseFirestore.instance.collection(CollectionNames.image.name);
    var docSnapshot = await collection.doc(fileName).get();
    return docSnapshot.exists;
  }

  Future<String> _randomFileNameGenerator() async {
    for (;;) {
      String lowerCase = 'QWERTYUOPLKJHGFDSAZXCVBNM'.toLowerCase();
      String availableChars = '${lowerCase}QWERTYUOPLKJHGFDSAZXCVBNM123456789';
      final randomString = List.generate(
          30,
          (index) =>
              availableChars[Random().nextInt(availableChars.length)]).join();
      if (await _fileExistControl(randomString) == false) {
        return randomString;
      }
    }
  }
}
