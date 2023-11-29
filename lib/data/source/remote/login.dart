import 'package:tiatrotv/core/class/crud.dart';

import '../../../app_link.dart';

class Login {
  Crud crud;
  Login(this.crud);

  loginUser(String username, String password) async{
    var response = await crud.postData(ApiLinks.login, {
      'username': username,
      'password': password
    });
    return response.fold((l) => l, (r) => r);
  }

}