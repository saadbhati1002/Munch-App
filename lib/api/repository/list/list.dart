import 'package:app/api/network/list/list.dart';

class ListRepository {
  Future<dynamic> getListApiCall() async {
    return await ListNetwork.getList();
  }

  Future<dynamic> addListApiCall(
      {String? recipeName, String? servingPortion, String? ingredient}) async {
    final param = {
      "recipe_name": recipeName,
      "serving_portion": servingPortion,
      "ingredent": ingredient
    };
    return await ListNetwork.addList(param);
  }

  Future<dynamic> removeListApiCall({
    String? id,
  }) async {
    final param = {
      "id": id,
    };
    return await ListNetwork.removeList(param);
  }
}
