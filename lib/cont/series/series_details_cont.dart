import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../data/source/remote/call_server.dart';
import '../../data/source/remote/init_data.dart';
import '../../repository/api/api.dart';
import '../../repository/models/channel_serie.dart';
import '../../repository/models/serie_details.dart';

abstract class SeriesDetailsController extends GetxController {
  getSeriesDetails(dynamic seriesId);
  getAuthLink();
  addFav(dynamic seriesId);
}
class SeriesDetailsControllerImp extends SeriesDetailsController {

  InitData initData = InitData(Get.find());
  CallServer callServer = CallServer(Get.find());

  StatusRequest statusRequest = StatusRequest.none;

  late SerieDetails serieDetails;
  late int seriesId;
  bool favOn = false;
  List series = [];

  @override
  addFav(seriesId) async {
    try {
      final user = await LocaleApi.getUser();
      final loginData = await LocaleApi.getLoginInfo();
      if(user == null || loginData == null){
        Get.defaultDialog(title: "Error", middleText: "Server Error!!");
        return;
      }

      var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${loginData.password}&username=${loginData.username}&action=get_series_info&series_id=$seriesId";
      var getSeries = await initData.getSeriesDetails(url);
      final serie = SerieDetails.fromJson(getSeries);
      final catId = serie.info!.categoryId;

      var caturl = "${user.serverInfo!.serverUrl}/player_api.php?password=${loginData.password}&username=${loginData.username}&action=get_series&category_id=$catId";
      var getSerFav = await initData.getSeries(caturl);
      
      series = [];
      final seriesList = getSerFav.map( (e) => ChannelSerie.fromJson(e) ).toList();
      series.addAll(seriesList);

      Map? newFav = {};
      seriesList.forEach((element) {
        if(element.seriesId == seriesId){
          newFav = element.toJson();
        }
      });

      Map<String, Map<dynamic, dynamic>> new_favData = {
        seriesId : {
          'content': "$newFav",
        }
      };

      Map? oldFav = await LocaleApi.getFavouriteSeries();

      var favIds = oldFav?[seriesId.toString()];

      if(favIds == null){
        if(oldFav != null){
          oldFav.addAll(new_favData);
          var saveFav = await LocaleApi.saveFavouriteSeries(oldFav);
          print("Update: $saveFav");
        }
        else {
          var saveFav = await LocaleApi.saveFavouriteSeries(new_favData);
          print("Save: $saveFav");
        }
      } else {
        oldFav!.removeWhere((key, value) => key == "$seriesId");
        var saveFav = await LocaleApi.saveFavouriteSeries(oldFav);
        print(saveFav);
      }
      
      update();
      
    } catch(e){
      print("Error: $e");
    }
  }

  @override
  getSeriesDetails(seriesId) async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      final user = await LocaleApi.getUser();
      Map? favs = await LocaleApi.getFavouriteSeries();
      final loginData = await LocaleApi.getLoginInfo();
      if(user == null || loginData == null){
        Get.defaultDialog(title: "Error", middleText: "Server Error!!");
        return;
      }

      var fav_ids = favs?["$seriesId"];

      if(fav_ids != null){
        favOn = true;
        update();
      }
      else {
        favOn = false;
        update();
      }
      
      var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${loginData.password}&username=${loginData.username}&action=get_series_info&series_id=$seriesId";

      var getSeries = await initData.getSeriesDetails(url);

      final series = SerieDetails.fromJson(getSeries);
      serieDetails = series;

      statusRequest = StatusRequest.success;
      update();

    } catch(e){
      print("error: $e");
    }
  }
  
  @override
  getAuthLink() async {
    final user = await LocaleApi.getUser();
    final loginData = await LocaleApi.getLoginInfo();

    final link =
        "${user?.serverInfo!.serverUrl}/series/${loginData!.username}/${loginData.password}/";
    return link;
  }
  
}