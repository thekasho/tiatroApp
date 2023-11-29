class MovieDetail {
  final Info? info;
  final MovieData? movieData;

  MovieDetail({
    this.info,
    this.movieData,
  });

  MovieDetail.fromJson(Map<dynamic, dynamic> json)
      : info = (json['info'] as Map<dynamic, dynamic>?) != null
            ? Info.fromJson(json['info'] as Map<dynamic, dynamic>)
            : null,
        movieData = (json['movie_data'] as Map<dynamic, dynamic>?) != null
            ? MovieData.fromJson(json['movie_data'] as Map<dynamic, dynamic>)
            : null;
  Map<dynamic, dynamic> toJson() =>
      {'info': info?.toJson(), 'movie_data': movieData?.toJson()};
}

class Info {
  final dynamic movieImage;
  final dynamic tmdbId;
  final dynamic backdrop;
  final dynamic youtubeTrailer;
  final dynamic genre;
  final dynamic plot;
  final dynamic cast;
  final dynamic rating;
  final dynamic director;
  final dynamic releasedate;
  final List<dynamic>? backdropPath;
  final dynamic durationSecs;
  final dynamic duration;
  final Video? video;

  final dynamic bitrate;

  Info({
    this.movieImage,
    this.tmdbId,
    this.backdrop,
    this.youtubeTrailer,
    this.genre,
    this.plot,
    this.cast,
    this.rating,
    this.director,
    this.releasedate,
    this.backdropPath,
    this.durationSecs,
    this.duration,
    this.video,
    this.bitrate,
  });

  Info.fromJson(Map<dynamic, dynamic> json)
      : movieImage = json['movie_image'].toString(),
        tmdbId = json['tmdb_id'].toString(),
        backdrop = json['backdrop'].toString(),
        youtubeTrailer = json['youtube_trailer'].toString(),
        genre = json['genre'].toString(),
        plot = json['plot'].toString(),
        cast = json['cast'].toString(),
        rating = json['rating'].toString(),
        director = json['director'].toString(),
        releasedate = json['release_date'].toString(),
        backdropPath = json['backdrop_path'] == null
            ? []
            : (json['backdrop_path'] as List?)
                ?.map((dynamic e) => e.toString())
                .toList(),
        durationSecs = json['duration_secs'].toString(),
        duration = json['duration'].toString(),
        video = json['video'].runtimeType == List
            ? null
            : (json['video'] as Map<dynamic, dynamic>?) != null
                ? Video.fromJson(json['video'] as Map<dynamic, dynamic>)
                : null,
        bitrate = json['bitrate'].toString();

  Map<dynamic, dynamic> toJson() => {
        'movie_image': movieImage,
        'tmdb_id': tmdbId,
        'backdrop': backdrop,
        'youtube_trailer': youtubeTrailer,
        'genre': genre,
        'plot': plot,
        'cast': cast,
        'rating': rating,
        'director': director,
        'releasedate': releasedate,
        'backdrop_path': backdropPath,
        'duration_secs': durationSecs,
        'duration': duration,
        'video': video?.toJson(),
        'bitrate': bitrate
      };
}

class Video {
  final dynamic index;
  final dynamic codecName;
  final dynamic codecLongName;
  final dynamic profile;
  final dynamic codecType;
  final dynamic codecTimeBase;
  final dynamic codecTagString;
  final dynamic codecTag;
  final dynamic width;
  final dynamic height;
  final dynamic codedWidth;
  final dynamic codedHeight;
  final dynamic hasBFrames;
  final dynamic sampleAspectRatio;
  final dynamic displayAspectRatio;
  final dynamic pixFmt;
  final dynamic level;
  final dynamic colorRange;
  final dynamic colorSpace;
  final dynamic colorTransfer;
  final dynamic colorPrimaries;
  final dynamic chromaLocation;
  final dynamic refs;
  final dynamic isAvc;
  final dynamic nalLengthSize;
  final dynamic rFrameRate;
  final dynamic avgFrameRate;
  final dynamic timeBase;
  final dynamic startPts;
  final dynamic startTime;
  final dynamic durationTs;
  final dynamic duration;
  final dynamic bitRate;
  final dynamic bitsPerRawSample;
  final dynamic nbFrames;

  final Tags? tags;

  Video({
    this.index,
    this.codecName,
    this.codecLongName,
    this.profile,
    this.codecType,
    this.codecTimeBase,
    this.codecTagString,
    this.codecTag,
    this.width,
    this.height,
    this.codedWidth,
    this.codedHeight,
    this.hasBFrames,
    this.sampleAspectRatio,
    this.displayAspectRatio,
    this.pixFmt,
    this.level,
    this.colorRange,
    this.colorSpace,
    this.colorTransfer,
    this.colorPrimaries,
    this.chromaLocation,
    this.refs,
    this.isAvc,
    this.nalLengthSize,
    this.rFrameRate,
    this.avgFrameRate,
    this.timeBase,
    this.startPts,
    this.startTime,
    this.durationTs,
    this.duration,
    this.bitRate,
    this.bitsPerRawSample,
    this.nbFrames,
    this.tags,
  });

  Video.fromJson(Map<dynamic, dynamic> json)
      : index = json['index'].toString(),
        codecName = json['codec_name'].toString(),
        codecLongName = json['codec_long_name'].toString(),
        profile = json['profile'].toString(),
        codecType = json['codec_type'].toString(),
        codecTimeBase = json['codec_time_base'].toString(),
        codecTagString = json['codec_tag_string'].toString(),
        codecTag = json['codec_tag'].toString(),
        width = json['width'].toString(),
        height = json['height'].toString(),
        codedWidth = json['coded_width'].toString(),
        codedHeight = json['coded_height'].toString(),
        hasBFrames = json['has_b_frames'].toString(),
        sampleAspectRatio = json['sample_aspect_ratio'].toString(),
        displayAspectRatio = json['display_aspect_ratio'].toString(),
        pixFmt = json['pix_fmt'].toString(),
        level = json['level'].toString(),
        colorRange = json['color_range'].toString(),
        colorSpace = json['color_space'].toString(),
        colorTransfer = json['color_transfer'].toString(),
        colorPrimaries = json['color_primaries'].toString(),
        chromaLocation = json['chroma_location'].toString(),
        refs = json['refs'].toString(),
        isAvc = json['is_avc'].toString(),
        nalLengthSize = json['nal_length_size'].toString(),
        rFrameRate = json['r_frame_rate'].toString(),
        avgFrameRate = json['avg_frame_rate'].toString(),
        timeBase = json['time_base'].toString(),
        startPts = json['start_pts'].toString(),
        startTime = json['start_time'].toString(),
        durationTs = json['duration_ts'].toString(),
        duration = json['duration'].toString(),
        bitRate = json['bit_rate'].toString(),
        bitsPerRawSample = json['bits_per_raw_sample'].toString(),
        nbFrames = json['nb_frames'].toString(),
        tags = json['tags'] == null
            ? null
            : (json['tags'] as Map<dynamic, dynamic>?) != null
                ? Tags.fromJson(json['tags'] as Map<dynamic, dynamic>)
                : null;

  Map<dynamic, dynamic> toJson() => {
        'index': index,
        'codec_name': codecName,
        'codec_long_name': codecLongName,
        'profile': profile,
        'codec_type': codecType,
        'codec_time_base': codecTimeBase,
        'codec_tag_string': codecTagString,
        'codec_tag': codecTag,
        'width': width,
        'height': height,
        'coded_width': codedWidth,
        'coded_height': codedHeight,
        'has_b_frames': hasBFrames,
        'sample_aspect_ratio': sampleAspectRatio,
        'display_aspect_ratio': displayAspectRatio,
        'pix_fmt': pixFmt,
        'level': level,
        'color_range': colorRange,
        'color_space': colorSpace,
        'color_transfer': colorTransfer,
        'color_primaries': colorPrimaries,
        'chroma_location': chromaLocation,
        'refs': refs,
        'is_avc': isAvc,
        'nal_length_size': nalLengthSize,
        'r_frame_rate': rFrameRate,
        'avg_frame_rate': avgFrameRate,
        'time_base': timeBase,
        'start_pts': startPts,
        'start_time': startTime,
        'duration_ts': durationTs,
        'duration': duration,
        'bit_rate': bitRate,
        'bits_per_raw_sample': bitsPerRawSample,
        'nb_frames': nbFrames,
        'tags': tags?.toJson()
      };
}

class Tags {
  final dynamic language;
  final dynamic handlerName;

  Tags({
    this.language,
    this.handlerName,
  });

  Tags.fromJson(Map<dynamic, dynamic> json)
      : language = json['language'].toString(),
        handlerName = json['handler_name'].toString();

  Map<dynamic, dynamic> toJson() =>
      {'language': language, 'handler_name': handlerName};
}

class MovieData {
  final dynamic streamId;
  final dynamic name;
  final dynamic added;
  final dynamic categoryId;
  final dynamic containerExtension;
  final dynamic customSid;
  final dynamic directSource;

  MovieData({
    this.streamId,
    this.name,
    this.added,
    this.categoryId,
    this.containerExtension,
    this.customSid,
    this.directSource,
  });

  MovieData.fromJson(Map<dynamic, dynamic> json)
      : streamId = json['stream_id'].toString(),
        name = json['name'].toString(),
        added = json['added'].toString(),
        categoryId = json['category_id'].toString(),
        containerExtension = json['container_extension'].toString(),
        customSid = json['custom_sid'].toString(),
        directSource = json['direct_source'].toString();

  Map<dynamic, dynamic> toJson() => {
        'stream_id': streamId,
        'name': name,
        'added': added,
        'category_id': categoryId,
        'container_extension': containerExtension,
        'custom_sid': customSid,
        'direct_source': directSource
      };
}
