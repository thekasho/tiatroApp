import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../data/source/remote/init_data.dart';
import '../../repository/api/api.dart';
import '../../repository/models/channel_serie.dart';

abstract class SeriesChannelsController extends GetxController {
  getSeries(dynamic catId);
}
class SeriesChannelsControllerImp extends SeriesChannelsController {
  
  InitData initData = InitData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  
  List series = [];
  List finalCH = [];
  int seriesCount = 0;

  @override
  getSeries(catId) async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      final user = await LocaleApi.getUser();
      final favs = await LocaleApi.getFavouriteSeries();
      final loginData = await LocaleApi.getLoginInfo();
      if(user == null || loginData == null){
        Get.defaultDialog(title: "Error", middleText: "Server Error!!");
        return;
      }

      var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${loginData.password}&username=${loginData.username}&action=get_series&category_id=$catId";
      var getSeries = await initData.getSeries(url);

      series = [];
      final moviesList = getSeries.map( (e) => ChannelSerie.fromJson(e) ).toList();

      series.addAll(moviesList);
      seriesCount = moviesList.length;

      List strNum = [];
      List strName = [];
      List strSeriesId = [];
      List strSeriesCover = [];
      List strPlot = [];
      List strRating = [];
      List strRating5based = [];
      List strCategoryId = [];
            
      int StrLength = 0;
      
      if(catId == "1000000") {
        favs?.entries.forEach((element) {
          List<String> words = element.value['content'].replaceAll(RegExp('{'), '').replaceAll(RegExp('}'), '').split(",");
          print(words);
          strNum.add(words[0].split(":").map((e) { return e.isEmpty ? 0 :e; }).toList());
          strName.add(words[1].split(":").map((e) {
            return e.isEmpty ? 0 : e;
          }).toList());
          strSeriesId.add(words[2].split(":").map((e) { return e.isEmpty ? 0 :e; }).toList());
          strSeriesCover.add(words[3].split(": ").map((e) { return e.replaceAll(RegExp(' '), '').isEmpty ? null :e; }).toList());
          strPlot.add(words[4].split(":").map((e) { return e.isEmpty ? 0 :e; }).toList());
          strRating.add(words[5].split(":").map((e) { return e.isEmpty ? 0 :e; }).toList());
          strRating5based.add(words[6].split(":").map((e) { return e.isEmpty ? 0 :e; }).toList());
          strCategoryId.add(words[7].split(":").map((e) { return e.isEmpty ? 0 :e; }).toList());
          
          StrLength ++;
        });
        
        List finalListt = [];
        
        for(var i=0; i<StrLength; i++){
          
          String finalName = '';
          for ( var s=1; s < strName[i].length; s++  ){
            finalName += strName[i][s];
          }
          
          final Map<String, dynamic> chss = {
            strNum[i][0].replaceAll(RegExp(' '), '') : strNum[i][1],
            strName[i][0].replaceAll(RegExp(' '), '') : finalName,
            strSeriesId[i][0].replaceAll(RegExp(' '), '') : strSeriesId[i][1].replaceAll(RegExp(' '), ''),
            strSeriesCover[i][0].replaceAll(RegExp(' '), '') : strSeriesCover[i][1],
            strPlot[i][0].replaceAll(RegExp(' '), '') : strPlot[i][1],
            strRating[i][0].replaceAll(RegExp(' '), '') : strRating[i][1].toString(),
            strRating5based[i][0].replaceAll(RegExp(' '), '') : strRating5based[i][1].toString(),
            strCategoryId[i][0].replaceAll(RegExp(' '), '') : strCategoryId[i][1],
          };
          finalListt.add(chss);
        }

        final channelsList = finalListt.map( (e) => ChannelSerie.fromJson(e) ).toList();
        series.addAll(channelsList);
        update();
      }

      statusRequest = StatusRequest.success;
      update();

    } catch(e) {
      print(e);
    }
  }
}