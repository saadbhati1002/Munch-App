import 'package:app/api/http_manager.dart';
import 'package:app/models/common_model.dart';
import 'package:app/models/list/add/add_list_model.dart';
import 'package:app/models/list/list_model.dart';

class ListNetwork {
  static const String listUrl = "ingredent/get";
  static const String listAddUrl = "ingredent/post";
  static const String listEditUrl = "ingredent/edit";
  static const String listRemoveUrl = "ingredent/delete";
  static Future<dynamic> getList() async {
    final result = await httpManager.get(url: listUrl);
    print(result);
    ListRes response = ListRes.fromJson(result);
    return response;
  }

  static Future<dynamic> addList(param) async {
    final result = await httpManager.post(url: listAddUrl, data: param);

    AddListRes response = AddListRes.fromJson(result);
    return response;
  }

  static Future<dynamic> removeList(param) async {
    final result = await httpManager.post(url: listRemoveUrl, data: param);
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> editList(param) async {
    final result = await httpManager.post(url: listEditUrl, data: param);
    AddListRes response = AddListRes.fromJson(result);
    return response;
  }
}
