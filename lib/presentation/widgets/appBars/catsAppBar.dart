part of '../widgets.dart';

class CatsAppBar extends StatelessWidget {

  final bool? seriesButtonFocus;
  final Future<void> Function()? seriesBtnOnPressed;

  final bool? moviesButtonFocus;
  final Future<void> Function()? moviesBtnOnPressed;

  final bool? liveButtonFocus;
  final Future<void> Function()? liveBtnOnPressed;

  final Future<void> Function()? searchBtnOnPressed;
  
  final Future<void> Function()? playerOneOnTap;
  final Future<void> Function()? playerTwoOnTap;
  
  const CatsAppBar({
    super.key,
    this.seriesButtonFocus,
    this.seriesBtnOnPressed,
    this.moviesButtonFocus,
    this.moviesBtnOnPressed,
    this.liveButtonFocus,
    this.liveBtnOnPressed,
    this.searchBtnOnPressed,
    this.playerOneOnTap,
    this.playerTwoOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: blackSendStar,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: 100.w,
              height: 10.h,
              color: bgBlackSendStar,
              child: Row(
                children: [
                  SizedBox(
                    width: 6.w,
                    child: Shortcuts(
                      shortcuts: <LogicalKeySet, Intent>{
                        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ButtonStyle(
                          elevation:
                          MaterialStateProperty.all(0),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              bgBlackSendStar
                          ),
                        ),
                        child: Icon(
                            Icons.arrow_back_ios,
                            color: yellowStar, size: 3.w
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 0.1.w,
                    height: 8.h,
                    margin: EdgeInsets.only(
                        left: 1.w,
                        right: 3.w
                    ),
                    color: yellowStar,
                  ),
                  Image(
                    height: 11.h,
                    image: const AssetImage(k3dLogo),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 47.w,
                    height: 7.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Shortcuts(
                          shortcuts: <LogicalKeySet, Intent>{
                            LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                          },
                          child: ElevatedButton(
                            onPressed: seriesBtnOnPressed,
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
                                  horizontal: 1.5.w
                              )),
                              fixedSize: MaterialStateProperty.all<Size>(
                                Size(13.w, 3.h),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>( seriesButtonFocus == true ? white38 : bg2 ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  )
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.library_add, size: 2.w, color: appTextColorPrimary),
                                SizedBox(width: 0.6.w),
                                Text(
                                  "مسلسلات",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: appTextColorPrimary,
                                      fontFamily: 'Cairo'
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        SizedBox(width: 1.w),
                        
                        Shortcuts(
                          shortcuts: <LogicalKeySet, Intent>{
                            LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                          },
                          child: ElevatedButton(
                            onPressed: moviesBtnOnPressed,
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
                                  horizontal: 1.5.w
                              )),
                              fixedSize: MaterialStateProperty.all<Size>(
                                Size(13.w, 3.h),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>( moviesButtonFocus == true ? white38 : bg2 ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  )
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.subscriptions, size: 2.w, color: appTextColorPrimary),
                                SizedBox(width: 0.6.w),
                                Text(
                                  "افلام",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: appTextColorPrimary,
                                      fontFamily: 'Cairo'
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        SizedBox(width: 1.w),
                        
                        Shortcuts(
                          shortcuts: <LogicalKeySet, Intent>{
                            LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                          },
                          child: ElevatedButton(
                            onPressed: liveBtnOnPressed,
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
                                  horizontal: 1.5.w
                              )),
                              fixedSize: MaterialStateProperty.all<Size>(
                                Size(13.w, 3.h),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>( liveButtonFocus == true ? white38 : bg2 ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  )
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.ondemand_video, size: 2.w, color: appTextColorPrimary),
                                SizedBox(width: 0.6.w),
                                Text(
                                  "مباشر",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: appTextColorPrimary,
                                      fontFamily: 'Cairo'
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                    height: 100.h,
                    child: Shortcuts(
                      shortcuts: <LogicalKeySet, Intent>{
                        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                      },
                      child: ElevatedButton(
                        onPressed: searchBtnOnPressed,
                        style: ButtonStyle(
                          elevation:
                          MaterialStateProperty.all(0),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              Colors.transparent
                          ),
                        ),
                        child: Icon(
                            Icons.search,
                            color: yellowStar, size: 3.w
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                    child: MaterialButton(
                      onPressed: () {  },
                      child: Shortcuts(
                        shortcuts: <LogicalKeySet, Intent>{
                          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                        },
                        child: PopupMenuButton(
                          color: black87,
                          padding: EdgeInsets.all(0),
                          onSelected: (val){
                            return val;
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          offset: Offset(-58.w, 25.h),
                          icon: Icon(
                            FontAwesomeIcons.ellipsisVertical,
                            color: yellowStar,
                            size: 3.w,
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              padding: EdgeInsets.only(top: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 30.w,
                                    height: 8.h,
                                    decoration: BoxDecoration(
                                      color: black54,
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 0.1.w,
                                            color: yellowStar
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "اختر المشغل",
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              color: yellowStar
                                          ),
                                        ),
                                        SizedBox(width: 1.w),
                                        Icon(
                                          FontAwesomeIcons.play,
                                          color: yellowStar,
                                          size: 2.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: playerOneOnTap,
                              padding: EdgeInsets.only(top: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 30.w,
                                    height: 8.h,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Tiatro Player",
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 16.sp,
                                              color: Colors.white
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: playerTwoOnTap,
                              padding: EdgeInsets.only(top: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 30.w,
                                    height: 8.h,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "المشغل 2",
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 16.sp,
                                              color: Colors.white
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          elevation: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
