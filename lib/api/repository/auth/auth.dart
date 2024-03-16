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

  Future<dynamic> userLoginApiCall({String? email, String? password}) async {
    final params = {"email": email, "password": password};
    return await AuthNetwork.loginUser(params);
  }

  Future<dynamic> userProfileUpdateApiCall(
      {String? userName,
      String? phoneNumber,
      String? address,
      String? dateOfBirth,
      String? bio,
      File? userImage}) async {
    var body;
    if (userImage != null) {
      String fileName = userImage.path.split('/').last;

      body = FormData.fromMap({
        "image":
            await MultipartFile.fromFile(userImage.path, filename: fileName),
        "mobile_number": phoneNumber,
        "dob": dateOfBirth,
        "address": address,
        "bio": bio,
        "name": userName
      });
    } else {
      body = FormData.fromMap({
        "mobile_number": phoneNumber,
        "dob": dateOfBirth,
        "address": address,
        "bio": bio,
        "name": userName
      });
    }
    return await AuthNetwork.updateUserUser(body);
  }

  Future<dynamic> changePasswordApiCall(
      {String? oldPassword, String? newPassword}) async {
    final params = {
      "current_password": oldPassword,
      "new_password": newPassword,
      "confirm_password": newPassword
    };
    return await AuthNetwork.userChangePassword(params);
  }
}
