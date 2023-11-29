import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';
import 'package:readmore/readmore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../helpers/helpers.dart';
import '../../logic/blocs/auth/auth_bloc.dart';
import '../../logic/cubits/video/video_cubit.dart';
import '../../repository/models/serie_details.dart';

part 'appBars/catsAppBar.dart';
part 'cats/menuItem.dart';

part 'dialog.dart';
part 'live.dart';
part 'movie.dart';
part 'auth/login.dart';
part 'home/appbar.dart';
part 'home/sidebar.dart';
part 'home/home.dart';
part 'appBars/moviesAppBar.dart';
part 'accounts/appBar.dart';
part 'accounts/form.dart';