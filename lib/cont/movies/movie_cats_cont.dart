import 'dart:async';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../data/source/remote/call_server.dart';
import '../../data/source/remote/init_data.dart';
import '../../repository/api/api.dart';
import '../../repository/models/category.dart';
import 'movie_channel_cont.dart';

abstract class MoviesCatsController extends GetxController {
  getCats();
  updateMovieCatsList();
}

class MoviesCatsControllerImp extends MoviesCatsController {
  
  InitData initData = InitData(Get.find());
  CallServer callServer = CallServer(Get.find());
  MovieChannelsControllerImp movieChannelsControllerImp = MovieChannelsControllerImp();

  StatusRequest statusRequest = StatusRequest.none;

  List categories = [];
  List catsCount = [];
  var cats = [];

  var favCat = [{"category_id": "1000000", "category_name": "المفضلة", "parent_id": "0"}];
  int selectedCat = 1;
  
  @override
  updateMovieCatsList() async {
    try {
      final user = await LocaleApi.getUser();
      final loginData = await LocaleApi.getLoginInfo();
      if(user == null || loginData == null){
        Get.defaultDialog(title: "Error", middleText: "Server Error!!");
        return;
      }
      
      var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${loginData.password}&username=${loginData.username}&action=get_vod_categories";
      var oldMoviesCats = await initData.getLiveCats(url);
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
      await waitWhile(oldMoviesCats!.isNotEmpty).then((value) async => await LocaleApi.saveMoviesCats(oldMoviesCats));
      print("updated");
    } catch (e) {
      print(e);
    }
  }
  
  @override
  getCats() async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      final user = await LocaleApi.getUser();
      final loginData = await LocaleApi.getLoginInfo();
      var oldMoviesCats = await LocaleApi.getMoviesCats();
      
      if(user == null || loginData == null){
        Get.defaultDialog(title: "Error", middleText: "Server Error!!");
        return;
      }

      if(oldMoviesCats == null){
        print(oldMoviesCats);
        var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${loginData.password}&username=${loginData.username}&action=get_vod_categories";
        oldMoviesCats = await initData.getLiveCats(url);
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
        await waitWhile(oldMoviesCats!.isNotEmpty).then((value) async => await LocaleApi.saveMoviesCats(oldMoviesCats));
        update();
      }

      // catsCount = [];
      // for(var i=0; i<oldMoviesCats.length; i++) {
      //   catsCount.add(i);
      // }
      
      categories = [];
      cats = [];

      cats.addAll(favCat);
      cats.addAll(oldMoviesCats);

      final list = cats.map((e) => CategoryModel.fromJson(e)).toList();
      categories.addAll(list);
      
      // for (var i=0; i<liveCats.length; i++){
      //   var catId = list[i].categoryId;
      //   print(catId);
      //   if(catId != null) {
      //     var catCount = await movieChannelsControllerImp.getMoviesCount(catId);
      //     print(catCount);
      //     print("catCount");
      //   }
      // }
      
      // Future.delayed(const Duration(seconds: 1)).then((value) async {
      //   catsCount = [];
      //   for (var i = 0; i < liveCats.length; i++) {
      //     var catCountId = liveCats[i]['category_id'];
      //     var catCount = await movieChannelsControllerImp.getMoviesCount(catCountId);
      //     catsCount.add(catCount);
      //     print(catCount);
      //   }
      //   update();
      // });

      statusRequest = StatusRequest.success;
      update();
      
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    getCats();
    updateMovieCatsList();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
}