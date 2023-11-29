import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tiatrotv/core/functions/handling_data.dart';
import 'package:tiatrotv/data/source/remote/login.dart';

import '../../core/class/statusrequest.dart';
import '../../data/source/remote/call_server.dart';
import '../../data/source/remote/init_data.dart';
import '../../helpers/helpers.dart';
import '../../repository/api/api.dart';
import '../../repository/models/login.dart';
import '../../repository/models/user.dart';

abstract class LoginController extends GetxController {
  loginUser();
  checkNetwork();
}

class LoginControllerImp extends LoginController {
  InitData initData = InitData(Get.find());
  CallServer callServer = CallServer(Get.find());

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController username;
  late TextEditingController password;

  StatusRequest statusRequest = StatusRequest.none;

  bool isShowPassword = true;
  bool isConnected = false;

  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  @override
  checkNetwork() async {
    isConnected = await InternetConnectionChecker().hasConnection;
  }

  @override
  loginUser() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      if (!isConnected) {
        Get.defaultDialog(
          backgroundColor: blackSoundList,
          title: "خطأ",
          contentPadding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 2.w),
          titleStyle: TextStyle(
            fontSize: 18.sp,
            fontFamily: "Cairo",
            color: red,
          ),
          content: Text(
            "لا يوجد اتصال بالشبكة",
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: "Cairo",
            ),
          ),
        );
        statusRequest = StatusRequest.failure;
        update();
        return;
      }

      var serverAuth = await initData.getServerAuth();
      statusRequest = handlingData(serverAuth);

      if (StatusRequest.success == statusRequest) {
        final server_domain = serverAuth['result']['domain'];
        final server_port = serverAuth['result']['port'];

        var fetchServer = await callServer.fetchServer(
            server_domain, server_port, username.text, password.text);
        var accountStat = fetchServer['user_info']['auth'].toString();

        if (StatusRequest.serverFailure == fetchServer) {
          Get.defaultDialog(
            backgroundColor: white10,
            title: "خطأ",
            titlePadding: EdgeInsets.only(bottom: 2.h),
            titleStyle: TextStyle(
              fontSize: 18.sp,
              fontFamily: "Cairo",
              color: white,
            ),
            content: Text(
              "البيانات غير صحيحة",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
        } else if (accountStat == "0") {
          Get.defaultDialog(
            backgroundColor: white10,
            title: "خطأ",
            titlePadding: EdgeInsets.only(bottom: 2.h),
            titleStyle: TextStyle(
              fontSize: 18.sp,
              fontFamily: "Cairo",
              color: white,
            ),
            content: Text(
              "الحساب غير مفعل",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
        } else {
          var accountValid = fetchServer['user_info']['status'].toString();
          if (accountValid != 'Active') {
            Get.defaultDialog(
              backgroundColor: white10,
              title: "خطأ",
              titlePadding: EdgeInsets.only(bottom: 2.h),
              titleStyle: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
                color: white,
              ),
              content: Text(
                "الحساب غير مفعل",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: "Cairo",
                ),
              ),
            );
          } else {
            statusRequest = StatusRequest.success;
            Map<String, dynamic>? userData = {
              "username": username.text,
              "password": password.text,
              "domain": server_domain,
              "port": server_port
            };
            final user = LoginModel.fromJson(userData);
            var finalSave = await LocaleApi.saveLoginData(user.toJson());

            await LocaleApi.saveUser(UserModel.fromJson(fetchServer));

            if (finalSave) {
              Get.offAndToNamed(screenCats);
            } else {
              Get.defaultDialog(
                backgroundColor: white10,
                title: "خطأ",
                titlePadding: EdgeInsets.only(bottom: 2.h),
                titleStyle: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: "Cairo",
                  color: white,
                ),
                content: Text(
                  "حدث خطأ",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "Cairo",
                  ),
                ),
              );
              statusRequest = StatusRequest.failure;
            }
          }
        }
      } else {
        Get.defaultDialog(
          backgroundColor: white10,
          title: "خطأ",
          titlePadding: EdgeInsets.only(bottom: 2.h),
          titleStyle: TextStyle(
            fontSize: 18.sp,
            fontFamily: "Cairo",
            color: white,
          ),
          content: Text(
            "حدث خطأ",
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: "Cairo",
            ),
          ),
        );
        statusRequest = StatusRequest.failure;
      }
      update();
    }
  }

  @override
  void onInit() {
    username = TextEditingController();
    password = TextEditingController();
    checkNetwork();
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }
}
