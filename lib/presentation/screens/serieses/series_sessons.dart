part of '../screens.dart';

class SeriesSessons extends StatefulWidget {
  const SeriesSessons({Key? key, required this.serieDetails}) : super(key: key);
  final SerieDetails serieDetails;

  @override
  State<SeriesSessons> createState() => _SeriesSessonsState();
}

class _SeriesSessonsState extends State<SeriesSessons> {
  late SerieDetails serieDetails;

  SeriesDetailsControllerImp seriesDetailsControllerImp = Get.put(
      SeriesDetailsControllerImp());
  SeriesCatsControllerImp seriesCatsControllerImp = Get.put(
      SeriesCatsControllerImp());

  int selectedSeason = 0;
  int selectedEpisode = 0;

  @override
  void initState() {
    serieDetails = widget.serieDetails;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    List<String> seasons = [];
    if (serieDetails.episodes != null && serieDetails.episodes!.isNotEmpty) {
      serieDetails.episodes!.forEach((k, v) {
        seasons.add(k);
      });
    }
    
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
                  left: 5.w,
                  right: 5.w,
                  ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 100.w,
                      width: 22.w,
                      child: Center(
                        child: ListView.builder(
                          itemCount: seasons.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (_, i) {
                            return CardSeasonItem(
                              isSelected: i == selectedSeason,
                              number: seasons[i],
                              onTap: () {
                                setState(() {
                                  selectedSeason = i;
                                });
                              },
                              onFocused: (val) {
                                setState(() {
                                  selectedSeason = i;
                                });
                              },
                            );
                          }
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: seriesDetailsController.serieDetails.episodes!["${selectedSeason + 1}"]!.length - 1,
                        itemBuilder: (_, i) {
                          if(seriesDetailsController.serieDetails.episodes!["${selectedSeason + 1}"]![i]!.id != null) {
                            final model = seriesDetailsController.serieDetails.episodes!["${selectedSeason + 1}"]![i];
                            return CardEpisodeItem(
                              isSelected: selectedEpisode == i,
                              index: i + 1,
                              image: seriesDetailsController.serieDetails.info!
                                  .cover ?? '',
                              episode: model,
                              onTap: () async {
                                final authLink = await seriesDetailsController
                                    .getAuthLink();
                                final link = "${authLink}${model!.id}.${model
                                    .containerExtension}";

                                Get.to(()=>
                                  FullVideoScreen(link: link),
                                  transition: Transition.circularReveal,
                                  duration: const Duration(milliseconds: 800),
                                );
                                setState(() {
                                  selectedEpisode = i;
                                });
                              },
                            );
                          }
                        }
                      ),
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
