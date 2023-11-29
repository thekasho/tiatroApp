import '../../../core/class/crud.dart';

class CallServer {
  Crud crud;
  CallServer(this.crud);

  fetchServer(String serverLink, String serverPort, String server_username, String server_password) async {
    var link = "$serverLink:$serverPort/player_api.php?username=$server_username&password=$server_password";
    var response = await crud.getData(link);
    return response.fold((l) => l, (r) => r);
  }
}