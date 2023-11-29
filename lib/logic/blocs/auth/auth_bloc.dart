import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;

import 'package:tiatrotv/repository/api/api.dart';
import 'package:tiatrotv/repository/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApi authApi;

  AuthBloc(this.authApi) : super(AuthInitial()) {
    on<AuthRegister>((event, emit) async {
      emit(AuthLoading());

      final user = await authApi.registerUser(
        event.username,
        event.password,
        event.domain,
        "test",
        event.mac,
        event.id
      );

      final Map userInfo = {
        "user_mac": event.mac,
        "user_id": event.id
      };

      if (user != null) {
        changeDeviceOrient();
        await Future.delayed(const Duration(seconds: 1));
        emit(AuthSuccess(user, userInfo));
      } else {
        emit(AuthFailed("could not login!!"));
      }
    });

    on<AuthGetUser>((event, emit) async {
      emit(AuthLoading());

      final localeUser = await LocaleApi.getUser();
      

      if (localeUser != null) {
        changeDeviceOrient();
        
      } else {
        emit(AuthFailed("could not login!!s"));
      }
    });

    on<AuthLogOut>((event, emit) async {
      await LocaleApi.logOut();
      changeDeviceOrientBack();
      emit(AuthFailed("LogOut"));
    });
  }

  void changeDeviceOrient() {
    //change portrait mobile
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void changeDeviceOrientBack() {
    //change portrait mobile
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }
}
