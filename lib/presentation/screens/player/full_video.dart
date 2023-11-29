part of '../screens.dart';

class FullVideoScreen extends StatefulWidget {
  const FullVideoScreen({Key? key, required this.link}) : super(key: key);
  final String link;

  @override
  State<FullVideoScreen> createState() => _FullVideoScreenState();
}

class _FullVideoScreenState extends State<FullVideoScreen> {
  late VlcPlayerController _videoPlayerController;
  bool isPlayed = true;
  bool progress = true;
  bool showControllersVideo = false;
  String position = '';
  String duration = '';
  double sliderValue = 0.0;
  bool validPosition = false;

  final FocusNode f1 = FocusNode();
  final FocusNode f2 = FocusNode();
  final FocusNode f3 = FocusNode();
  final FocusNode f4 = FocusNode();
  final FocusNode f5 = FocusNode();

  Timer? timer;
  
  bool _onKey(KeyEvent event) {
    final key = event.physicalKey.usbHidUsage;
    
    if(event is KeyDownEvent) {
      if(FocusScope.of(context).focusedChild != null) {
        if (FocusScope.of(context).focusedChild!.ancestors.elementAt(2).children.elementAt(0).hasFocus) {
          setState(() {
            FocusScope.of(context).focusedChild?.ancestors.elementAt(2).children.elementAt(0).nextFocus();
          });
        }
      }
      if (key == 73014444264 && mounted) {
        setState(() {
          showControllersVideo = true;
        });
        timer?.cancel();
        timer = Timer(const Duration(seconds: 10), (){
          showControllersVideo = !showControllersVideo;
        }
        );
      } else if(key == 458831){
        if(mounted) {
          FocusScope.of(context).nextFocus();
          setState(() {
            showControllersVideo = true;
          });
          timer?.cancel();
          timer = Timer(const Duration(seconds: 10), (){
            showControllersVideo = !showControllersVideo;
          }
          );
        }
      } else if(key == 458832){
        if(mounted) {
          FocusScope.of(context).previousFocus();
          setState(() {
            showControllersVideo = true;
          });
          timer?.cancel();
          timer = Timer(
              const Duration(seconds: 10), (){
            showControllersVideo = !showControllersVideo;
          }
          );
        }
      } else if(key == 458833){
        if(mounted) {
          FocusScope.of(context).nextFocus();
          setState(() {
            showControllersVideo = true;
          });
          timer?.cancel();
          timer = Timer(
            const Duration(seconds: 10), (){
              showControllersVideo = !showControllersVideo;
            }
          );
        }
      } else if(key == 458834){
        if(mounted) {
          f1.requestFocus();
          setState(() {
            showControllersVideo = true;
          });
          timer?.cancel();
          timer = Timer(
            const Duration(seconds: 10), (){
              showControllersVideo = !showControllersVideo;
            }
          );
        }
      } else {
        timer?.cancel();
        timer = Timer(const Duration(seconds: 10), (){
          showControllersVideo = !showControllersVideo;
        });
      }
    }
    return false;
  }
  
  @override
  void initState() {
    _videoPlayerController = VlcPlayerController.network(
      widget.link,
      hwAcc: HwAcc.full,
      autoPlay: true,
      autoInitialize: true,
      options: VlcPlayerOptions(),
    );
    
    _videoPlayerController.addListener(listener);
    ServicesBinding.instance.keyboard.addHandler(_onKey);
    
    timer = Timer(
      const Duration(seconds: 10), (){
        showControllersVideo = !showControllersVideo;
      }
    );
    super.initState();
  }
  
  void listener() async {
    if (!mounted) return;

    if (progress) {
      if (_videoPlayerController.value.isPlaying) {
        setState(() {
          progress = false;
        });
      }
    }

    if (_videoPlayerController.value.isInitialized) {
      var oPosition = _videoPlayerController.value.position;
      var oDuration = _videoPlayerController.value.duration;

      if (oDuration.inHours == 0) {
        var strPosition = oPosition.toString().split('.')[0];
        var strDuration = oDuration.toString().split('.')[0];
        position = "${strPosition.split(':')[1]}:${strPosition.split(':')[2]}";
        duration = "${strDuration.split(':')[1]}:${strDuration.split(':')[2]}";
      } else {
        position = oPosition.toString().split('.')[0];
        duration = oDuration.toString().split('.')[0];
      }
      validPosition = oDuration.compareTo(oPosition) >= 0;
      sliderValue = validPosition ? oPosition.inSeconds.toDouble() : 0;
      setState(() {});
    }
  }

  void _onSliderPositionChanged(double progress) {
    setState(() {
      sliderValue = progress.floor().toDouble();
    });
    //convert to Milliseconds since VLC requires MS to set time
    _videoPlayerController.setTime(sliderValue.toInt() * 1000);
  }

  @override
  void dispose() async {
    super.dispose();
    f1.dispose();
    f2.dispose();
    f3.dispose();
    f4.dispose();
    f5.dispose();
    await _videoPlayerController.stopRendererScanning();
    await _videoPlayerController.dispose();
    showControllersVideo = false;
    ServicesBinding.instance.keyboard.removeHandler(_onKey);
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: VlcPlayer(
              controller: _videoPlayerController,
              aspectRatio: 16 / 9,
              virtualDisplay: true,
              placeholder: const SizedBox(),
            ),
          ),
          if (progress)
            const Center(
                child: CircularProgressIndicator(
              color: yellowStar,
            )),
          if(showControllersVideo != false)
          Container(
            width: 100.w,
            height: 100.h,
            color: Colors.transparent,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 100.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Shortcuts(
                            shortcuts: <LogicalKeySet, Intent>{
                              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                            },
                            child: ElevatedButton(
                              focusNode: f1,
                              autofocus: true,
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
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 100.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Shortcuts(
                            shortcuts: <LogicalKeySet, Intent>{
                              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                            },
                            child: ElevatedButton(
                              focusNode: f2,
                              onPressed: () {
                                setState(() {
                                  _onSliderPositionChanged(_videoPlayerController.value.position.inSeconds + 20);
                                });
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
                                Icons.fast_rewind,
                                color: yellowStar, size: 3.w
                              ),
                            ),
                          ),
                          SizedBox(width: 1.w),
                          Shortcuts(
                            shortcuts: <LogicalKeySet, Intent>{
                              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                            },
                            child: ElevatedButton(
                              focusNode: f3,
                              onPressed: () {
                                setState(() {
                                  if (isPlayed) {
                                    _videoPlayerController.pause();
                                    isPlayed = false;
                                  } else {
                                    _videoPlayerController.play();
                                    isPlayed = true;
                                  }
                                });
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
                                isPlayed
                                ? FontAwesomeIcons.pause
                                : FontAwesomeIcons.play,
                                color: yellowStar, size: 3.w
                              ),
                            ),
                          ),
                          SizedBox(width: 1.w),
                          Shortcuts(
                            shortcuts: <LogicalKeySet, Intent>{
                              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                            },
                            child: ElevatedButton(
                              focusNode: f4,
                              onPressed: () {
                                setState(() {
                                  _onSliderPositionChanged(_videoPlayerController.value.position.inSeconds + 20);
                                });
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
                                Icons.fast_forward,
                                color: yellowStar, size: 3.w
                              ),
                              onFocusChange: (focused){
                                if(!focused){
                                  // f4.nextFocus();
                                  print(f4.enclosingScope);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // GestureDetector(
          //   onTap: (){
          //     setState(() {
          //       showControllersVideo = !showControllersVideo;
          //     });
          //   },
          //   child: Container(
          //     width: 100.w,
          //     height: 100.h,
          //     color: Colors.transparent,
          //     child: AnimatedSize(
          //       duration: const Duration(milliseconds: 200),
          //       child: !showControllersVideo
          //         ? const SizedBox()
          //         : Material(
          //           color: Colors.transparent,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.end,
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //              
          //               IconButton(
          //                 // focusNode: f1,
          //                 autofocus: true,
          //                 focusColor: bg2,
          //                 onPressed: () => Get.back(),
          //                 icon: Icon(
          //                   FontAwesomeIcons.chevronRight,
          //                   size: 20.sp,
          //                 ),
          //               ),
          //                
          //               Center(
          //                 child: IconButton(
          //                   focusNode: f2,
          //                   focusColor: bg2,
          //                   onPressed: () {
          //                     setState(() {
          //                       if (isPlayed) {
          //                         _videoPlayerController.pause();
          //                         isPlayed = false;
          //                       } else {
          //                         _videoPlayerController.play();
          //                         isPlayed = true;
          //                       }
          //                     });
          //                   },
          //                   icon: Icon(
          //                     isPlayed
          //                         ? FontAwesomeIcons.pause
          //                         : FontAwesomeIcons.play,
          //                     size: 25.sp,
          //                   ),
          //                 ),
          //               ),
          //              
          //               if (!progress)
          //                 Align(
          //                   alignment: Alignment.bottomCenter,
          //                   child: Container(
          //                     width: 60.w,
          //                     decoration: BoxDecoration(
          //                       color: black54,
          //                       borderRadius: BorderRadius.circular(10),
          //                     ),
          //                     padding: const EdgeInsets.symmetric(
          //                       horizontal: 15,
          //                       vertical: 5,
          //                     ),
          //                     margin: const EdgeInsets.all(5),
          //                     child: Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       mainAxisSize: MainAxisSize.max,
          //                       children: [
          //                         Text(
          //                           position,
          //                           style:
          //                               Get.textTheme.subtitle2!.copyWith(
          //                             fontSize: 15.sp,
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         Expanded(
          //                           child: IgnorePointer(
          //                             ignoring: false,
          //                             child: Slider(
          //                               activeColor: yellowStar,
          //                               inactiveColor: Colors.white70,
          //                               value: sliderValue,
          //                               min: 0.0,
          //                               max:
          //                                   (!validPosition) && _videoPlayerController.value.duration == null
          //                                       ? 1.0
          //                                       : _videoPlayerController
          //                                           .value
          //                                           .duration
          //                                           .inSeconds
          //                                           .toDouble(),
          //                               onChanged: validPosition
          //                                   ? _onSliderPositionChanged
          //                                   : null,
          //                             ),
          //                           ),
          //                         ),
          //                         Text(
          //                           duration,
          //                           style:
          //                               Get.textTheme.subtitle2!.copyWith(
          //                             fontSize: 15.sp,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //             ],
          //           ),
          //         ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
