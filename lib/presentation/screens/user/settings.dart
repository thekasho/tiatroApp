part of '../screens.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Ink(
        width: 100.w,
        height: 100.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bck.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.only(left: 10, right: 10, top: 1.h, bottom: 1.h),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {

              final userInfo = state.user;
              final reg_info = state.userInfo;

              return Column(
                children: [
                  const AppBarSettings(),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              SettingInfoBlock(
                                rowCount: 2,
                                identifierContent: [
                                  {
                                    "icon":Icon(Icons.access_time, size: 20.sp),
                                    "title": "Start:   ${dateNowWelcome()}"
                                  },
                                  {
                                    "icon":Icon(Icons.timelapse, size: 20.sp),
                                    "title": "Expir:   ${expirationDate(userInfo.userInfo!.expDate)}"
                                  },
                                ]
                              ),
                              SizedBox(height: 5.h),
                              SettingInfoBlock(
                                rowCount: 3,
                                identifierContent: [
                                  {
                                    "icon":Icon(Icons.portrait, size: 20.sp),
                                    "title": "USER: ${userInfo.userInfo!.username}"
                                  },
                                  {
                                    "icon":Icon(Icons.lock_outline, size: 20.sp),
                                    "title": "Password: ${userInfo.userInfo!.username}"},
                                  {"icon":Icon(Icons.link, size: 20.sp), "title": "URL: ${userInfo.serverInfo!.serverUrl}"},
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              SettingInfoBlock(rowCount: 2, identifierContent: [
                                {"icon":Icon(Icons.perm_device_information, size: 20.sp), "title": "MacAddress: ${reg_info['user_mac']}"},
                                {"icon":Icon(Icons.perm_device_information, size: 20.sp), "title": "User ID:           ${reg_info['user_id']}"},
                              ],),
                              SizedBox(height: 5.h),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 45.w,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 1.h,
                                    horizontal: 3.w,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SettingButtons(
                                        onTap: () {
                                          context.read<AuthBloc>().add(AuthLogOut());
                                          Get.offAllNamed(screenRegister);
                                        },
                                        buttonTitle: "Add New Playlist",
                                        buttonIcon: Icons.add_box,
                                      ),
                                      SettingButtons(
                                        onTap: () {
                                          context.read<AuthBloc>().add(AuthLogOut());
                                          Get.offAllNamed("/");
                                        },
                                        buttonTitle: "Log Out",
                                        buttonIcon: Icons.exit_to_app,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 7.h),
                  // const SettingBottomCreator(),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

/*


 */