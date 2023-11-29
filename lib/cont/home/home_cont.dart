import 'dart:async';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../data/source/remote/call_server.dart';
import '../../data/source/remote/init_data.dart';
import '../../helpers/helpers.dart';
import '../../repository/api/api.dart';
import '../../repository/models/channel_movie.dart';
import '../../repository/models/channel_serie.dart';

abstract class HomeController extends GetxController {
  getServerAuth();
  getMoviesCats();
  LogOut();
  updateMovieList();
}
class HomeControllerImp extends HomeController {
  InitData initData = InitData(Get.find());
  CallServer callServer = CallServer(Get.find());

  StatusRequest statusRequest = StatusRequest.none;
  
  String username = "";
  List movies = [];
  int moviesCount = 5;
  
  List series = [];
  int seriesCount = 5;
  bool isConnected = false;
  
  @override
  LogOut() async {    
    var loginInfo = await LocaleApi.logOut();
    if(loginInfo){
      Future.delayed(const Duration(seconds: 1)).then((value) {
        Get.offAndToNamed(screenLogin);
      });
    }
    update();
  }
  
  @override
  updateMovieList() async {
    try {
      final user = await LocaleApi.getUser();
      final loginData = await LocaleApi.getLoginInfo();
      if(user == null || loginData == null){
        Get.defaultDialog(title: "Error", middleText: "Server Error!!");
        return;
      }
      
      var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${loginData!.password}&username=${loginData.username}&action=get_vod_streams";
      var oldMovies = await initData.getMovies(url);
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
      await waitWhile(oldMovies!.isNotEmpty).then((value) async => await LocaleApi.saveMoviesList(oldMovies));
    } catch (e) {
      print(e);
    }
  }
  
  @override
  getMoviesCats() async {
    try {
      final user = await LocaleApi.getUser();
      final loginData = await LocaleApi.getLoginInfo();
      var oldMovies = await LocaleApi.getMoviesList();
      if(user == null || loginData == null){
        Get.defaultDialog(title: "Error", middleText: "Server Error!!");
        return;
      }
      
      if(oldMovies == null){
        var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${loginData.password}&username=${loginData.username}&action=get_vod_streams";
        oldMovies = await initData.getMovies(url);
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
        await waitWhile(oldMovies!.isNotEmpty).then((value) async => await LocaleApi.saveMoviesList(oldMovies));
        update();
      }
      
      movies = [];
      final moviesList = oldMovies!.map( (e) => ChannelMovie.fromJson(e) ).toList();
      moviesCount = moviesList.length;
      for(var i=1; i<6; i++){
        movies.add(moviesList[moviesCount -i]);
      }

      var seriesUrl = "${user.serverInfo!.serverUrl}/player_api.php?password=${loginData.password}&username=${loginData.username}&action=get_series";
      var getSeries = await initData.getSeries(seriesUrl);
      series = [];
      final seriesList = getSeries.map( (e) => ChannelSerie.fromJson(e) ).toList();
      seriesCount = seriesList.length;
      for(var iv=1; iv<6; iv++){
        series.add(seriesList[seriesCount -iv]);
      }

      statusRequest = StatusRequest.success;
      update();
    } catch (e) {
      print(e);
    }
  }

  @override
  getServerAuth() async {
    statusRequest = StatusRequest.loading;
    update();
    
    final loginData = await LocaleApi.getLoginInfo();
    username = loginData!.username!;
    update();
    getMoviesCats();
  }

  @override
  void onInit() async {
    getServerAuth();
    updateMovieList();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
}