import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

part 'settings_state.dart';

const platform = MethodChannel('main_activity_channel');

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState("null"));

  void getSettingsCode() async {
    try {
      String data = await platform.invokeMethod('getData');

      debugPrint("DATA: $data");

      emit(SettingsState(data));
    } catch (e) {
      debugPrint("Error: $e");
    }
  }
}
