part of '../screens.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(LandingControllerImp());
    return GetBuilder<LandingControllerImp>(builder: (controller) {
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
    });
  }
}
