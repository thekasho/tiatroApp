part of '../screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeControllerImp homeControllerImp = Get.put(HomeControllerImp());
  
  Future<void> getUserDetails() async {
    homeControllerImp.getServerAuth();
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('الخروج', style: TextStyle(fontFamily: 'Cairo'), textDirection: TextDirection.rtl,),
        content: Text(
          'هل تريد اغلاق التطبيق؟',
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: "Cairo",
          ),
        ),
        backgroundColor: black38,
        actions:[
          Shortcuts(
              shortcuts: <LogicalKeySet, Intent>{
                LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
              },
              child: MaterialButton(
                focusElevation: 10,
                color: white10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                ),
                child: const Text('لا', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.of(context).pop(false),
              )
          ),

          Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            },
            child: MaterialButton(
              focusElevation: 10,
              color: appTextColorPrimary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
              ),
              child: const Text('نعم', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: black)),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ),

        ],
      ),
    ) ?? false;
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
        return showExitPopup();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder<HomeControllerImp>(builder: (homeController) {
          if (homeController.statusRequest == StatusRequest.success) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: blackSendStar,
              child: Column(
                children: [
                  Container(
                    color: blackSendStar,
                    child: SafeArea(
                      child: Column(
                        children: [
                          HomeAppBar(
                            userName: homeController.username,
                          ),
                          SizedBox(
                            width: 100.w,
                            height: 87.h,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 5.h
                                      ),
                                      child: Column(
                                        children: [
                                        const HeadHome(title: "الافلام المميزة"),
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: 2.h,
                                            left: 1.w,
                                            right: 1.w,
                                          ),
                                          width: 100.w,
                                          height: 35.h,
                                          child: NestedScrollView(
                                            headerSliverBuilder: (_, ch) {
                                              return [];
                                            },
                                            body: GetBuilder<HomeControllerImp>(
                                              builder: (moviesController) {
                                                return HandleRequest(
                                                  statusRequest: moviesController.statusRequest,
                                                  widget: GridView.builder(
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    itemCount: moviesController.movies.length,
                                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 5,
                                                      crossAxisSpacing: 7,
                                                      mainAxisSpacing: 10,
                                                      childAspectRatio: .7,
                                                    ),
                                                    itemBuilder: (_, i) {
                                                      return SizedBox(
                                                        child: Shortcuts(
                                                          shortcuts: <LogicalKeySet, Intent>{
                                                            LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                                                          },
                                                          child: ElevatedButton(
                                                            onPressed: () => Get.to(
                                                              MovieDetails(videoId: moviesController.movies[i].streamId ?? ''),
                                                              transition: Transition.leftToRight,
                                                              duration: Duration(seconds: 1),
                                                            ) ,
                                                            style: ButtonStyle(
                                                              overlayColor: MaterialStateProperty.all<Color>(
                                                                  yellowStar
                                                              ),
                                                              elevation: MaterialStateProperty.all(0),
                                                              backgroundColor: MaterialStateProperty.all<Color>(
                                                                  Colors.transparent
                                                              ),
                                                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
                                                                horizontal: 0.3.w,
                                                                vertical: 0.3.w,
                                                              )),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Stack(
                                                                  alignment: Alignment.bottomCenter,
                                                                  children: [
                                                                    SizedBox(
                                                                      height: 31.8.h,
                                                                      child: ClipRRect(
                                                                        borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(1.w),
                                                                          bottomLeft: Radius.circular(1.w),
                                                                          bottomRight: Radius.circular(1.w),
                                                                          topRight: Radius.circular(1.w),
                                                                        ),
                                                                        child: CachedNetworkImage(
                                                                          imageUrl: moviesController.movies[i].streamIcon ?? "assets/images/bck.jpg",
                                                                          width: double.infinity,
                                                                          height: double.infinity,
                                                                          fit: BoxFit.fill,
                                                                          errorWidget: (_, i, e) {
                                                                            return Container(
                                                                                color: black12,
                                                                                height: 100.h,
                                                                                child: Image.asset(
                                                                                  "assets/images/blank.png",
                                                                                )
                                                                            );
                                                                          },
                                                                          placeholder: (_, i) {
                                                                            return const Center(
                                                                              child: CircularProgressIndicator(
                                                                                color: appTextColorPrimary,
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(1.w),
                                                                        color: offlineGray.withOpacity(0.6),
                                                                      ),
                                                                      alignment: Alignment.center,
                                                                      width: 100.w,
                                                                      child: Text(
                                                                        moviesController.movies[i].name ?? 'null',
                                                                        maxLines: 1,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 13.sp,
                                                                            fontFamily: "Cairo"
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        const HeadHome(title: "المسلسلات المميزة"),
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: 2.w,
                                            left: 1.w,
                                            right: 1.w,
                                          ),
                                          width: 100.w,
                                          height: 38.h,
                                          child: NestedScrollView(
                                            headerSliverBuilder: (_, ch) {
                                              return [];
                                            },
                                            body: GetBuilder<HomeControllerImp>(
                                              builder: (seriesController) {
                                                return HandleRequest(
                                                  statusRequest: seriesController.statusRequest,
                                                  widget: GridView.builder(
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    itemCount: seriesController.series.length,
                                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 5,
                                                      crossAxisSpacing: 7,
                                                      mainAxisSpacing: 10,
                                                      childAspectRatio: .7,
                                                    ),
                                                    itemBuilder: (_, i) {
                                                      return SizedBox(
                                                        child: Shortcuts(
                                                          shortcuts: <LogicalKeySet, Intent>{
                                                            LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                                                          },
                                                          child: ElevatedButton(
                                                            onPressed: () => Get.to(
                                                              SeriesDetails(videoId: seriesController.series[i].seriesId ?? ''),
                                                              transition: Transition.circularReveal,
                                                              duration: const Duration(seconds: 1),
                                                            ),
                                                            style: ButtonStyle(
                                                              overlayColor: MaterialStateProperty.all<Color>(
                                                                  yellowStar
                                                              ),
                                                              elevation: MaterialStateProperty.all(0),
                                                              backgroundColor: MaterialStateProperty.all<Color>(
                                                                  Colors.transparent
                                                              ),
                                                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
                                                                horizontal: 0.3.w,
                                                                vertical: 0.3.w,
                                                              )),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Stack(
                                                                  alignment: Alignment.bottomCenter,
                                                                  children: [
                                                                    SizedBox(
                                                                      height: 31.8.h,
                                                                      child: ClipRRect(
                                                                        borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(1.w),
                                                                          bottomLeft: Radius.circular(1.w),
                                                                          bottomRight: Radius.circular(1.w),
                                                                          topRight: Radius.circular(1.w),
                                                                        ),
                                                                        child: CachedNetworkImage(
                                                                          imageUrl: seriesController.series[i].cover ?? "assets/images/bck.jpg",
                                                                          width: double.infinity,
                                                                          height: double.infinity,
                                                                          fit: BoxFit.fill,
                                                                          errorWidget: (_, i, e) {
                                                                            return Container(
                                                                                color: black12,
                                                                                height: 100.h,
                                                                                child: Image.asset(
                                                                                  "assets/images/blank.png",
                                                                                )
                                                                            );
                                                                          },
                                                                          placeholder: (_, i) {
                                                                            return const Center(
                                                                              child: CircularProgressIndicator(
                                                                                color: appTextColorPrimary,
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(1.w),
                                                                        color: offlineGray.withOpacity(0.6),
                                                                      ),
                                                                      alignment: Alignment.center,
                                                                      width: 100.w,
                                                                      child: Text(
                                                                        seriesController.series[i].name ?? 'null',
                                                                        maxLines: 1,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 13.sp,
                                                                            fontFamily: "Cairo"
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        // HeadHome(title: "الافلام المفضلة"),
                                        // Container(
                                        //   padding: EdgeInsets.only(
                                        //     top: 2.w,
                                        //     left: 1.w,
                                        //     right: 1.w,
                                        //   ),
                                        //   width: 100.w,
                                        //   height: 38.h,
                                        //   child: NestedScrollView(
                                        //     headerSliverBuilder: (_, ch) {
                                        //       return [];
                                        //     },
                                        //     body: GridView.builder(
                                        //       itemCount: 5,
                                        //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        //         crossAxisCount: 5,
                                        //         crossAxisSpacing: 7,
                                        //         mainAxisSpacing: 10,
                                        //         childAspectRatio: .7,
                                        //       ),
                                        //       itemBuilder: (_s, vs){
                                        //         return SizedBox(
                                        //           child: Shortcuts(
                                        //             shortcuts: <LogicalKeySet, Intent>{
                                        //               LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                                        //             },
                                        //             child: ElevatedButton(
                                        //               onPressed: (){},
                                        //               style: ButtonStyle(
                                        //                 overlayColor: MaterialStateProperty.all<Color>(
                                        //                     yellowStar
                                        //                 ),
                                        //                 elevation: MaterialStateProperty.all(0),
                                        //                 backgroundColor: MaterialStateProperty.all<Color>(
                                        //                     Colors.transparent
                                        //                 ),
                                        //                 padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
                                        //                   horizontal: 0.3.w,
                                        //                   vertical: 0.3.w,
                                        //                 )),
                                        //               ),
                                        //               child: Shimmer.fromColors(
                                        //                 period: const Duration(seconds: 1),
                                        //                 baseColor: Colors.grey.shade400,
                                        //                 highlightColor: Colors.grey.shade100,
                                        //                 enabled: true,
                                        //                 child: Container(
                                        //                   child: ClipRRect(
                                        //                     borderRadius: BorderRadius.only(
                                        //                       topLeft: Radius.circular(1.w),
                                        //                       bottomLeft: Radius.circular(1.w),
                                        //                       bottomRight: Radius.circular(1.w),
                                        //                       topRight: Radius.circular(1.w),
                                        //                     ),
                                        //                     child: Container(
                                        //                       color: Colors.white.withOpacity(0.6),
                                        //                       width: 13.w,
                                        //                       height: 32.8.h,
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         );
                                        //       },
                                        //     ),
                                        //   ),
                                        // ),
                                        // HeadHome(title: "المسلسلات المفضلة"),
                                      ],
                                      ),
                                    )
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: HomeSideBar(
                                    catsOnPressed: () => Get.to(
                                      const CatsScreen( dirId: 1 ),
                                      transition: Transition.rightToLeftWithFade,
                                      duration: const Duration(milliseconds: 650),
                                    ),
                                    liveBtnTitle: "مباشر",
                                    liveIcon: Icons.ondemand_video,
                                    moviesOnPressed: () => Get.to(
                                      const CatsScreen( dirId: 2 ),
                                      transition: Transition.rightToLeftWithFade,
                                      duration: const Duration(milliseconds: 650),
                                    ),
                                    moviesBtnTitle: "افلام",
                                    moviesIcon: Icons.subscriptions,
                                    seriesOnPressed: () => Get.to(
                                      const CatsScreen( dirId: 3 ),
                                      transition: Transition.rightToLeftWithFade,
                                      duration: const Duration(milliseconds: 650),
                                    ),
                                    seriesBtnTitle: "مسلسلات",
                                    seriesIcon: Icons.library_add,

                                    settingOnPressed: () {},
                                    settingBtnTitle: "الإعدادات",
                                    settingIcon: Icons.settings,

                                    accountsOnPressed: () => Get.to(
                                      const AccountScreen(),
                                      transition: Transition.rightToLeftWithFade,
                                      duration: const Duration(milliseconds: 650),
                                    ),
                                    accountsBtnTitle: "الحساب",
                                    accountsIcon: Icons.account_circle,

                                    logOutOnPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('الخروج', style: TextStyle(fontFamily: 'Cairo'), textDirection: TextDirection.rtl,),
                                          content: Text(
                                            'هل تريد اغلاق التطبيق؟',
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontFamily: "Cairo",
                                            ),
                                          ),
                                          backgroundColor: black38,
                                          actions:[
                                            Shortcuts(
                                                shortcuts: <LogicalKeySet, Intent>{
                                                  LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                                                },
                                                child: MaterialButton(
                                                  focusElevation: 10,
                                                  color: white10,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20.0)
                                                  ),
                                                  child: const Text('لا', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                                                  onPressed: () => Navigator.of(context).pop(false),
                                                )
                                            ),
  
                                            Shortcuts(
                                              shortcuts: <LogicalKeySet, Intent>{
                                                LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                                              },
                                              child: MaterialButton(
                                                focusElevation: 10,
                                                color: appTextColorPrimary,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20.0)
                                                ),
                                                child: const Text('نعم', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: black)),
                                                onPressed: () => homeControllerImp.LogOut()
                                              ),
                                            ),
  
                                          ],
                                        ),
                                      );
                                    },
                                    logOutBtnTitle: "تسجيل الخروج",
                                    logOutIcon: Icons.exit_to_app,
                                  ),
                                ),
                              ],
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
          return Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              color: blackSendStar,
              child: Column(
                children: [
                  Container(
                    color: blackSendStar,
                    child: SafeArea(
                      child: Column(
                        children: [
                          HomeAppBar(
                            userName: homeController.username,
                          ),
                          SizedBox(
                            width: 100.w,
                            height: 87.h,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: SingleChildScrollView(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 5.h
                                        ),
                                        child: Column(
                                          children: [
                                            const HeadHome(title: "الافلام المميزة"),
                                            Container(
                                              padding: EdgeInsets.only(
                                                top: 2.w,
                                                left: 1.w,
                                                right: 1.w,
                                              ),
                                              width: 100.w,
                                              height: 38.h,
                                              child: NestedScrollView(
                                                headerSliverBuilder: (_, ch) {
                                                  return [];
                                                },
                                                body: GridView.builder(
                                                  itemCount: 5,
                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 5,
                                                    crossAxisSpacing: 7,
                                                    mainAxisSpacing: 10,
                                                    childAspectRatio: .7,
                                                  ),
                                                  itemBuilder: (_s, vs){
                                                    return SizedBox(
                                                      child: Shortcuts(
                                                        shortcuts: <LogicalKeySet, Intent>{
                                                          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                                                        },
                                                        child: ElevatedButton(
                                                          onPressed: (){},
                                                          style: ButtonStyle(
                                                            overlayColor: MaterialStateProperty.all<Color>(
                                                                yellowStar
                                                            ),
                                                            elevation: MaterialStateProperty.all(0),
                                                            backgroundColor: MaterialStateProperty.all<Color>(
                                                                Colors.transparent
                                                            ),
                                                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
                                                              horizontal: 0.3.w,
                                                              vertical: 0.3.w,
                                                            )),
                                                          ),
                                                          child: Shimmer.fromColors(
                                                            period: const Duration(seconds: 1),
                                                            baseColor: Colors.grey.shade400,
                                                            highlightColor: Colors.grey.shade100,
                                                            enabled: true,
                                                            child: Container(
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.only(
                                                                  topLeft: Radius.circular(1.w),
                                                                  bottomLeft: Radius.circular(1.w),
                                                                  bottomRight: Radius.circular(1.w),
                                                                  topRight: Radius.circular(1.w),
                                                                ),
                                                                child: Container(
                                                                  color: Colors.white.withOpacity(0.6),
                                                                  width: 13.w,
                                                                  height: 32.8.h,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            const HeadHome(title: "المسلسلات المميزة"),
                                            Container(
                                              padding: EdgeInsets.only(
                                                top: 2.w,
                                                left: 1.w,
                                                right: 1.w,
                                              ),
                                              width: 100.w,
                                              height: 38.h,
                                              child: NestedScrollView(
                                                headerSliverBuilder: (_, ch) {
                                                  return [];
                                                },
                                                body: GridView.builder(
                                                  itemCount: 5,
                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 5,
                                                    crossAxisSpacing: 7,
                                                    mainAxisSpacing: 10,
                                                    childAspectRatio: .7,
                                                  ),
                                                  itemBuilder: (_s, vs){
                                                    return SizedBox(
                                                      child: Shortcuts(
                                                        shortcuts: <LogicalKeySet, Intent>{
                                                          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                                                        },
                                                        child: ElevatedButton(
                                                          onPressed: (){},
                                                          style: ButtonStyle(
                                                            overlayColor: MaterialStateProperty.all<Color>(
                                                                yellowStar
                                                            ),
                                                            elevation: MaterialStateProperty.all(0),
                                                            backgroundColor: MaterialStateProperty.all<Color>(
                                                                Colors.transparent
                                                            ),
                                                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
                                                              horizontal: 0.3.w,
                                                              vertical: 0.3.w,
                                                            )),
                                                          ),
                                                          child: Shimmer.fromColors(
                                                            period: const Duration(seconds: 1),
                                                            baseColor: Colors.grey.shade400,
                                                            highlightColor: Colors.grey.shade100,
                                                            enabled: true,
                                                            child: Container(
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.only(
                                                                  topLeft: Radius.circular(1.w),
                                                                  bottomLeft: Radius.circular(1.w),
                                                                  bottomRight: Radius.circular(1.w),
                                                                  topRight: Radius.circular(1.w),
                                                                ),
                                                                child: Container(
                                                                  color: Colors.white.withOpacity(0.6),
                                                                  width: 13.w,
                                                                  height: 32.8.h,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            const HeadHome(title: "الافلام المفضلة"),
                                            Container(
                                              padding: EdgeInsets.only(
                                                top: 2.w,
                                                left: 1.w,
                                                right: 1.w,
                                              ),
                                              width: 100.w,
                                              height: 38.h,
                                              child: NestedScrollView(
                                                headerSliverBuilder: (_, ch) {
                                                  return [];
                                                },
                                                body: GridView.builder(
                                                  itemCount: 5,
                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 5,
                                                    crossAxisSpacing: 7,
                                                    mainAxisSpacing: 10,
                                                    childAspectRatio: .7,
                                                  ),
                                                  itemBuilder: (_s, vs){
                                                    return SizedBox(
                                                      child: Shortcuts(
                                                        shortcuts: <LogicalKeySet, Intent>{
                                                          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                                                        },
                                                        child: ElevatedButton(
                                                          onPressed: (){},
                                                          style: ButtonStyle(
                                                            overlayColor: MaterialStateProperty.all<Color>(
                                                                yellowStar
                                                            ),
                                                            elevation: MaterialStateProperty.all(0),
                                                            backgroundColor: MaterialStateProperty.all<Color>(
                                                                Colors.transparent
                                                            ),
                                                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
                                                              horizontal: 0.3.w,
                                                              vertical: 0.3.w,
                                                            )),
                                                          ),
                                                          child: Shimmer.fromColors(
                                                            period: const Duration(seconds: 1),
                                                            baseColor: Colors.grey.shade400,
                                                            highlightColor: Colors.grey.shade100,
                                                            enabled: true,
                                                            child: Container(
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.only(
                                                                  topLeft: Radius.circular(1.w),
                                                                  bottomLeft: Radius.circular(1.w),
                                                                  bottomRight: Radius.circular(1.w),
                                                                  topRight: Radius.circular(1.w),
                                                                ),
                                                                child: Container(
                                                                  color: Colors.white.withOpacity(0.6),
                                                                  width: 13.w,
                                                                  height: 32.8.h,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            const HeadHome(title: "المسلسلات المفضلة"),
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: HomeSideBar(
                                    catsOnPressed: () => Get.to( () => const CatsScreen( dirId: 1 ) ),
                                    liveBtnTitle: "مباشر",
                                    liveIcon: Icons.ondemand_video,
                                    moviesOnPressed: () => Get.to( () => const CatsScreen( dirId: 2 ) ),
                                    moviesBtnTitle: "افلام",
                                    moviesIcon: Icons.subscriptions,
                                    seriesOnPressed: () => Get.to( () => const CatsScreen( dirId: 3 ) ),
                                    seriesBtnTitle: "مسلسلات",
                                    seriesIcon: Icons.library_add,

                                    settingOnPressed: () {},
                                    settingBtnTitle: "الإعدادات",
                                    settingIcon: Icons.settings,

                                    accountsOnPressed: () => Get.to( () => const AccountScreen() ),
                                    accountsBtnTitle: "الحساب",
                                    accountsIcon: Icons.account_circle,

                                    logOutOnPressed: () => homeControllerImp.LogOut(),
                                    logOutBtnTitle: "تسجيل الخروج",
                                    logOutIcon: Icons.exit_to_app,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          );
        }),
      ),
    );
  }
}