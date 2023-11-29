import 'dart:ui';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

import 'package:tiatrotv/core/class/statusrequest.dart';

import '../../cont/accounts/account_cont.dart';
import '../../cont/categories/cats_cont.dart';
import '../../cont/home/home_cont.dart';
import '../../cont/landing/landing_cont.dart';
import '../../cont/live/live_cats_cont.dart';
import '../../cont/live/live_channels_cont.dart';
import '../../cont/auth/login_cont.dart';
import '../../cont/movies/movie_cats_cont.dart';
import '../../cont/movies/movie_channel_cont.dart';
import '../../cont/movies/movie_details_cont.dart';
import '../../cont/series/series_cats_cont.dart';
import '../../cont/series/series_channel_cont.dart';
import '../../cont/series/series_details_cont.dart';
import '../../core/class/handling_data.dart';
import '../../helpers/helpers.dart';
import '../../logic/blocs/auth/auth_bloc.dart';
import '../../logic/cubits/video/video_cubit.dart';
import '../../repository/models/movie_detail.dart';
import '../../repository/models/serie_details.dart';
import '../widgets/setting_info_block.dart';
import '../widgets/widgets.dart';

part 'player/full_video.dart';
part 'player/player_video.dart';
part 'user/settings.dart';
part 'auth/login.dart';
part 'landing/landing.dart';
part 'home/home.dart';
part 'cats/cats.dart';
part 'movies/movie_details.dart';
part 'serieses/series_details.dart';
part 'serieses/series_sessons.dart';
part 'accounts/accounts.dart';
part 'player/appino_player.dart';
part 'player/chewie_player.dart';
part 'player/mini_player.dart';