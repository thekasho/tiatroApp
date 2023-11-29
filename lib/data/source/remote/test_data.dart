import 'package:tiatrotv/core/class/crud.dart';

import '../../../app_link.dart';

class TestData {
  Crud crud;
  TestData(this.crud);
  getData() async {
    // var response = await crud.postData(ApiLinks.check_mac_address, {});
    // return response.fold((l) => l, (r) => r);
  }
}