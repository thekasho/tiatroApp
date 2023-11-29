part of '../screens.dart';

class ChewiePlayer extends StatefulWidget {
  const ChewiePlayer({Key? key, required this.link}) : super(key: key);
  final String link;

  @override
  State<ChewiePlayer> createState() => _ChewiePlayerState();
}

class _ChewiePlayerState extends State<ChewiePlayer> {

  late VideoPlayerController videoPlayerController;
  late ChewieController _chewieController;
  
  bool isPlayed = true;
  bool progress = true;

  bool _onKey(KeyEvent event) {
    
    // up     458834
    // down   458833
    // left   458832
    // right  458831
    // ok     73014444264
    // back   73014444190
    
    if (event.physicalKey.usbHidUsage == 73014444264){
      
        if(videoPlayerController.value.isPlaying) {
            isPlayed = false;
        } else {
          videoPlayerController.play();
        }
        
    }
    return false;
  }
  
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.link))
      ..initialize().then((value) => setState(() {
        videoPlayerController.play();
      }));
    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      fullScreenByDefault: true,
      autoInitialize: true,
      allowFullScreen: false,
      aspectRatio: 16/9,
      showControls: false,
      // additionalOptions: (context) {
      //   return [
      //     OptionItem(
      //       onTap: () => debugPrint('My option works!'),
      //       iconData: Icons.chat,
      //       title: 'My localized title',
      //     ),
      //   ];
      // }
    );
    // videoPlayerController.addListener(listener);
    ServicesBinding.instance.keyboard.addHandler(_onKey);
  }

  // void listener() async {
  //   if (!mounted) return;
  //
  //   if (progress) {
  //     if (videoPlayerController.value.isPlaying) {
  //       setState(() {
  //         progress = false;
  //       });
  //     }
  //   }
  // }

  @override
  void dispose() {
    videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            color: Colors.black,
            child: Chewie(
              controller: _chewieController,
            ),
          ),
          if (progress)
            const Center(
                child: CircularProgressIndicator(
                  color: yellowStar,
                )),
        ],
      ),
    );
  }
}
