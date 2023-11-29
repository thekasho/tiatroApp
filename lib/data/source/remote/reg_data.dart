import 'package:tiatrotv/core/class/crud.dart';

import '../../../app_link.dart';

class RegData {
  Crud crud;
  RegData(this.crud);

  postData(String mac) async {
    // var response = await crud.postData(ApiLinks.check_mac_address, {
    //   "mac_address" : mac
    // });
    // return response.fold((l) => l, (r) => r);
  }
}