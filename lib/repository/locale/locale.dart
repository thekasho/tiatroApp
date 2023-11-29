part of '../api/api.dart';

class LocaleApi {

  static Future<bool> saveUser(UserModel user) async {

    try {
      await locale.write("user", user.toJson());
      return true;
    } catch (e) {
      debugPrint("Error save User: $e");
      return false;
    }
  }

  static Future<UserModel?> getUser() async {
    try {
      final user = await locale.read("user");
      
      if (user != null) {
        return UserModel.fromJson(user);
      }
      debugPrint('local user data null');
      return null;
    } catch (e) {
      debugPrint("Error save User: $e");
      return null;
    }
  }
  //---------------------------------------------

  static Future<bool> logOut() async {
    try {
      await locale.remove("loginData");
      await locale.remove("user");

      return true;
    } catch (e) {
      debugPrint("Error LogOut User: $e");
      return false;
    }
  }
  
  static Future<bool> saveLoginData(Map loginData) async {
    try {
      await locale.write("loginData", loginData);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  
  static Future<LoginModel?> getLoginInfo() async {
    try {
      final user = await locale.read("loginData");

      if (user != null) {
        return LoginModel.fromJson(user);
      }
      debugPrint('local user data null');
      return null;
    } catch (e) {
      debugPrint("Error save User: $e");
      return null;
    }
  }

  //---------------------------------------------

  static Future<bool> saveAccount(Map? account) async {
    try {
      // await locale.remove("user_accounts");
      await locale.write("user_accounts", account);
      return true;
    } catch (e) {
      debugPrint("Error save Fav: $e");
      return false;
    }
  }

  static Future<Map?> getAccounts() async {
    try {
      final users = await locale.read("user_accounts");

      if (users != null) {
        return users;
      }
      debugPrint('local user data null');
      return null;
    } catch (e) {
      debugPrint("Error save User: $e");
      return null;
    }
  }

  //---------------------------------------------
  
  static Future<bool> saveMoviesList(List? movies) async {
    try {
      await locale.write("movies_list", movies);
      return true;
    } catch (e) {
      debugPrint("Error save Fav: $e");
      return false;
    }
  }

  static Future<List?> getMoviesList() async {
    try {
      final movies = await locale.read("movies_list");
      
      if(movies != null){
        debugPrint("Success Get Movies List");
        return movies;
      } else {
        debugPrint("Error Get Movies List");
      }
      return null;
    } catch (e) {
      debugPrint("Error Get Movies List: $e");
      return null;
    }
  }

  //---------------------------------------------

  static Future<bool> saveMoviesCats(List? movies) async {
    try {
      await locale.write("movies_cats", movies);
      return true;
    } catch (e) {
      debugPrint("Error Save Movies Cats: $e");
      return false;
    }
  }

  static Future<List?> getMoviesCats() async {
    try {
      final movies = await locale.read("movies_cats");
      
      if(movies != null){
        debugPrint("Success Get Movies Cats");
        return movies;
      } else {
        debugPrint("Error Get Movies Cats");
      }
      return null;
    } catch (e) {
      debugPrint("Error Get Movies Cats: $e");
      return null;
    }
  }

  //---------------------------------------------

  static Future<List?> getLiveCats() async {
    try {
      final movies = await locale.read("live_cats");

      // await locale.remove("live_cats");

      if(movies != null){
        debugPrint("Success Get Live Cats");
        return movies;
      } else {
        debugPrint("Error Get Live Cats");
      }
      return null;
    } catch (e) {
      debugPrint("Error Get Live Cats: $e");
      return null;
    }
  }
  
  static Future<bool> saveLiveCats(List? liveCats) async {
    try {
      await locale.write("live_cats", liveCats);
      debugPrint("Success Save Live Cats");
      return true;
    } catch (e) {
      debugPrint("Error Save Live Cats: $e");
      return false;
    }
  }
  //---------------------------------------------
  
  static Future<Map?> getFavourite() async {
    try {
      final favourites = await locale.read("fav_channels");

      if(favourites != null){
        debugPrint("Success Get Live Fav");
        return favourites;
      }
      return null;
    } catch (e) {
      debugPrint("Error Get Live Fav: $e");
      return null;
    }
  }

  static Future<bool> saveFavourite(Map? fav) async {
    try {
      await locale.write("fav_channels", fav);
      return true;
    } catch (e) {
      debugPrint("Error save Fav: $e");
      return false;
    }
  }
  
  //---------------------------------------------

  static Future<Map?> getFavouriteMovies() async {
    try {
      // await locale.remove("fav_movies");

      final favourites = await locale.read("fav_movies");

      if(favourites != null){
        debugPrint("Success Get Fav Movies");
        return favourites;
      }
      return null;
    } catch (e) {
      debugPrint("Error save Fav: $e");
      return null;
    }
  }

  static Future<bool> saveFavouriteMovies(Map? fav) async {
    try {
      await locale.write("fav_movies", fav);
      return true;
    } catch (e) {
      debugPrint("Error save Fav: $e");
      return false;
    }
  }

  //---------------------------------------------

  static Future<Map?> getFavouriteSeries() async {
    try {
      // await locale.remove("fav_series");

      final favourites = await locale.read("fav_series");

      if(favourites != null){
        debugPrint("Success Get Fav Series");
        return favourites;
      }
      return null;
    } catch (e) {
      debugPrint("Error save Fav: $e");
      return null;
    }
  }

  static Future<bool> saveFavouriteSeries(Map? fav) async {
    try {
      await locale.write("fav_series", fav);
      return true;
    } catch (e) {
      debugPrint("Error save Fav: $e");
      return false;
    }
  }

  //---------------------------------------------
  
  static Future<bool> saveServer(Map server) async {
    try {
      await locale.write("servers_data", server);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<Map?> getServers() async {
    try {
      final servers = await locale.read("servers_data");

      if (servers != null) {
        return servers;
      }
      else {
        print('no data');
      }
      return null;
    } catch (e) {
      debugPrint("Error save User: $e");
      return null;
    }
  }

  static Future<bool?> removeAllServers() async {
    try {
      await locale.remove("servers_data");
      return true;
    } catch (e) {
      debugPrint("Error LogOut User: $e");
      return false;
    }
  }
}
