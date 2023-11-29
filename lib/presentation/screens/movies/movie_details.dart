part of '../screens.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({Key? key, required this.videoId}) : super(key: key);
  final dynamic videoId;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late Future<MovieDetail?> future;

  MoviesDetailsControllerImp moviesDetailsControllerImp = Get.put(MoviesDetailsControllerImp());
  MoviesCatsControllerImp moviesCatsControllerImp = Get.put(MoviesCatsControllerImp());
  
  Future<void> getMovieDetails() async {
    await moviesDetailsControllerImp.getMovieDetails(widget.videoId);
  }
  
  @override
  void initState() {
    getMovieDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoviesDetailsControllerImp>(builder: (moviesDetailsController) {
      if(moviesDetailsController.statusRequest == StatusRequest.success){
        return Scaffold(
          body: Stack(
          children: [
            CardMovieImagesBackground(
              listImages: moviesDetailsController.movieDetail.info!.backdropPath ?? [],
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
                                moviesDetailsController.movieDetail.movieData!.name ?? "",
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
                                title: expirationDate(moviesDetailsController.movieDetail.info!.releasedate).toString() ?? "",
                              ),
                              CardInfoMovie(
                                icon: FontAwesomeIcons.clock,
                                hint: 'المدة',
                                title: moviesDetailsController.movieDetail.info!.duration ?? "",
                              ),
                              CardInfoMovie(
                                icon: FontAwesomeIcons.clapperboard,
                                hint: 'المخرج',
                                title: moviesDetailsController.movieDetail.info!.director ?? "",
                              ),
                              CardInfoMovie(
                                icon: FontAwesomeIcons.users,
                                hint: 'فريق العمل',
                                isShowMore: true,
                                title: moviesDetailsController.movieDetail.info!.cast ?? "",
                              ),
                            ],
                          ),
                          SizedBox(height: 3.h),
                          CardInfoMovie(
                            icon: FontAwesomeIcons.film,
                            hint: 'التصنيف',
                            title: moviesDetailsController.movieDetail.info!.genre ?? "",
                          ),
                          SizedBox(height: 3.h),
                          CardInfoMovie(
                            icon: FontAwesomeIcons
                                .solidClosedCaptioning,
                            hint: 'القصة',
                            title: moviesDetailsController.movieDetail.info!.plot ?? "",
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
                                    final authLink = await moviesDetailsController.getAuthLink();
                                    final link = "$authLink${moviesDetailsController.movieDetail.movieData!.streamId}.${moviesDetailsController.movieDetail.movieData!.containerExtension}";
                                    Get.to( ()=>
                                      FullVideoScreen(link: link),
                                      transition: Transition.circularReveal,
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
                                        "مشاهدة الفيلم الان",
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
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  CardMovieImageRate(
                    image: moviesDetailsController.movieDetail.info!.movieImage ?? "",
                    rate: moviesDetailsController.movieDetail.info!.rating == "0" ? "1" : moviesDetailsController.movieDetail.info!.rating,
                    favColor: moviesDetailsControllerImp.favOn == true ? red : Colors.white,
                    favText: moviesDetailsControllerImp.favOn == true ? "ازالة المفضلة" : "اضافة المفضلة",
                    onPressed: () async {
                      moviesDetailsControllerImp.addFav(widget.videoId);
                      moviesDetailsControllerImp.favOn == true ? moviesDetailsControllerImp.favOn = false : moviesDetailsControllerImp.favOn = true;
                      moviesDetailsControllerImp.update();
                    }
                  ),
                ],
              ),
            ),
          ],
        ));
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

