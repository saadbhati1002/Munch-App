import 'dart:io';

import 'package:app/api/network/auth/auth.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  Future<dynamic> userRegisterApiCall(
      {String? userName,
      String? email,
      String? password,
      String? bio,
      File? userImage}) async {
    String fileName = userImage!.path.split('/').last;

    final body = FormData.fromMap({
      "image": await MultipartFile.fromFile(userImage.path, filename: fileName),
      "email": email,
      "password": password,
      "c_password": password,
      "bio": bio,
      "name": userName
    });
    return await AuthNetwork.registerUser(body);
  }
}
