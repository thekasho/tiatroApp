part of 'widgets.dart';

class CardChannelMovieItem extends StatelessWidget {
  const CardChannelMovieItem(
      {Key? key, required this.onTap, this.title, this.image})
      : super(key: key);
  final Function() onTap;
  final String? title;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        },
        child: ElevatedButton(
          onPressed: onTap,
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
              vertical: 00.3.w,
            )),
          ),
          child: Container(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 33.8.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(1.w),
                          bottomLeft: Radius.circular(1.w),
                          bottomRight: Radius.circular(1.w),
                          topRight: Radius.circular(1.w),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: image ?? "assets/images/blank.png",
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
                        title ?? 'null',
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
      ),
    );
  }
}

class CardButtonWatchMovie extends StatefulWidget {
  const CardButtonWatchMovie({
    Key? key,
    required this.title,
    required this.onTap,
    this.isFocused = false,
  }) : super(key: key);
  final String title;
  final Function() onTap;
  final bool isFocused;

  @override
  State<CardButtonWatchMovie> createState() => _CardButtonWatchMovieState();
}

class _CardButtonWatchMovieState extends State<CardButtonWatchMovie> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        autofocus: widget.isFocused,
        borderRadius: BorderRadius.circular(5),
        onFocusChange: (bool value) {
          setState(() {
            isFocused = value;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
              colors: [kColorPrimary.withOpacity(.4), kColorPrimaryDark.withOpacity(.4)],
            )
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 2.5.w,
            vertical: 1.h,
          ),
          child: Center(
            child: Text(
              widget.title.toUpperCase(),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "Cairo"
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardInfoMovie extends StatelessWidget {
  const CardInfoMovie(
      {Key? key,
      required this.hint,
      required this.title,
      required this.icon,
      this.isShowMore = false})
      : super(key: key);
  final String hint;
  final String title;
  final IconData icon;
  final bool isShowMore;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                hint,
                style: TextStyle(
                  fontFamily: "Cairo",
                  fontSize: 15.sp,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(width: 0.5.w),
              Icon(
                icon,
                size: 15.sp,
              ),
            ],
          ),
          SizedBox(height: 0.5.h),
          !isShowMore
          ? Text(
              title,
              style: TextStyle(
                fontFamily: "Cairo",
                fontSize: 15.sp,
                color: Colors.white,
              ),
            )
          : ReadMoreText(
            textDirection: TextDirection.rtl,
            title,
            trimLines: 2,
            colorClickableText: kColorFocus,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'more',
            trimExpandedText: 'less',
            style: TextStyle(
              fontFamily: "Cairo",
              fontSize: 15.sp,
              color: Colors.white,
            ),
            moreStyle: Get.textTheme.headline5!.copyWith(
              color: yellowStar,
            ),
            lessStyle: Get.textTheme.headline5!.copyWith(
              color: yellowStar,
            ),
          ),
        ],
      ),
    );
  }
}

class CardMovieImageRate extends StatelessWidget {
  const CardMovieImageRate({Key? key, required this.image, required this.rate, this.onPressed, this.favColor, this.favText})
      : super(key: key);
  final String image;
  final String rate;
  final void Function()? onPressed;
  final Color? favColor;
  final String? favText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: image,
            width: 18.w,
            height: 55.h,
            fit: BoxFit.cover,
            errorWidget: (_, i, e) {
              return Container(
                color: Colors.grey,
              );
            },
          ),
        ),
        SizedBox(height: 3.h),
        RatingBarIndicator(
          rating: double.tryParse(rate.toString()) ?? 0,
          itemBuilder: (context, index) => const Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 18.sp,
          direction: Axis.horizontal,
        ),
        SizedBox(height: 5.h),
        Shortcuts(
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
          },
          child: Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            },
            child: ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.h),
                )),
                backgroundColor: MaterialStateProperty.all<Color>( bg2 ),
                overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                  states.contains(white38);
                },),
                elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
                  return 0;
                }),
                fixedSize: MaterialStateProperty.all<Size>(
                    Size(13.w, 5.h)
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    favText!,
                    style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 13.sp,
                        color: favColor
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CardMovieImagesBackground extends StatefulWidget {
  const CardMovieImagesBackground({Key? key, required this.listImages})
      : super(key: key);
  final List<dynamic> listImages;

  @override
  State<CardMovieImagesBackground> createState() =>
      _CardMovieImagesBackgroundState();
}

class _CardMovieImagesBackgroundState extends State<CardMovieImagesBackground> {
  late bool isNotEmpty;
  late int sizeList;
  int indexImage = 0;

  _runAnimation() async {
    await Future.delayed(const Duration(seconds: 5));

    if (mounted) {
      setState(() {
        if ((indexImage + 1) >= sizeList) {
          indexImage = 0;
        } else {
          indexImage = indexImage + 1;
        }
      });
      _runAnimation();
    }
  }

  @override
  void initState() {
    isNotEmpty = widget.listImages.isNotEmpty;

    if (isNotEmpty) {
      sizeList = widget.listImages.length;
      _runAnimation();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isNotEmpty) {
      return const SizedBox();
    }

    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(seconds: 3),
          switchInCurve: Curves.easeIn,
          child: CachedNetworkImage(
            width: 100.w,
            height: 100.h,
            fit: BoxFit.cover,
            imageUrl: widget.listImages[indexImage],
            errorWidget: (_, i, e) {
              return const SizedBox();
            },
          ),
        ),
        Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              end: Alignment.topCenter,
              begin: Alignment.bottomCenter,
              colors: [
                blackSendStar,
                kColorBack.withOpacity(.5),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CardEpisodeItem extends StatelessWidget {
  const CardEpisodeItem(
      {Key? key,
        required this.episode,
        required this.isSelected,
        required this.onTap,
        required this.index,
        this.image
      }) : super(key: key);
  
  final Episode? episode;
  final bool isSelected;
  final int index;
  final Function() onTap;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
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
          top: BorderSide(
              width: 0.04.w,
              color: yellowStar
          ),
        ),
        color: Colors.transparent,
      ),
      padding: EdgeInsets.all(2.h),
      // color: isSelected ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.9) ,
      margin: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Shortcuts(
                            shortcuts: <LogicalKeySet, Intent>{
                              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                            },
                            child: ElevatedButton(
                              onPressed: onTap,
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>( bg2 ),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.circlePlay,
                                    color: appTextColorPrimary,
                                    size: 15.sp,
                                  ),
                                  SizedBox(width: 1.w),
                                  Text(
                                    "تشغيل الحلقة",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: appTextColorPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Cairo'
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            episode!.info!.name ?? " الحلقة $index",
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Row(
                            children: [
                              Text(
                                getDurationMovie(episode!.info!.duration),
                                maxLines: 3,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                    fontFamily: "Cairo"
                                ),
                              ),
                              SizedBox(width: 0.5.w),
                              Icon(
                                FontAwesomeIcons.clock,
                                color: Colors.white,
                                size: 13.sp,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 2.w),
            ClipRRect(
              borderRadius: BorderRadius.circular(2.w),
              child: CachedNetworkImage(
                width: isSelected ? 13.w : 12.w,
                height: isSelected ? 21.h : 20.h,
                imageUrl: episode!.info!.movieImage == 'null' ? image! : episode!.info!.movieImage!,
                fit: BoxFit.cover,
                placeholder: (_, i) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorWidget: (_, i, e) {
                  return Container(
                    decoration: BoxDecoration(
                      color: black38,
                    ),
                    child: const Center(
                      child: Icon(
                        FontAwesomeIcons.image,
                        color: white54,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
  }
}

class CardSeasonItem extends StatelessWidget {
  const CardSeasonItem({
    Key? key,
    required this.number,
    required this.isSelected,
    required this.onFocused,
    required this.onTap,
  }) : super(key: key);
  final String number;
  final bool isSelected;
  final Function(bool) onFocused;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onFocusChange: onFocused,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          children: [
            Container(
              width: 0.3.w,
              height: 9.h,
              decoration: BoxDecoration(
                color: isSelected ? yellowStar : Colors.transparent,
                borderRadius: BorderRadius.circular(5.w),
              ),
            ),
            SizedBox(width: isSelected ? 2.w : 1.w),
            Text(
              '$number موسم ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontFamily: "Cairo",
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}
