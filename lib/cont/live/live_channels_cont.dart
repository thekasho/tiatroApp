import 'dart:async';

import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../data/source/remote/init_data.dart';
import '../../repository/api/api.dart';
import '../../repository/models/channelLive.dart';

abstract class LiveChannelsController extends GetxController {
  getLiveCatChilds(dynamic CatId);
  openStream(dynamic streamId);
  getLiveCatChild();
}
class LiveChannelsControllerImp extends LiveChannelsController {
  InitData initData = InitData(Get.find());

  StatusRequest statusRequest = StatusRequest.none;

  List channels = [];
  List finalCH = [];
  bool favOn = false;

  @override
  getLiveCatChild() async {
    try {
      final user = await LocaleApi.getUser();
      final favs = await LocaleApi.getFavourite();
      final loginData = await LocaleApi.getLoginInfo();
      if(user == null || loginData == null){
        Get.defaultDialog(title: "Error", middleText: "Server Error!!");
        return;
      }

      var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${loginData.password}&username=${loginData!.username}&action=get_live_streams";
      var liveCatChilds = await initData.getLiveCatChilds(url);
      
      print(liveCatChilds[214]);
    } catch (e) {
      print(e);
    }
  }

  @override
  getLiveCatChilds(CatId) async {        
    print(CatId);
    try {
      statusRequest = StatusRequest.loading;
      update();

      final user = await LocaleApi.getUser();
      final favs = await LocaleApi.getFavourite();
      final loginData = await LocaleApi.getLoginInfo();
      if(user == null || loginData == null){
        Get.defaultDialog(title: "Error", middleText: "Server Error!!");
        return;
      }
      
      var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${loginData.password}&username=${loginData!.username}&action=get_live_streams&category_id=$CatId";
      var liveCatChilds = await initData.getLiveCatChilds(url);

      channels = [];
      final channelsList = liveCatChilds.map( (e) => ChannelLive.fromJson(e) ).toList();

      channels.addAll(channelsList);

      List strNum = [];
      List strName = [];
      List strStreamType = [];
      List strStreamId = [];
      List strStreamIcon = [];
      List strEpgChannelId = [];
      List strAdded = [];
      List strIsAdult = [];
      List strCategoryId = [];
      List strCustomSid = [];
      List strTvArchive = [];
      List strDirectSource = [];
      List strTvArchiveDuration = [];
      int StrLength = 0;
      
      if(CatId == "1000000"){
        favs?.entries.forEach((element) {
          List<String> words = element.value['content'].replaceAll(RegExp('{'), '').replaceAll(RegExp('}'), '').split(",");

          strNum.add(words[0].split(":").map((e) { return e.isEmpty ? 0 :e; }).toList());
          
          strName.add(words[1].split(":").map((e) {
            return e.isEmpty ? 0 : e;
          }).toList());
          
          strStreamType.add(words[2].split(":").map((e) { return e.isEmpty ? 0 :e; }).toList());
          strStreamId.add(words[3].split(":").map((e) { return e.isEmpty ? 0 :e; }).toList());
          strStreamIcon.add(words[4].split(": ").map((e) { return e.replaceAll(RegExp(' '), '').isEmpty ? null :e; }).toList());
          strEpgChannelId.add(words[5].split(":").map((e) { return e.isEmpty ? 0 :e; }).toList());
          strAdded.add(words[6].split(":").map((e) { return e.isEmpty ? 0 :e; }).toList());
          strIsAdult.add(words[7].split(":").map((e) { return e.isEmpty ? 0 :e; }).toList());
          strCategoryId.add(words[8].split(":").map((e) { return e.isEmpty ? 0 :e; }).toList());
          strCustomSid.add(words[9].split(":").map((e) { return e.isEmpty ? 0 :e; }).toList());
          strTvArchive.add(words[10].split(":").map((e) { return e.isEmpty ? 0 :e; }).toList());
          strDirectSource.add(words[11].split(":").map((e) { return e.isEmpty ? 0 :e; }).toList());
          strTvArchiveDuration.add(words[12].split(":").map((e) { return e.isEmpty ? 0 :e; }).toList());

          StrLength ++;
        });
        List finalListt = [];
        
        for(var i=0; i<StrLength; i++){
          
          String finalName = '';
          for ( var s=1; s < strName[i].length; s++  ){
            finalName += strName[i][s];
            print(finalName);
          }
          
          final Map<String, dynamic> chss = {
            strNum[i][0].replaceAll(RegExp(' '), '') : strNum[i][1],
            strName[i][0].replaceAll(RegExp(' '), '') : finalName,
            strStreamType[i][0].replaceAll(RegExp(' '), '') : strStreamType[i][1].toString(),
            strStreamId[i][0].replaceAll(RegExp(' '), '') : strStreamId[i][1].replaceAll(RegExp(' '), ''),
            strStreamIcon[i][0].replaceAll(RegExp(' '), '') : strStreamIcon[i][1],
            strEpgChannelId[i][0].replaceAll(RegExp(' '), '') : strEpgChannelId[i][1].toString(),
            strAdded[i][0].replaceAll(RegExp(' '), '') : strAdded[i][1],
            strIsAdult[i][0].replaceAll(RegExp(' '), '') : strIsAdult[i][1].toString(),
            strCategoryId[i][0].replaceAll(RegExp(' '), '') : strCategoryId[i][1],
            strCustomSid[i][0].replaceAll(RegExp(' '), '') : strCustomSid[i][1],
            strTvArchive[i][0].replaceAll(RegExp(' '), '') : strTvArchive[i][1].toString(),
            strDirectSource[i][0].replaceAll(RegExp(' '), '') : strDirectSource[i][1].toString(),
            strTvArchiveDuration[i][0].replaceAll(RegExp(' '), '') : strTvArchiveDuration[i][1].toString(),
          };
          
          finalListt.add(chss);
        }
        
        final channelsList = finalListt.map( (e) => ChannelLive.fromJson(e) ).toList();
        channels.addAll(channelsList);
        update();
        
      }
      statusRequest = StatusRequest.success;
      update();

    } catch (e) {
      print(e);
    }
  }

  applyFirstCat() async {
    statusRequest = StatusRequest.loading;
    update();
    final user = await LocaleApi.getUser();
    final loginData = await LocaleApi.getLoginInfo();
    if(user == null || loginData == null){
      Get.defaultDialog(title: "Error", middleText: "Server Error!!");
      return;
    }
    var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${loginData.password}&username=${loginData.username}&action=get_live_categories";
    List liveCats = await initData.getLiveCats(url);
    
    Future waitWhile(bool liveCats, [Duration pollInterval = Duration.zero]) {
      var completer = Completer();
      check() {
        if (liveCats) {
          completer.complete();
        } else {
          Timer(pollInterval, check);
        }
      }
      check();
      return completer.future;
    }
    await waitWhile(liveCats.isNotEmpty).then((value) => getLiveCatChilds("${liveCats[1]['category_id']}"));
  }

  @override
  openStream(streamId) async {
    final user = await LocaleApi.getUser();
    final loginData = await LocaleApi.getLoginInfo();
    Map? favs = await LocaleApi.getFavourite();
    if(user == null || loginData == null){
      Get.defaultDialog(title: "Error", middleText: "Server Error!!");
      return;
    }
    
    var favIds = favs?["$streamId"];

    if(favIds != null){
      favOn = true;
      update();
    }
    else {
      favOn = false;
      update();
    }
    
    final link =
        "${user.serverInfo!.serverUrl}/"
        "${loginData.username}/"
        "${loginData.password}/"
        "$streamId";
    return link;
  }

  @override
  void onInit() {
    applyFirstCat();
    getLiveCatChild();
    super.onInit();
  }

  @override
  void dispose() {

    super.dispose();
  }

}