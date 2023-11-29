import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data.dart';
import '../../data/source/remote/call_server.dart';
import '../../data/source/remote/init_data.dart';
import '../../repository/api/api.dart';
import '../../repository/models/category.dart';
import '../../repository/models/user.dart';

abstract class SeriesCatsController extends GetxController {
  getCats();
}
class SeriesCatsControllerImp extends SeriesCatsController {

  InitData initData = InitData(Get.find());
  CallServer callServer = CallServer(Get.find());

  StatusRequest statusRequest = StatusRequest.none;

  List categories = [];
  int selectedCat = 1;

  var favCat = [{"category_id": "1000000", "category_name": "المفضلة", "parent_id": "0"}];

  var cats = [];

  @override
  getCats() async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      final user = await LocaleApi.getUser();
      final loginData = await LocaleApi.getLoginInfo();
      if(user == null || loginData == null){
        Get.defaultDialog(title: "Error", middleText: "Server Error!!");
        return;
      }

      var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${loginData.password}&username=${loginData.username}&action=get_series_categories";
      var liveCats = await initData.getLiveCats(url);

      categories = [];
      cats = [];

      cats.addAll(favCat);
      cats.addAll(liveCats);

      final list = cats.map((e) => CategoryModel.fromJson(e)).toList();
      categories.addAll(list);

      statusRequest = StatusRequest.success;
      update();
      
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    getCats();
    super.onInit();
  }
}