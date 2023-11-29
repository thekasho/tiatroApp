part of '../screens.dart';

class SeriesDetails extends StatefulWidget {
  const SeriesDetails({Key? key, required this.videoId}) : super(key: key);
  final dynamic videoId;

  @override
  State<SeriesDetails> createState() => _SeriesDetailsState();
}

class _SeriesDetailsState extends State<SeriesDetails> {
  late Future<SerieDetails?> future;

  SeriesDetailsControllerImp seriesDetailsControllerImp = Get.put(SeriesDetailsControllerImp());
  SeriesCatsControllerImp seriesCatsControllerImp = Get.put(SeriesCatsControllerImp());

  Future<void> getSeriesDetails() async {
    await seriesDetailsControllerImp.getSeriesDetails(widget.videoId);
  }

  @override
  void initState() {
    getSeriesDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeriesDetailsControllerImp>(builder: (seriesDetailsController) {
      if(seriesDetailsController.statusRequest == StatusRequest.success){
        return Scaffold(
          body: Stack(
            children: [
              CardMovieImagesBackground(
                listImages: seriesDetailsController.serieDetails.info!.backdropPath ?? [],
              ),
              const AppBarMovies(),
              Padding(
                padding: EdgeInsets.only(
                  top: 12.h,
                  left: 3.w,
                  right: 2.w,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  seriesDetailsController.serieDetails.info!.name ?? "",
                                  style: TextStyle(
                                      fontFamily: "Cairo",
                                      color: kColorFontLight,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3.h),
                            Wrap(
                              textDirection: TextDirection.rtl,
                              children: [
                                CardInfoMovie(
                                  icon: FontAwesomeIcons.calendarDay,
                                  hint: 'تاريخ الانتاج',
                                  title: expirationDate(seriesDetailsController.serieDetails.info!.releaseDate).toString() ?? "",
                                ),
                                CardInfoMovie(
                                  icon: FontAwesomeIcons.clock,
                                  hint: 'المخرج',
                                  title: seriesDetailsController.serieDetails.info!.director ?? "",
                                ),
                                CardInfoMovie(
                                  icon: FontAwesomeIcons.users,
                                  hint: 'فريق العمل',
                                  isShowMore: true,
                                  title: seriesDetailsController.serieDetails.info!.cast ?? "",
                                ),
                                CardInfoMovie(
                                  icon: FontAwesomeIcons.users,
                                  hint: 'التصنيف',
                                  isShowMore: true,
                                  title: seriesDetailsController.serieDetails.info!.genre ?? "",
                                ),
                              ],
                            ),
                            SizedBox(height: 3.h),
                            CardInfoMovie(
                              icon: FontAwesomeIcons.film,
                              hint: 'التصنيف',
                              title: seriesDetailsController.serieDetails.info!.genre ?? "",
                            ),
                            SizedBox(height: 3.h),
                            CardInfoMovie(
                              icon: FontAwesomeIcons
                                  .solidClosedCaptioning,
                              hint: 'القصة',
                              title: seriesDetailsController.serieDetails.info!.plot ?? "",
                              isShowMore: true,
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                Shortcuts(
                                  shortcuts: <LogicalKeySet, Intent>{
                                    LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                                  },
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      Get.to(
                                        SeriesSessons(serieDetails: seriesDetailsController.serieDetails),
                                        transition: Transition.rightToLeftWithFade,
                                        duration: const Duration(milliseconds: 800),
                                      );
                                    },
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
                                        Text(
                                          "عرض الحقات",
                                          style: TextStyle(
                                              fontSize: 15.sp,
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
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    CardMovieImageRate(
                      image: seriesDetailsController.serieDetails.info!.cover ?? "",
                      rate: seriesDetailsController.serieDetails.info!.rating == "0" ? "1" : seriesDetailsController.serieDetails.info!.rating.toString(),
                      favColor: seriesDetailsController.favOn == true ? red : Colors.white,
                      favText: seriesDetailsController.favOn == true ? "ازالة المفضلة" : "اضافة المفضلة",
                      onPressed: () async {
                        seriesDetailsController.addFav(widget.videoId);
                        seriesDetailsController.favOn == true ? seriesDetailsController.favOn = false : seriesDetailsController.favOn = true;
                        seriesDetailsController.update();
                      }
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
      else {
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
    });
  }
}

