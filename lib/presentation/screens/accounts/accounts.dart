part of '../screens.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  AccountControllerImp accountControllerImp = Get.put(AccountControllerImp());

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();

  Future<void> getUserDetails() async {
    accountControllerImp.getServerAuth();
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        body: GetBuilder<AccountControllerImp>(builder: (accountController) {
          if (accountController.statusRequest == StatusRequest.success) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: blackSendStar,
              child: Column(
                children: [
                  AccountAppBar(
                    username: accountController.username,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 50.w,
                          height: 90.h,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                  width: 0.04.w,
                                  color: yellowStar
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "الحسابات المسجلة",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Ink(
                                width: 45.w,
                                height: 81.h,
                                padding: EdgeInsets.all(0.4.w),
                                child: NestedScrollView(
                                  headerSliverBuilder: (_, ch) {
                                    return [];
                                  },
                                  body: GetBuilder<AccountControllerImp>(
                                  builder: (accController) {
                                    return HandleRequest(
                                      statusRequest: accountController.statusRequest,
                                      widget: GridView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.only(
                                          bottom: 10.h,
                                        ),
                                        itemCount: accountController.oldAcc.length,
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          mainAxisSpacing: 2.h,
                                          mainAxisExtent: 12.h,
                                        ),
                                        itemBuilder: (_, i) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                border: Border.all(
                                                  width: 0.04.w,
                                                  color: yellowLight
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            SizedBox(
                                                              width: 4.w,
                                                              child: Shortcuts(
                                                                shortcuts: <LogicalKeySet, Intent>{
                                                                  LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                                                                },
                                                                child: ElevatedButton(
                                                                  onPressed: () {
                                                                    accController.applyAccount(accController.oldAcc[i]['username']);
                                                                  },
                                                                  style: ButtonStyle(
                                                                    backgroundColor: MaterialStateProperty.all<Color>(bg2),
                                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                      RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(20)
                                                                      )
                                                                    ),
                                                                    elevation: MaterialStateProperty.all(0),
                                                                    overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                                                      states.contains(white38);
                                                                      return null;
                                                                    }),
                                                                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
                                                                  ),
                                                                  child: Icon(
                                                                    Icons.task_alt,
                                                                    color: yellowStar,
                                                                    size: 2.w
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(width: .5.w),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            SizedBox(
                                                              width: 4.w,
                                                              child: Shortcuts(
                                                                shortcuts: <LogicalKeySet, Intent>{
                                                                  LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                                                                },
                                                                child: ElevatedButton(
                                                                  onPressed: () {
                                                                    accController.delAccount(accController.oldAcc[i]['username']);
                                                                  },
                                                                  style: ButtonStyle(
                                                                    backgroundColor: MaterialStateProperty.all<Color>(bg2),
                                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                                                                    ),
                                                                    elevation: MaterialStateProperty.all(0),
                                                                    overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                                                      states.contains(white38);
                                                                    }),
                                                                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
                                                                  ),
                                                                  child: Icon(
                                                                    Icons.delete_rounded,
                                                                    color: red,
                                                                    size: 2.w
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 3,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          left: BorderSide(
                                                            width: 0.04.w,
                                                            color: yellowLight
                                                          ),
                                                        ),
                                                      ),
                                                      padding: EdgeInsets.only(
                                                        right: 1.w,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Flexible(
                                                            flex: 9,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: [
                                                                    Text(
                                                                      "${accController.oldAcc[i]['username']}",
                                                                      style: TextStyle(
                                                                        color: googleColor,
                                                                        fontSize: 13
                                                                            .sp,
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontFamily: 'Cairo',
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      " : اسم المستخدم",
                                                                      style: TextStyle(
                                                                        color: white,
                                                                        fontSize: 13
                                                                            .sp,
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontFamily: 'Cairo',
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: [
                                                                    Text(
                                                                      "${accController.oldAcc[i]['password']}",
                                                                      style: TextStyle(
                                                                        color: googleColor,
                                                                        fontSize: 13
                                                                            .sp,
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontFamily: 'Cairo',
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      " : كلمة المرور",
                                                                      style: TextStyle(
                                                                        color: white,
                                                                        fontSize: 13
                                                                            .sp,
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontFamily: 'Cairo',
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(width: .8.w),
                                                          Flexible(
                                                            flex: 1,
                                                            child: Container(
                                                              height: 7.h,
                                                              alignment: Alignment.center,
                                                              decoration: const BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                color: bg2
                                                              ),
                                                              margin: EdgeInsets.only(
                                                                left: 0.5.w
                                                              ),
                                                              child: Text(
                                                                "${i + 1}",
                                                                style: TextStyle(
                                                                  color: yellowStar,
                                                                  fontSize: 15.sp,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontFamily: 'Cairo',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              width: 50.w,
                              margin: EdgeInsets.only(bottom: 2.h),
                              alignment: Alignment.center,
                              child: Text(
                                "الحساب المستخدم",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 47.w,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 15.h,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            width: 0.04.w,
                                            color: yellowLight
                                        ),
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 1.w,
                                        left: 1.w,
                                      ),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  right: 1.w
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .end,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .end,
                                                        children: [
                                                          Text(
                                                            "${accountController.password}",
                                                            style: TextStyle(
                                                              color: googleColor,
                                                              fontSize: 13.sp,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                          Text(
                                                            " : كلمة المرور",
                                                            style: TextStyle(
                                                              color: white,
                                                              fontSize: 13.sp,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${accountController.accState}",
                                                            style: TextStyle(
                                                              color: googleColor,
                                                              fontSize: 13.sp,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                          Text(
                                                            " : حالة الحساب",
                                                            style: TextStyle(
                                                              color: white,
                                                              fontSize: 13.sp,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .end,
                                                        children: [
                                                          Text(
                                                            "",
                                                            style: TextStyle(
                                                              color: googleColor,
                                                              fontSize: 13.sp,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                          Text(
                                                            "",
                                                            style: TextStyle(
                                                              color: white,
                                                              fontSize: 13.sp,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                      width: 0.04.w,
                                                      color: yellowLight
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .end,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .end,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .end,
                                                        children: [
                                                          Text(
                                                            "${accountController.username}",
                                                            style: TextStyle(
                                                              color: googleColor,
                                                              fontSize: 13.sp,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                          Text(
                                                            " : اسم المستخدم",
                                                            style: TextStyle(
                                                              color: white,
                                                              fontSize: 13.sp,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${accountController.createDate}",
                                                            style: TextStyle(
                                                              color: googleColor,
                                                              fontSize: 12.sp,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                          Text(
                                                            " : تاريخ الانشاء",
                                                            style: TextStyle(
                                                              color: white,
                                                              fontSize: 13.sp,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .end,
                                                        children: [
                                                          Text(
                                                            "${accountController.expDate}",
                                                            style: TextStyle(
                                                              color: googleColor,
                                                              fontSize: 12.sp,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                          Text(
                                                            " : تاريخ الانتهاء",
                                                            style: TextStyle(
                                                              color: white,
                                                              fontSize: 13.sp,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 50.w,
                              margin: EdgeInsets.only(top: 2.h, bottom: 2.h),
                              alignment: Alignment.center,
                              child: Text(
                                "اضافة حساب جديد",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 47.w,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)
                                        ),
                                        border: Border.all(
                                            width: 0.04.w,
                                            color: yellowLight
                                        ),
                                      ),
                                      padding: EdgeInsets.only(
                                          right: 1.w,
                                          left: 1.w,
                                          top: 5.h,
                                          bottom: 5.h
                                      ),
                                      child: GetBuilder<AccountControllerImp>(
                                        builder: (accountController) {
                                          return HandleRequest(
                                            statusRequest: accountControllerImp.statusRequest,
                                            widget: Form(
                                              key: accountControllerImp.formState,
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                  child: Column(
                                                    children: [
                                                      AccountTextForm(
                                                        controller: accountController.inUsername,
                                                        hintText: "اسم المستخدم",
                                                        valid: (val) {
                                                          if (val!.isEmpty) {
                                                            return "اسم المستخدم مطلوب";
                                                          }
                                                        },
                                                        prefixIcon: Icon(
                                                          FontAwesomeIcons.user,
                                                          size: 15.sp
                                                        ),
                                                        prefixIconColor: MaterialStateColor.resolveWith((states) =>
                                                        states.contains(MaterialState.focused)
                                                            ? appTextColorPrimary
                                                            : hintGray
                                                        ),
                                                        focusNode: f1,
                                                        onFieldSubmitted: (val) {
                                                          f1.unfocus();
                                                          FocusScope.of(context).requestFocus(f2);
                                                        },
                                                      ),
                                                      SizedBox(height: 4.h),
                                                      AccountTextForm(
                                                        controller: accountController
                                                            .inPassword,
                                                        hintText: "كلمة المرور",
                                                        valid: (val) {
                                                          if (val!.isEmpty) {
                                                            return "كلمة المرور مطلوبة";
                                                          }
                                                        },
                                                        prefixIcon: Icon(
                                                            FontAwesomeIcons.lock,
                                                            size: 15.sp),
                                                        prefixIconColor: MaterialStateColor
                                                            .resolveWith((
                                                            states) =>
                                                        states.contains(
                                                            MaterialState.focused)
                                                            ? appTextColorPrimary
                                                            : hintGray
                                                        ),
                                                        focusNode: f2,
                                                        onFieldSubmitted: (val) {
                                                          f2.unfocus();
                                                          FocusScope.of(context).requestFocus(f3);
                                                          // controller.loginUser();
                                                        },
                                                      ),
                                                      SizedBox(height: 4.h),
                                                      AccountSubmitButton(
                                                        title: "حفظ الحساب",
                                                        onPressed: () {
                                                          accountController.addAccount();
                                                          accountControllerImp.update();
                                                        },
                                                        focusNode: f3,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              body: Container(
                color: blackSendStar,
                height: double.infinity,
                width: double.infinity,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    CircularProgressIndicator(
                      color: appTextColorPrimary,
                    ),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
