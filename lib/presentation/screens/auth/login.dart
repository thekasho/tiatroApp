part of '../screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'الخروج',
              style: TextStyle(fontFamily: 'Cairo'),
              textDirection: TextDirection.rtl,
            ),
            content: Text(
              'هل تريد اغلاق التطبيق؟',
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
            backgroundColor: white10,
            actions: [
              Shortcuts(
                  shortcuts: <LogicalKeySet, Intent>{
                    LogicalKeySet(LogicalKeyboardKey.select):
                        const ActivateIntent(),
                  },
                  child: MaterialButton(
                    focusElevation: 10,
                    color: white10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: const Text('لا',
                        style: TextStyle(
                            fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.of(context).pop(false),
                  )),
              Shortcuts(
                shortcuts: <LogicalKeySet, Intent>{
                  LogicalKeySet(LogicalKeyboardKey.select):
                      const ActivateIntent(),
                },
                child: MaterialButton(
                  focusElevation: 10,
                  color: appTextColorPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: const Text('نعم',
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          color: black)),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  void dispose() async {
    f1.dispose();
    f2.dispose();
    f3.dispose();
    f4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return WillPopScope(
      onWillPop: () async {
        return showExitPopup();
      },
      child: Scaffold(
        body: Container(
          color: blackSendStar,
          height: double.infinity,
          width: double.infinity,
          child: Row(children: [
            Container(
              padding: EdgeInsets.all(4.w),
              width: 50.w,
              height: 100.h,
              color: blackSendStar,
              child: Card(
                color: blackSendStar,
                elevation: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: const AssetImage(k3dLogo),
                          width: 20.w,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "IPTV مرحبا بك فى تيايترو",
                          style: TextStyle(
                              color: appTextColorPrimary,
                              fontFamily: 'Cairo',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "مكانك الاول لمشاهدة افلامك وقنواتك المفضلة",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Cairo',
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "اذا كان ليس لديك حساب .. قم بالتسجيل بالاسفل",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Cairo',
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "التسجيل",
                            style: TextStyle(
                              color: appTextColorPrimary,
                              fontFamily: 'Cairo',
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(4.w),
              width: 50.w,
              height: 90.h,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: darkGray,
                child: GetBuilder<LoginControllerImp>(builder: (controller) {
                  return HandleRequest(
                    statusRequest: controller.statusRequest,
                    widget: Form(
                      key: controller.formstate,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            children: [
                              LoginTextForm(
                                top: 7.h,
                                controller: controller.username,
                                hintText: "اسم المستخدم",
                                prefixIcon:
                                    Icon(FontAwesomeIcons.user, size: 4.h),
                                prefixIconColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        states.contains(MaterialState.focused)
                                            ? appTextColorPrimary
                                            : hintGray),
                                valid: (val) {
                                  if (val!.isEmpty) {
                                    return "اسم المستخدم مطلوب";
                                  }
                                },
                                isPassword: false,
                                focusNode: f1,
                                onFieldSubmitted: (val) {
                                  f1.unfocus();
                                  FocusScope.of(context).requestFocus(f2);
                                },
                              ),
                              LoginTextForm(
                                controller: controller.password,
                                hintText: "كلمة المرور",
                                prefixIcon:
                                    Icon(FontAwesomeIcons.lock, size: 4.h),
                                prefixIconColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        states.contains(MaterialState.focused)
                                            ? appTextColorPrimary
                                            : hintGray),
                                valid: (val) {
                                  if (val!.isEmpty) {
                                    return "كلمة المرور مطلوبة";
                                  }
                                },
                                isPassword: controller.isShowPassword,
                                top: 1.h,
                                focusNode: f2,
                                suffixIcon: Shortcuts(
                                    shortcuts: <LogicalKeySet, Intent>{
                                      LogicalKeySet(LogicalKeyboardKey.select):
                                          const ActivateIntent(),
                                    },
                                    child: IconButton(
                                        focusNode: f4,
                                        onPressed: () {
                                          controller.showPassword();
                                        },
                                        icon: Icon(
                                          controller.isShowPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: appTextColorPrimary,
                                        ))),
                                onFieldSubmitted: (val) {
                                  f2.unfocus();
                                  FocusScope.of(context).requestFocus(f3);
                                  // controller.loginUser();
                                },
                              ),
                              Shortcuts(
                                shortcuts: <LogicalKeySet, Intent>{
                                  LogicalKeySet(LogicalKeyboardKey.select):
                                      const ActivateIntent(),
                                },
                                child: LoginSubmitButton(
                                  title: "دخــــول",
                                  onPressed: () {
                                    controller.loginUser();
                                  },
                                  focusNode: f3,
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                hoverColor: appTextColorPrimary,
                                child: const Text(
                                  "Forget Password",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: hintGray,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
