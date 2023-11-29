import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import '../../repository/api/api.dart';

abstract class LandnigController extends GetxController {
  checkLoginUser();
}

class LandingControllerImp extends LandnigController {
  @override
  checkLoginUser() async {
    var loginInfo = await LocaleApi.getLoginInfo();
    if(loginInfo != null) {
      FlutterNativeSplash.remove();
      Future.delayed(const Duration(seconds: 1)).then((value) {
        Get.offAndToNamed(screenHome);
      });
    }
    else {
      FlutterNativeSplash.remove();
      Future.delayed(const Duration(seconds: 1)).then((value) {
        Get.offAndToNamed(screenLogin);
      });
    }
  }


  @override
  void onInit() {
    checkLoginUser();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

}