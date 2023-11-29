import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../data/source/remote/call_server.dart';
import '../../data/source/remote/init_data.dart';
import '../../repository/api/api.dart';
import '../../repository/models/channelLive.dart';

abstract class CatsController extends GetxController {
  changeTab(int tabId);
  addFav(ChannelLive stream);
}

class CatsControllerImp extends CatsController {
  InitData initData = InitData(Get.find());
  CallServer callServer = CallServer(Get.find());
  
  int activeTab = 1;

  StatusRequest statusRequest = StatusRequest.none;
  
  @override
  changeTab(tabId){
    activeTab = tabId;
    update();
  }

  @override
  addFav(stream) async {
    
    Map? newFav = stream.toJson();
    
    Map<String, Map<dynamic, dynamic>> new_favData = {
      stream.streamId.toString(): {
        'content': "$newFav",
      }
    };
    Map? oldFav = await LocaleApi.getFavourite();
    var favIds = oldFav?["${stream.streamId}"];
    if(favIds == null){
      if(oldFav != null){
        oldFav.addAll(new_favData);
        var saveFav = await LocaleApi.saveFavourite(oldFav);
        print("Update: $saveFav");
      }
      else {
        var saveFav = await LocaleApi.saveFavourite(new_favData);
        print("Save: $saveFav");
      }
    } else {
      oldFav!.removeWhere((key, value) => key == "${stream.streamId}");
      var saveFav = await LocaleApi.saveFavouriteMovies(oldFav);
      print("Update: $saveFav");
    }
    update();
  }


  @override
  void dispose() {
    
    super.dispose();
  }
  
}