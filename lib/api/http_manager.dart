import 'dart:convert';
import 'package:app/screen/auth/login/login_screen.dart';
import 'package:app/utility/constant.dart';
import 'package:app/utility/view_utlity.dart';
import 'package:get/get.dart' as navigation;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Map<String, dynamic> dioErrorHandle(DioException error) {
  switch (error.type) {
    case DioExceptionType.badResponse:
      return error.response?.data;
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return {"success": false, "code": "request_time_out"};

    default:
      return {"success": false, "code": "connect_to_server_fail"};
  }
}

class HTTPManager {
  BaseOptions baseOptions = BaseOptions(
    baseUrl: AppConstant.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    contentType: Headers.formUrlEncodedContentType,
    responseType: ResponseType.json,
  );

  ///Post method
  Future<dynamic> post({
    String? url,
    data,
    Options? options,
    BuildContext? context,
  }) async {
    var optionsMain = Options(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
      headers: {
        "Authorization": AppConstant.bearerToken != "null"
            ? "Bearer ${AppConstant.bearerToken}"
            : "",
      },
    );

    Dio dio = Dio(baseOptions);
    var internet = await ViewUtils.isConnected();
    if (internet == true) {
      try {
        final response = await dio.post(
          url!,
          data: data,
          options: optionsMain,
        );

        if (response.statusCode == 200 && response.statusCode == 422) {
          return response.data;
        } else {
          print(response.data);
          if (response.data.toString().contains("Unauthenticated")) {
            toastShow(message: "Your login expired please login again");
            await AppConstant.userDetailSaved("null");
            navigation.Get.to(() => const LoginScreen());
          }

          return response.data;
        }
      } on DioException catch (error) {
        print(error);
        if (error.message.toString().contains("401")) {
          toastShow(message: "Your login expired please login again");
          await AppConstant.userDetailSaved("null");

          navigation.Get.to(() => const LoginScreen());
        }
      }
    } else {
      ViewUtils.checkInternetConnectionDialog();
    }
  }

  Future<dynamic> postWithoutJson({
    String? url,
    data,
    Options? options,
    BuildContext? context,
  }) async {
    var optionsMain = Options(headers: {
      "Authorization": AppConstant.bearerToken != "null"
          ? "Bearer ${AppConstant.bearerToken}"
          : "",
      'Content-Type': 'multipart/form-data',
      "Accept": "application/json",
    });
    Dio dio = Dio(baseOptions);
    var internet = await ViewUtils.isConnected();
    if (internet == true) {
      try {
        final response = await dio.post(
          url!,
          data: data,
          options: optionsMain,
        );

        if (response.statusCode == 200) {
          return response.data;
        } else {
          if (response.data.toString().contains("Unauthenticated")) {
            toastShow(message: "Your login expired please login again");
            await AppConstant.userDetailSaved("null");

            navigation.Get.to(() => const LoginScreen());
          }
          return response.data;
        }
      } on DioException catch (error) {
        return dioErrorHandle(error);
      }
    } else {
      ViewUtils.checkInternetConnectionDialog();
    }
  }

  Future<dynamic> put(
      {String? url, data, Options? options, BuildContext? context}) async {
    var optionsMain = Options(headers: {
      "Authorization": AppConstant.bearerToken != "null"
          ? "Bearer ${AppConstant.bearerToken}"
          : "",
      "Accept": "application/json",
    });
    Dio dio = Dio(baseOptions);
    var internet = await ViewUtils.isConnected();
    if (internet == true) {
      try {
        final response = await dio.put(
          url!,
          data: data,
          //  data: data,
          options: optionsMain,
        );
        if (response.statusCode == 200) {
          return response.data;
        } else {
          if (response.data.toString().contains("Unauthenticated")) {
            toastShow(message: "Your login expired please login again");
            await AppConstant.userDetailSaved("null");

            navigation.Get.to(() => const LoginScreen());
          }
          return response.data;
        }
      } on DioException catch (error) {
        if (error.message.toString().contains("401")) {
          toastShow(message: "Your login expired please login again");
          await AppConstant.userDetailSaved("null");

          navigation.Get.to(() => const LoginScreen());
        }
        return dioErrorHandle(error);
      }
    } else {
      ViewUtils.checkInternetConnectionDialog();
    }
  }

  Future<dynamic> get({
    String? url,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    var optionsMain = Options(headers: {
      "Authorization": AppConstant.bearerToken != "null"
          ? "Bearer ${AppConstant.bearerToken}"
          : "",
      "Accept": 'application/json'
    });
    Dio dio = Dio(baseOptions);
    var internet = await ViewUtils.isConnected();
    if (internet == true) {
      try {
        final response = await dio.get(
          url!,
          queryParameters: params,
          options: optionsMain,
        );

        return response.data;
      } on DioException catch (error) {
        if (error.message.toString().contains("401")) {
          toastShow(message: "Your login expired please login again");
          await AppConstant.userDetailSaved("null");

          navigation.Get.to(() => const LoginScreen());
        }
        return dioErrorHandle(error);
      }
    } else {
      ViewUtils.checkInternetConnectionDialog();
    }
  }

  Future<dynamic> patch(
      {String? url, data, Options? options, BuildContext? context}) async {
    var optionsMain = Options(headers: {
      "Authorization": AppConstant.bearerToken != "null"
          ? "Bearer ${AppConstant.bearerToken}"
          : "",
      "Accept": 'application/json'
    });

    Dio dio = Dio(baseOptions);
    var internet = await ViewUtils.isConnected();
    if (internet == true) {
      try {
        final response = await dio.patch(
          url!,
          queryParameters: data,
          options: optionsMain,
        );

        if (response.statusCode == 200) {
          return response.data;
        } else {
          navigation.Get.to(() => const LoginScreen());
        }
      } on DioException catch (error) {
        if (error.message.toString().contains("401")) {
          toastShow(message: "Your login expired please login again");
          await AppConstant.userDetailSaved("null");

          navigation.Get.to(() => const LoginScreen());
        }
        return dioErrorHandle(error);
      }
    } else {
      ViewUtils.checkInternetConnectionDialog();
    }
  }

  ///Delete WithToken method
  Future<dynamic> deleteWithToken({
    String? url,
    data,
    Options? options,
    BuildContext? context,
  }) async {
    var optionsMain = Options(headers: {
      "Authorization": AppConstant.bearerToken != "null"
          ? "Bearer ${AppConstant.bearerToken}"
          : "",
      "Accept": 'application/json',
      "Content-Type": "application/json"
    });
    Dio dio = Dio(baseOptions);
    var internet = await ViewUtils.isConnected();
    if (internet == true) {
      try {
        final response = await dio.delete(
          url!,
          data: jsonEncode(data),
          options: optionsMain,
        );
        if (response.statusCode == 200) {
          return response.data;
        } else {
          navigation.Get.to(() => const LoginScreen());
        }
      } on DioException catch (error) {
        if (error.message.toString().contains("401")) {
          toastShow(message: "Your login expired please login again");
          await AppConstant.userDetailSaved("null");

          navigation.Get.to(() => const LoginScreen());
        }
        return dioErrorHandle(error);
      }
    } else {
      ViewUtils.checkInternetConnectionDialog();
    }
  }

  getOptions() async {
    var optionsMain = Options();
    return optionsMain;
  }

  factory HTTPManager() {
    return HTTPManager._internal();
  }

  HTTPManager._internal();
}

HTTPManager httpManager = HTTPManager();
