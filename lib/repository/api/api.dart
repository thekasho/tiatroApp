import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get_storage/get_storage.dart';

import 'package:tiatrotv/repository/models/channel_movie.dart';

import '../models/category.dart';
import '../models/channelLive.dart';
import '../models/channel_serie.dart';
import '../models/favourite.dart';
import '../models/login.dart';
import '../models/movie_detail.dart';
import '../models/serie_details.dart';
import '../models/user.dart';

part '../locale/locale.dart';
part 'auth.dart';
part 'iptv.dart';

final _dio = Dio();
final locale = GetStorage();
