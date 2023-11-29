import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:tiatrotv/repository/api/api.dart';
import 'binding/initial_binding.dart';
import 'helpers/helpers.dart';
import 'logic/cubits/settings/settings_cubit.dart';
import 'logic/cubits/video/video_cubit.dart';
import 'presentation/screens/screens.dart';

void main() async {
  await GetStorage.init();
  // MobileAds.instance.initialize();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MyApp(
    iptv: IpTvApi(),
  ));
}

class MyApp extends StatefulWidget {
  final IpTvApi iptv;
  const MyApp({super.key, required this.iptv});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VideoCubit>(
          create: (BuildContext context) => VideoCubit(),
        ),
        BlocProvider<SettingsCubit>(
          create: (BuildContext context) => SettingsCubit(),
        ),
      ],
      child: ResponsiveSizer(
        builder: (context, orient, type) {
          return Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            },
            child: GetMaterialApp(
              title: kAppName,
              theme: MyThemApp.themeData(context),
              debugShowCheckedModeBanner: false,
              initialBinding: InitialBinding(),
              initialRoute: "/",
              getPages: [
                GetPage(name: screenLogin, page: () => const LoginScreen()),
                GetPage(name: screenLanding, page: () => const LandingScreen()),
                GetPage(name: screenHome, page: () => const HomeScreen()),
                GetPage(
                    name: screenSettings, page: () => const SettingsScreen()),
              ],
            ),
          );
        },
      ),
    );
  }
}
