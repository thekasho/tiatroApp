import 'dart:async';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../core/class/statusrequest.dart';
import '../../data/source/remote/call_server.dart';
import '../../data/source/remote/init_data.dart';
import '../../repository/api/api.dart';
import '../../repository/models/category.dart';

abstract class LiveCatsController extends GetxController {
  getLiveCats();
}
class LiveCatsControllerImp extends LiveCatsController {
  InitData initData = InitData(Get.find());
  CallServer callServer = CallServer(Get.find());

  StatusRequest statusRequest = StatusRequest.none;
  VideoPlayerController? videoPlayerController;

  List categories = [];
  List liveCat = [];

  var favCat = [{"category_id": "1000000", "category_name": "المفضلة", "parent_id": "0"}];
  int selectedCat = 2;

  @override
  getLiveCats() async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      final user = await LocaleApi.getUser();
      final loginData = await LocaleApi.getLoginInfo();
      var oldLiveCats = await LocaleApi.getLiveCats();
      
      if(user == null || loginData == null){
        Get.defaultDialog(title: "Error", middleText: "Server Error!!");
        return;
      }

      if(oldLiveCats == null){
        var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${loginData.password}&username=${loginData.username}&action=get_live_categories";
        oldLiveCats = await initData.getLiveCats(url);
        Future waitWhile(bool oldLiveCats, [Duration pollInterval = Duration.zero]) {
          var completer = Completer();
          check() {
            if (oldLiveCats) {
              completer.complete();
            } else {
              Timer(pollInterval, check);
            }
          }
          check();
          return completer.future;
        }
        await waitWhile(oldLiveCats!.isNotEmpty).then((value) async => await LocaleApi.saveLiveCats(oldLiveCats));
        update();
      }
      
      liveCat = [];
      categories = [];
      
      liveCat.addAll(favCat);
      liveCat.addAll(oldLiveCats);
      
      final list = liveCat.map((e) => CategoryModel.fromJson(e)).toList();
      categories.addAll(list);
      
      statusRequest = StatusRequest.success;
      update();
      
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    getLiveCats();
    super.onInit();
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }
}
