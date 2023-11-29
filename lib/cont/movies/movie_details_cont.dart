import 'package:get/get.dart';
import 'package:tiatrotv/repository/models/channel_movie.dart';

import '../../core/class/statusrequest.dart';
import '../../data/source/remote/call_server.dart';
import '../../data/source/remote/init_data.dart';
import '../../repository/api/api.dart';
import '../../repository/models/movie_detail.dart';

abstract class MoviesDetailsController extends GetxController {
  getMovieDetails(dynamic movieId);
  getAuthLink();
  addFav(int movieId);
}

class MoviesDetailsControllerImp extends MoviesDetailsController {

  InitData initData = InitData(Get.find());
  CallServer callServer = CallServer(Get.find());
  
  StatusRequest statusRequest = StatusRequest.none;

  late MovieDetail movieDetail;
  late int movieId;
  bool favOn = false;
  List movies = [];

  @override
  addFav(movieId) async {
    try {
      final user = await LocaleApi.getUser();
      final loginData = await LocaleApi.getLoginInfo();
      if(user == null || loginData == null){
        Get.defaultDialog(title: "Error", middleText: "Server Error!!");
        return;
      }

      var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${loginData.password}&username=${loginData.username}&action=get_vod_info&vod_id=$movieId";
      var getMovies = await initData.getMovieDetails(url);
      final movie = MovieDetail.fromJson(getMovies);
      final catId = movie.movieData!.categoryId;

      var caturl = "${user.serverInfo!.serverUrl}/player_api.php?password=${loginData.password}&username=${loginData.username}&action=get_vod_streams&category_id=$catId";
      var getMovToFav = await initData.getMovies(caturl);
      movies = [];
      final moviesList = getMovToFav.map( (e) => ChannelMovie.fromJson(e) ).toList();
      movies.addAll(moviesList);

      Map? newFav = {};

      moviesList.forEach((element) {
        if(element.streamId == movieId){
          newFav = element.toJson();
        }
      });

      Map<String, Map<dynamic, dynamic>> new_favData = {
        movieId.toString() : {
          'content': "$newFav",
        }
      };

      Map? oldFav = await LocaleApi.getFavouriteMovies();
      
      var favIds = oldFav?[movieId.toString()];
      
      if(favIds == null){
        if(oldFav != null){
          oldFav.addAll(new_favData);
          var saveFav = await LocaleApi.saveFavouriteMovies(oldFav);
          print("Update: $saveFav");
        }
        else {
          var saveFav = await LocaleApi.saveFavouriteMovies(new_favData);
          print("Save: $saveFav");
        }
      } else {
        oldFav!.removeWhere((key, value) => key == "$movieId");
        var saveFav = await LocaleApi.saveFavouriteMovies(oldFav);
        print(saveFav);
      }

      update();
      
    } catch(e){
      print(e);
    }
  }
  
  @override
  getAuthLink() async {
    final user = await LocaleApi.getUser();
    final loginData = await LocaleApi.getLoginInfo();
    
    final link =
        "${user?.serverInfo!.serverUrl}/movie/${loginData!.username}/${loginData.password}/";
    return link;
  }
  
  @override
  getMovieDetails(movieId) async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      final user = await LocaleApi.getUser();
      Map? favs = await LocaleApi.getFavouriteMovies();
      final loginData = await LocaleApi.getLoginInfo();
      if(user == null || loginData == null){
        Get.defaultDialog(title: "Error", middleText: "Server Error!!");
        return;
      }
      
      var fav_ids = favs?["$movieId"];
      
      if(fav_ids != null){
        favOn = true;
        update();
      }
      else {
        favOn = false;
        update();
      }

      var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${loginData.password}&username=${loginData.username}&action=get_vod_info&vod_id=$movieId";

      var getMovies = await initData.getMovieDetails(url);

      final movie = MovieDetail.fromJson(getMovies);
      movieDetail = movie;
      movieId = movieId;
      
      statusRequest = StatusRequest.success;
      update();
      
    } catch(e){
      print("error;");
      print(e);
      statusRequest = StatusRequest.loading;
      update();
    }
  }
}