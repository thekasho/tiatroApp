import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tiatrotv/repository/models/login.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data.dart';
import '../../data/source/remote/call_server.dart';
import '../../data/source/remote/init_data.dart';
import '../../helpers/helpers.dart';
import '../../repository/api/api.dart';
import '../../repository/models/user.dart';

abstract class AccountController extends GetxController {
  getServerAuth();
  getAccounts();
  checkNetwork();
  addAccount();
  delAccount(String accName);
  applyAccount(String accName);
}

class AccountControllerImp extends AccountController {
  InitData initData = InitData(Get.find());
  CallServer callServer = CallServer(Get.find());

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  late TextEditingController inUsername;
  late TextEditingController inPassword;

  StatusRequest statusRequest = StatusRequest.none;

  String username = "";
  String password = "";
  String createDate = "";
  String expDate = "";
  String accState = "";
  bool isConnected = false;
  List oldAcc = [];

  @override
  checkNetwork() async {
    isConnected = await InternetConnectionChecker().hasConnection;
  }

  @override
  getAccounts() async {
    final accounts = await LocaleApi.getAccounts();
    if (accounts != null) {
      oldAcc = [];
      oldAcc.addAll(accounts.values);
      oldAcc.map((e) => LoginModel.fromJson(e)).toList();
    }
  }

  @override
  getServerAuth() async {
    statusRequest = StatusRequest.loading;
    update();

    final loginData = await LocaleApi.getLoginInfo();
    final userInfo = await LocaleApi.getUser();
    username = loginData!.username!;
    password = userInfo!.userInfo!.password!;
    createDate = expirationDate(userInfo.userInfo!.createdAt!).toString();
    expDate = expirationDate(userInfo.userInfo!.expDate!).toString();
    accState = userInfo.userInfo!.status!;

    statusRequest = StatusRequest.success;
    update();
  }

  @override
  addAccount() async {
    var formdata = formState.currentState;
    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var serverAuth = await initData.getServerAuth();
      statusRequest = handlingData(serverAuth);
      if (StatusRequest.success == statusRequest) {
        final server_domain = serverAuth['result']['domain'];
        final server_port = serverAuth['result']['port'];

        var fetchServer = await callServer.fetchServer(
            server_domain, server_port, inUsername.text, inPassword.text);
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
            final accounts = await LocaleApi.getAccounts();
            Map<String, dynamic> account = {
              inUsername.text: {
                'username': inUsername.text,
                'password': inPassword.text
              }
            };
            if (accounts != null) {
              accounts.addAll(account);
              var saver = await LocaleApi.saveAccount(accounts);
              if (saver) {
                Get.defaultDialog(
                  backgroundColor: white10,
                  title: "نجح",
                  titlePadding: EdgeInsets.only(bottom: 2.h),
                  titleStyle: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "Cairo",
                    color: white,
                  ),
                  content: Text(
                    "تم اضافة الحساب",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "Cairo",
                    ),
                  ),
                );
                inUsername.clear();
                inPassword.clear();
                await getAccounts();
                update();
              }
            } else {
              var saver = await LocaleApi.saveAccount(account);
              if (saver) {
                Get.defaultDialog(
                  backgroundColor: white10,
                  title: "نجح",
                  titlePadding: EdgeInsets.only(bottom: 2.h),
                  titleStyle: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "Cairo",
                    color: white,
                  ),
                  content: Text(
                    "تم اضافة الحساب",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "Cairo",
                    ),
                  ),
                );
                inUsername.clear();
                inPassword.clear();
                await getAccounts();
                update();
              }
            }
          }
        }
        statusRequest = StatusRequest.success;
        update();
      }
    }
  }

  @override
  delAccount(accName) async {
    statusRequest = StatusRequest.loading;
    update();

    final accounts = await LocaleApi.getAccounts();
    accounts?.remove(accName);
    var saver = await LocaleApi.saveAccount(accounts);
    if (saver) {
      Get.defaultDialog(
        backgroundColor: white10,
        title: "نجح",
        titlePadding: EdgeInsets.only(bottom: 2.h),
        titleStyle: TextStyle(
          fontSize: 18.sp,
          fontFamily: "Cairo",
          color: white,
        ),
        content: Text(
          "تم حذف الحساب",
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: "Cairo",
          ),
        ),
      );
      await getAccounts();
      statusRequest = StatusRequest.success;
      update();
    }
  }

  @override
  applyAccount(accName) async {
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

    final accounts = await LocaleApi.getAccounts();
    if (accounts != null) {
      final accUsername = accounts[accName]['username'];
      final password = accounts[accName]['password'];

      var serverAuth = await initData.getServerAuth();
      statusRequest = handlingData(serverAuth);

      if (StatusRequest.success == statusRequest) {
        final server_domain = serverAuth['result']['domain'];
        final server_port = serverAuth['result']['port'];

        var fetchServer = await callServer.fetchServer(
            server_domain, server_port, username, password);
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
          statusRequest = StatusRequest.success;
          update();
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
          statusRequest = StatusRequest.success;
          update();
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
            statusRequest = StatusRequest.success;
            update();
          } else {
            statusRequest = StatusRequest.success;
            Map<String, dynamic>? userData = {
              "username": username,
              "password": password,
              "domain": server_domain,
              "port": server_port
            };
            final user = LoginModel.fromJson(userData);
            var finalSave = await LocaleApi.saveLoginData(user.toJson());

            await LocaleApi.saveUser(UserModel.fromJson(fetchServer));

            if (finalSave) {
              Get.defaultDialog(
                backgroundColor: white10,
                title: "نجح",
                titlePadding: EdgeInsets.only(bottom: 2.h),
                titleStyle: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: "Cairo",
                  color: white,
                ),
                content: Text(
                  "تم تفعيل الحساب",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "Cairo",
                  ),
                ),
              );
              await getAccounts();
              statusRequest = StatusRequest.success;
              update();
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
              statusRequest = StatusRequest.success;
              update();
            }
          }
        }
      }
    }
  }

  @override
  void onInit() {
    getServerAuth();
    getAccounts();
    checkNetwork();
    inUsername = TextEditingController();
    inPassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    inUsername.dispose();
    inPassword.dispose();
    super.dispose();
  }
}
