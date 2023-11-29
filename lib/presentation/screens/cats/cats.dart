part of '../screens.dart';

class CatsScreen extends StatefulWidget {
  const CatsScreen({Key? key, required this.dirId}) : super(key: key);
  final dynamic dirId;

  @override
  State<CatsScreen> createState() => _CatsScreenState();
}

class _CatsScreenState extends State<CatsScreen> {
  VlcPlayerController? _videoPlayerController;
  double lastPosition = 0.0;
  int selectedVideo = 0;
  
  // other player
  VideoPlayerController? videoPlayerController;
  CustomVideoPlayerController? customVideoPlayerController;
  //

  CatsControllerImp catsController = Get.put(CatsControllerImp());

  LiveCatsControllerImp liveControllerImp = Get.put(LiveCatsControllerImp());
  LiveChannelsControllerImp liveChannelsControllerImp = Get.put(LiveChannelsControllerImp());
  
  MoviesCatsControllerImp moviesCatsControllerImp = Get.put(MoviesCatsControllerImp());
  MovieChannelsControllerImp movieChannelsControllerImp = Get.put(MovieChannelsControllerImp());

  SeriesCatsControllerImp seriesCatsControllerImp = Get.put(SeriesCatsControllerImp());
  SeriesChannelsControllerImp seriesChannelsControllerImp = Get.put(SeriesChannelsControllerImp());
  
  Future<void> playFstream() async {
    var catId;
    var streamId;
    await liveControllerImp.getLiveCats();
    if (liveControllerImp.categories.isNotEmpty) {
      catId = liveControllerImp.categories[1].categoryId;
    }
    await liveChannelsControllerImp.applyFirstCat();
    if (liveChannelsControllerImp.channels.isNotEmpty) {
      streamId = liveChannelsControllerImp.channels[0].streamId;
    }
    var streamLink = await liveChannelsControllerImp.openStream(streamId);
    print(streamLink);
    
    await Future.delayed(const Duration(milliseconds: 500)).then((value) {
      if(streamLink != null && streamId >= 1) {
        videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(streamLink))
          ..initialize().then((value) => setState(() {
            videoPlayerController?.play();
          }));
        customVideoPlayerController = CustomVideoPlayerController(
          context: context,
          videoPlayerController: videoPlayerController!,
          customVideoPlayerSettings: const CustomVideoPlayerSettings(
            customAspectRatio: 16 / 9,
            showFullscreenButton: false,
            showDurationPlayed: false,
            showDurationRemaining: false,
            settingsButtonAvailable: false,
          )
        );
        if (mounted) {
          setState(() {});
        }
      }
    });
   
    // await Future.delayed(const Duration(milliseconds: 500)).then((value) {
    //   if(streamLink != null && streamId >= 1) {
    //     _videoPlayerController = VlcPlayerController.network(
    //       streamLink,
    //       hwAcc: HwAcc.full,
    //       autoPlay: true,
    //       autoInitialize: true,
    //       options: VlcPlayerOptions(),
    //     );
    //   }
    //   if (mounted) {
    //     setState(() {});
    //   }
    // });
  }
  
  Future<void> clickTab() async {
    
    if(widget.dirId == 2){
      catsController.changeTab(2);
      _videoPlayerController = null;
      await moviesCatsControllerImp.getCats();
      moviesCatsControllerImp.update();
      await movieChannelsControllerImp.getMovies(
        moviesCatsControllerImp.categories[1].categoryId
      );
      movieChannelsControllerImp.update();
    }
    if(widget.dirId == 3){
      catsController.changeTab(3);
      _videoPlayerController = null;
      await seriesCatsControllerImp.getCats();
      catsController.update();
      await seriesChannelsControllerImp.getSeries(seriesCatsControllerImp.categories[1].categoryId);
      seriesChannelsControllerImp.update();
    }
    if(widget.dirId == 1){
      catsController.changeTab(1);
      _videoPlayerController = null;
      await liveControllerImp.getLiveCats();
      catsController.update();
    }
  }

  @override
  void initState() {
    clickTab();
    widget.dirId == 1 ? playFstream() : false;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    Get.put(CatsControllerImp());
    Get.put(MoviesCatsControllerImp());
    Get.put(SeriesCatsControllerImp());

    return WillPopScope(
      onWillPop: () async {
        if(context.read<VideoCubit>().state.isFull == false){
          Get.back();
        }
        else {
          context.read<VideoCubit>().changeUrlVideo(false);
          context.read<VideoCubit>().state.isFull == false;
        }
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: blackSendStar,
          height: double.infinity,
          width: double.infinity,
          child: GetBuilder<CatsControllerImp>(builder: (catsController) {
            return Column(
              children: [
                
                // top app bar
                BlocBuilder<VideoCubit, VideoState>(
                  builder: (context, state) {
                    return Visibility(
                      visible: context.read<VideoCubit>().state.isFull == true ? false : true,
                      child: CatsAppBar(
                        searchBtnOnPressed: () async {
                          
                        },
                        seriesButtonFocus: catsController.activeTab == 3 ? true : false,
                        seriesBtnOnPressed: () async {
                          catsController.changeTab(3);
                          _videoPlayerController = null;
                          seriesCatsControllerImp.getCats();
                          seriesChannelsControllerImp.getSeries(seriesCatsControllerImp.categories[1].categoryId);

                          setState(() {
                            if(videoPlayerController != null) {
                              videoPlayerController!.pause();
                              videoPlayerController = null;
                              customVideoPlayerController = null;
                            }
                          });
                        },
                        moviesButtonFocus: catsController.activeTab == 2 ? true : false,
                        moviesBtnOnPressed: () async {
                          catsController.changeTab(2);
                          _videoPlayerController = null;
                          moviesCatsControllerImp.getCats();
                          movieChannelsControllerImp.getMovies(moviesCatsControllerImp.categories[1].categoryId);

                          setState(() {
                            if(videoPlayerController != null) {
                              videoPlayerController!.pause();
                              videoPlayerController = null;
                              customVideoPlayerController = null;
                            }
                          });
                        },
                        liveButtonFocus: catsController.activeTab == 1 ? true : false,
                        liveBtnOnPressed: () async {
                          _videoPlayerController = null;
                          liveControllerImp.getLiveCats();
                          liveChannelsControllerImp.applyFirstCat();
                          playFstream();
                          catsController.changeTab(1);

                          setState(() {
                            if(videoPlayerController != null) {
                              videoPlayerController!.pause();
                              videoPlayerController = null;
                              customVideoPlayerController = null;
                            }
                          });
                        },
                      ),
                    );
                  },
                ),

                // live categories
                GetBuilder<LiveCatsControllerImp>(builder: (liveController) {
                  return Visibility(
                    visible: catsController.activeTab == 1 ? true : false,
                    child: BlocBuilder<VideoCubit, VideoState>(
                      builder: (context, state) {
                        return Ink(
                          width: 100.w,
                          height: context.read<VideoCubit>().state.isFull == true ? 100.h : 90.h,
                          child: Row(
                            children: [
                              
                              // live categories 
                              BlocBuilder<VideoCubit, VideoState>(
                                builder: (context, state) {
                                  return Visibility(
                                    visible: context.read<VideoCubit>().state.isFull == true ? false : true,
                                    child: Flexible(
                                      flex: 2,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 90.h,
                                            padding: EdgeInsets.all(0.4.w),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                  width: 0.04.w,
                                                  color: yellowStar
                                                ),
                                                bottom: BorderSide(
                                                  width: 0.04.w,
                                                  color: yellowStar
                                                ),
                                              ),
                                            ),
                                            margin: EdgeInsets.only(
                                                left: 0.5.w),
                                            child: NestedScrollView(
                                              headerSliverBuilder: (_, ch) {
                                                return [];
                                              },
                                              body: HandleRequest(
                                                statusRequest: liveController.statusRequest,
                                                widget: GridView.builder(
                                                  // physics: const NeverScrollableScrollPhysics(),
                                                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                                  padding: EdgeInsets.only(
                                                    bottom: 10.h,
                                                  ),
                                                  itemCount: liveController.categories.length,
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio: 1,
                                                    crossAxisCount: 1,
                                                    mainAxisSpacing: 2,
                                                    mainAxisExtent: 7.h,
                                                  ),
                                                  itemBuilder: (_, i) {
                                                    return AnimationConfiguration.staggeredList(
                                                      position: i,
                                                      delay: const Duration(milliseconds: 100),
                                                      child: SlideAnimation(
                                                        duration: const Duration(milliseconds: 500),
                                                        curve: Curves.fastLinearToSlowEaseIn,
                                                        horizontalOffset: 30,
                                                        verticalOffset: 300.0,
                                                        child: FlipAnimation(
                                                          duration: const Duration(milliseconds: 500),
                                                          curve: Curves.fastLinearToSlowEaseIn,
                                                          flipAxis: FlipAxis.y,
                                                          child: MenuItem(
                                                            count: "${i +1}",
                                                            title: liveController.categories[i].categoryName,
                                                            isSelected: liveController.selectedCat == (i) ? true : false,
                                                            onTap: () {
                                                              liveController.selectedCat = i;
                                                              liveChannelsControllerImp.getLiveCatChilds(
                                                                liveController.categories[i].categoryId
                                                              );
                                                              selectedVideo = 6000;
                                                              liveController.update();
                                                              liveChannelsControllerImp.update();
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),

                              // live channels 
                              BlocBuilder<VideoCubit, VideoState>(
                                builder: (context, state) {
                                  return Visibility(
                                    visible: context.read<VideoCubit>().state.isFull == true ? false : true,
                                    child: Flexible(
                                      flex: 2,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 90.h,
                                            padding: EdgeInsets.all(0.4.w),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
                                                    width: 0.04.w,
                                                    color: yellowStar),
                                                left: BorderSide(
                                                    width: 0.04.w,
                                                    color: yellowStar),
                                                bottom: BorderSide(
                                                    width: 0.04.w,
                                                    color: yellowStar),
                                              ),
                                            ),
                                            child: NestedScrollView(
                                              headerSliverBuilder: (_, ch) {
                                                return [];
                                              },
                                              body: GetBuilder<
                                                  LiveChannelsControllerImp>(
                                                builder: (
                                                    liveChannelController) {
                                                  return HandleRequest(
                                                    statusRequest: liveChannelController.statusRequest,
                                                    widget: GridView.builder(
                                                      // physics: const NeverScrollableScrollPhysics(),
                                                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                                      padding: EdgeInsets.only(
                                                        bottom: 2.h,
                                                      ),
                                                      itemCount: liveChannelsControllerImp.channels.length,
                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 1,
                                                        mainAxisSpacing: 2,
                                                        mainAxisExtent: 7.h,
                                                        crossAxisSpacing: 10,
                                                      ),
                                                      itemBuilder: (cont, index) {
                                                        return AnimationConfiguration.staggeredList(
                                                          position: index,
                                                          delay: const Duration(milliseconds: 100),
                                                          child: SlideAnimation(
                                                            duration: const Duration(milliseconds: 500),
                                                            curve: Curves.fastLinearToSlowEaseIn,
                                                            horizontalOffset: 30,
                                                            verticalOffset: 300.0,
                                                            child: FlipAnimation(
                                                              duration: const Duration(milliseconds: 500),
                                                              curve: Curves.fastLinearToSlowEaseIn,
                                                              flipAxis: FlipAxis.y,
                                                              child: MenuItem(
                                                                count: "${index +1}",
                                                                title: liveChannelsControllerImp.channels[index].name,
                                                                image: liveChannelsControllerImp.channels[index].streamIcon == "" ?
                                                                null : liveChannelsControllerImp.channels[index].streamIcon,
                                                                isSelected: selectedVideo == null ? false : selectedVideo == index,
                                                                onTap: () async {
                                                                  try {
                                                                    if (selectedVideo == index && videoPlayerController != null) {
                                                                      context.read<VideoCubit>().changeUrlVideo(true);
                                                                      context.read<VideoCubit>().state.isFull == true;
                                                                      setState(() {});
                                                                    } else {
                                                                      if (videoPlayerController != null) {
                                                                        if (mounted) {
                                                                          videoPlayerController!.pause();
                                                                          videoPlayerController = null;
                                                                          customVideoPlayerController = null;
                                                                          setState(() {});
                                                                        } else {
                                                                          setState(() {});
                                                                        }
                                                                      }
                                                                      var link = await liveChannelsControllerImp.openStream(
                                                                        liveChannelsControllerImp.channels[index].streamId
                                                                      );
                                                                      await Future.delayed(const Duration(milliseconds: 200)).then((value) {
                                                                        selectedVideo = index;
                                                                          videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(link))
                                                                            ..initialize().then((value) => setState(() {
                                                                              videoPlayerController?.play();
                                                                            }));
                                                                          customVideoPlayerController = CustomVideoPlayerController(
                                                                              context: context,
                                                                              videoPlayerController: videoPlayerController!,
                                                                              customVideoPlayerSettings: const CustomVideoPlayerSettings(
                                                                                customAspectRatio: 16 / 9,
                                                                                showFullscreenButton: false,
                                                                                showDurationPlayed: false,
                                                                                showDurationRemaining: false,
                                                                                settingsButtonAvailable: false,
                                                                              )
                                                                          );
                                                                          setState(() {});
                                                                      });
                                                                      // await Future.delayed(const Duration(milliseconds: 200)).then((value) {
                                                                      //   selectedVideo = index;
                                                                      //   _videoPlayerController =
                                                                      //       VlcPlayerController.network(
                                                                      //         link,
                                                                      //         hwAcc: HwAcc.full,
                                                                      //         autoPlay: true,
                                                                      //         autoInitialize: true,
                                                                      //         options: VlcPlayerOptions(),
                                                                      //       );
                                                                      //     setState(() {});
                                                                      // });
                                                                      // setState(() {});
                                                                    }
                                                                  } catch (e) {
                                                                    debugPrint("error =>: $e");
                                                                    context.read<VideoCubit>().changeUrlVideo(false);
                                                                    _videoPlayerController = null;
                                                                    setState(() {});
                                                                  }
                                                                },
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
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),

                              // live player 
                              Expanded(
                                flex: 5,
                                child: Column(
                                  children: [
                                    GetBuilder<LiveChannelsControllerImp>(
                                      builder: (videController) {
                                        return InkWell(
                                          onDoubleTap: () {
                                            context.read<VideoCubit>().changeUrlVideo(true);
                                            context.read<VideoCubit>().state.isFull == true;
                                            setState(() {});
                                          },
                                          child: MiniPlayer(
                                            controller: videoPlayerController,
                                            customVideoPlayerController: customVideoPlayerController,
                                          ),
                                        );
                                      },
                                    ),
                                    BlocBuilder<VideoCubit, VideoState>(
                                      builder: (context, state) {
                                        return Visibility(
                                          visible: context.read<VideoCubit>().state.isFull == true ? false : true,
                                          child: GetBuilder<
                                              LiveChannelsControllerImp>(
                                            builder: (liveChannelController) {
                                              return Container(
                                                alignment: Alignment.centerRight,
                                                child: Shortcuts(
                                                  shortcuts: <LogicalKeySet, Intent>{
                                                    LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                                                  },
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      if(liveChannelsControllerImp.channels.isNotEmpty){
                                                        catsController.addFav(
                                                            await liveChannelsControllerImp.channels[selectedVideo]
                                                        );
                                                        liveChannelController.favOn == true ? liveChannelController.favOn = false : liveChannelController.favOn = true;
                                                      }
                                                      liveChannelController.update();
                                                    },
                                                    style: ButtonStyle(
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.h),)
                                                      ),
                                                      backgroundColor: MaterialStateProperty.all<Color>( bg2 ),
                                                      overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                                        states.contains(white38);
                                                      }),
                                                      elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
                                                        return 0;
                                                      }),
                                                      fixedSize: MaterialStateProperty.all<Size>(
                                                          Size(13.w, 5.h)
                                                      ),
                                                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
                                                        horizontal: 2.w
                                                      )),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          liveChannelController
                                                            .favOn == true
                                                            ? "ازالة المفضلة"
                                                            : "اضافة المفضلة",
                                                          style: TextStyle(
                                                            fontFamily: "Cairo",
                                                            fontSize: 13.sp,
                                                            color: liveChannelController
                                                              .favOn == true
                                                              ? red
                                                              : Colors.white
                                                          )
                                                        ),
                                                        // Icon(
                                                        //     Icons.favorite,
                                                        //     size: 3.w,
                                                        //     color: liveChannelController
                                                        //         .favOn == true
                                                        //         ? red
                                                        //         : offlineGray
                                                        // ),
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }),

                // movies
                Visibility(
                  visible: catsController.activeTab == 2 ? true : false,
                  child: Container(
                    width: 100.w,
                    height: 90.h,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Column(
                            children: [
                              Container(
                                height: 90.h,
                                padding: EdgeInsets.all(0.4.w),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                        width: 0.04.w,
                                        color: yellowStar
                                    ),
                                    right: BorderSide(
                                        width: 0.04.w,
                                        color: yellowStar
                                    ),
                                    bottom: BorderSide(
                                        width: 0.04.w,
                                        color: yellowStar
                                    ),
                                  ),
                                ),
                                margin: EdgeInsets.only(left: 0.5.w),
                                child: NestedScrollView(
                                  headerSliverBuilder: (_, ch) {
                                    return [];
                                  },
                                  body: GetBuilder<MoviesCatsControllerImp>(
                                    builder: (movieCatsController) {
                                      return HandleRequest(
                                        statusRequest: movieCatsController
                                            .statusRequest,
                                        widget: GridView.builder(
                                          // physics: const NeverScrollableScrollPhysics(),
                                            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                            padding: EdgeInsets.only(
                                              bottom: 2.h,
                                            ),
                                            itemCount: movieCatsController.categories.length,
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1,
                                              mainAxisSpacing: 2,
                                              mainAxisExtent: 7.h,
                                              crossAxisSpacing: 10,
                                            ),
                                            itemBuilder: (_, itr) {
                                              return AnimationConfiguration.staggeredList(
                                                position: itr,
                                                delay: const Duration(milliseconds: 100),
                                                child: SlideAnimation(
                                                  duration: const Duration(milliseconds: 500),
                                                  curve: Curves.fastLinearToSlowEaseIn,
                                                  horizontalOffset: 30,
                                                  verticalOffset: 300.0,
                                                  child: FlipAnimation(
                                                    duration: const Duration(milliseconds: 500),
                                                    curve: Curves.fastLinearToSlowEaseIn,
                                                    flipAxis: FlipAxis.y,
                                                    child: MenuItem(
                                                      count: "${itr +1}",
                                                      title: movieCatsController.categories[itr].categoryName,
                                                      isSelected: movieCatsController.selectedCat == (itr) ? true : false,
                                                      // count: movieCatsController.catsCount[itr] == itr ? 0 : movieCatsController.catsCount[itr],
                                                      onTap: () async {
                                                        movieChannelsControllerImp.getMovies(
                                                          movieCatsController.categories[itr].categoryId
                                                        );
                                                        movieCatsController.selectedCat = itr;
                                                        movieCatsController.update();
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 1.w),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 2.h, right: 1.w),
                                width: 100.w,
                                height: 90.h,
                                child: NestedScrollView(
                                  headerSliverBuilder: (_, ch) {
                                    return [];
                                  },
                                  body: GetBuilder<MovieChannelsControllerImp>(
                                    builder: (moviesController) {
                                      return HandleRequest(
                                        statusRequest: moviesController.statusRequest,
                                        widget: GridView.builder(
                                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                          padding: EdgeInsets.only(
                                            bottom: 2.h,
                                          ),
                                          itemCount: moviesController.movies.length,
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 5,
                                            crossAxisSpacing: 7,
                                            mainAxisSpacing: 10,
                                            childAspectRatio: .7,
                                          ),
                                          itemBuilder: (_, i) {
                                            return AnimationConfiguration.staggeredGrid(
                                              position: i,
                                              duration: const Duration(milliseconds: 350),
                                              columnCount: 5,
                                              child: ScaleAnimation(
                                                duration: const Duration(milliseconds: 500),
                                                curve: Curves.fastLinearToSlowEaseIn,
                                                scale: 1.5,
                                                child: FadeInAnimation(
                                                  child: CardChannelMovieItem(
                                                    title: moviesController.movies[i].name,
                                                    image: moviesController.movies[i].streamIcon,
                                                    onTap: () {
                                                      Get.to(
                                                        MovieDetails(videoId: moviesController.movies[i].streamId ?? ''),
                                                        transition: Transition.rightToLeftWithFade,
                                                        duration: const Duration(milliseconds: 500),
                                                      );
                                                    },
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // series
                Visibility(
                visible: catsController.activeTab == 3 ? true : false,
                  child: Container(
                    width: 100.w,
                    height: 90.h,
                    child: Row(
                      children: [
                        
                        Flexible(
                          flex: 1,
                          child: Column(
                            children: [
                              Container(
                                height: 90.h,
                                padding: EdgeInsets.all(0.4.w),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                        width: 0.04.w,
                                        color: yellowStar
                                    ),
                                    right: BorderSide(
                                        width: 0.04.w,
                                        color: yellowStar
                                    ),
                                    bottom: BorderSide(
                                        width: 0.04.w,
                                        color: yellowStar
                                    ),
                                  ),
                                ),
                                margin: EdgeInsets.only(left: 0.5.w),
                                child: NestedScrollView(
                                  headerSliverBuilder: (_, ch) {
                                    return [];
                                  },
                                  body: GetBuilder<SeriesCatsControllerImp>(
                                    builder: (seriesCatsController) {
                                      return HandleRequest(
                                        statusRequest: seriesCatsController
                                            .statusRequest,
                                        widget: GridView.builder(
                                          // physics: const NeverScrollableScrollPhysics(),
                                            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                            padding: EdgeInsets.only(
                                              bottom: 2.h,
                                            ),
                                            itemCount: seriesCatsController
                                                .categories.length,
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1,
                                              mainAxisSpacing: 2,
                                              mainAxisExtent: 7.h,
                                              crossAxisSpacing: 10,
                                            ),
                                            itemBuilder: (_, its) {
                                              return AnimationConfiguration.staggeredList(
                                                position: its,
                                                delay: const Duration(milliseconds: 100),
                                                child: SlideAnimation(
                                                  duration: const Duration(milliseconds: 500),
                                                  curve: Curves.fastLinearToSlowEaseIn,
                                                  horizontalOffset: 30,
                                                  verticalOffset: 300.0,
                                                  child: FlipAnimation(
                                                    duration: const Duration(milliseconds: 500),
                                                    curve: Curves.fastLinearToSlowEaseIn,
                                                    flipAxis: FlipAxis.y,
                                                    child: MenuItem(
                                                      count: "${its +1}",
                                                      title: seriesCatsController.categories[its].categoryName,
                                                      isSelected: seriesCatsController.selectedCat == (its) ? true : false,
                                                      onTap: () async {
                                                        seriesChannelsControllerImp.getSeries(
                                                          seriesCatsController.categories[its].categoryId
                                                        );
                                                        seriesCatsController.selectedCat = its;
                                                        seriesCatsController.update();
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 1.w),
                        
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 2.h, right: 1.w),
                                width: 100.w,
                                height: 90.h,
                                child: NestedScrollView(
                                  headerSliverBuilder: (_, ch) {
                                    return [];
                                  },
                                  body: GetBuilder<SeriesChannelsControllerImp>(
                                    builder: (seriesController) {
                                      return HandleRequest(
                                        statusRequest: seriesController.statusRequest,
                                        widget: GridView.builder(
                                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                          padding: EdgeInsets.only(
                                            bottom: 2.h,
                                          ),
                                          itemCount: seriesController.series.length,
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 5,
                                            crossAxisSpacing: 7,
                                            mainAxisSpacing: 10,
                                            childAspectRatio: .7,
                                          ),
                                          itemBuilder: (_, i) {
                                            return AnimationConfiguration.staggeredGrid(
                                              position: i,
                                              duration: const Duration(milliseconds: 350),
                                              columnCount: 5,
                                              child: ScaleAnimation(
                                                duration: const Duration(milliseconds: 500),
                                                curve: Curves.fastLinearToSlowEaseIn,
                                                scale: 1.5,
                                                child: FadeInAnimation(
                                                  child: CardChannelMovieItem(
                                                    title: seriesController.series[i].name,
                                                    image: seriesController.series[i].cover,
                                                    onTap: () {
                                                      Get.to(
                                                        SeriesDetails(videoId: seriesController.series[i].seriesId ?? ''),
                                                        transition: Transition.rightToLeftWithFade,
                                                        duration: const Duration(milliseconds: 650),
                                                      );
                                                    },
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
              ],
            );
          }),
        ),
      ),
    );
  }
}
