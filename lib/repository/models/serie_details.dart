class SerieDetails {
  final List<Season>? seasons;
  final InfoSerie? info;
  final Map<String, List<Episode?>?>? episodes;

  SerieDetails({
    this.seasons,
    this.info,
    this.episodes,
  });

  SerieDetails.fromJson(Map<String, dynamic> json)
      : seasons = json['season'] == null
            ? []
            : (json['season'] as List?)
                ?.map((e) => Season.fromJson(e as Map<String, dynamic>))
                .toList(),
        info = (json['info'] as Map<String, dynamic>?) != null
            ? InfoSerie.fromJson(json['info'] as Map<String, dynamic>)
            : null,
        episodes = (json['episodes'] as Map<String, dynamic>).map((key, value) {
          // debugPrint("episode $key: ${value == null ? "isNull" : value.runtimeType}");
          return MapEntry(
              key,
              (value as List<dynamic>)
                  .map((dynamic e) =>
                      Episode.fromJson(e as Map<String, dynamic>))
                  .toList());
        });

  Map<String, dynamic> toJson() => {
        'seasons': seasons,
        'info': info?.toJson(),
        //'episodes': episodes?.toJson()
      };
}

class Season {
  final String? airDate;
  final String? episodeCount;
  final String? id;
  final String? name;
  final String? overview;
  final String? seasonNumber;
  final String? cover;
  final String? coverBig;

  Season({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.seasonNumber,
    this.cover,
    this.coverBig,
  });

  Season.fromJson(Map<String, dynamic> json)
      : airDate = json['air_date'].toString(),
        episodeCount = json['episode_count'].toString(),
        id = json['id'].toString(),
        name = json['name'].toString(),
        overview = json['overview'].toString(),
        seasonNumber = json['season_number'].toString(),
        cover = json['cover'].toString(),
        coverBig = json['cover_big'].toString();

  Map<String, dynamic> toJson() => {
        'air_date': airDate,
        'episode_count': episodeCount,
        'id': id,
        'name': name,
        'overview': overview,
        'season_number': seasonNumber,
        'cover': cover,
        'cover_big': coverBig
      };
}

class InfoSerie {
  final String? name;
  final String? cover;
  final String? plot;
  final String? cast;
  final String? director;
  final String? genre;
  final String? releaseDate;
  final String? lastModified;
  final String? rating;
  final String? rating5based;
  final List<String>? backdropPath;
  final String? youtubeTrailer;
  final String? episodeRunTime;
  final String? categoryId;

  InfoSerie({
    this.name,
    this.cover,
    this.plot,
    this.cast,
    this.director,
    this.genre,
    this.releaseDate,
    this.lastModified,
    this.rating,
    this.rating5based,
    this.backdropPath,
    this.youtubeTrailer,
    this.episodeRunTime,
    this.categoryId,
  });

  InfoSerie.fromJson(Map<String, dynamic> json)
      : name = json['name'].toString(),
        cover = json['cover'].toString(),
        plot = json['plot'].toString(),
        cast = json['cast'].toString(),
        director = json['director'].toString(),
        genre = json['genre'].toString(),
        releaseDate = json['releaseDate'].toString(),
        lastModified = json['last_modified'].toString(),
        rating = json['rating'].toString(),
        rating5based = json['rating_5based'].toString(),
        backdropPath = json['backdrop_path'] == null ||
                json['backdrop_path'].runtimeType == String
            ? []
            : (json['backdrop_path'] as List)
                .map((dynamic e) => e.toString())
                .toList(),
        youtubeTrailer = json['youtube_trailer'].toString(),
        episodeRunTime = json['episode_run_time'].toString(),
        categoryId = json['category_id'].toString();

  Map<String, dynamic> toJson() => {
        'name': name,
        'cover': cover,
        'plot': plot,
        'cast': cast,
        'director': director,
        'genre': genre,
        'releaseDate': releaseDate,
        'last_modified': lastModified,
        'rating': rating,
        'rating_5based': rating5based,
        'backdrop_path': backdropPath,
        'youtube_trailer': youtubeTrailer,
        'episode_run_time': episodeRunTime,
        'category_id': categoryId
      };
}

class Episode {
  final String? id;
  final String? episodeNum;
  final String? title;
  final String? containerExtension;
  final InfoEpisode? info;
  final String? customSid;
  final String? added;
  final String? season;
  final String? directSource;

  Episode({
    this.id,
    this.episodeNum,
    this.title,
    this.containerExtension,
    this.info,
    this.customSid,
    this.added,
    this.season,
    this.directSource,
  });

  Episode.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        episodeNum = json['episode_num'].toString(),
        title = json['title'] == null ? null : json['title'].toString(),
        containerExtension = json['container_extension'].toString(),
        info = json['info'] != null && json['info'].runtimeType == List
            ? null
            : (json['info'] as Map<String, dynamic>?) != null
                ? InfoEpisode.fromJson(json['info'] as Map<String, dynamic>)
                : null,
        customSid = json['custom_sid'].toString(),
        added = json['added'].toString(),
        season = json['season'].toString(),
        directSource = json['direct_source'].toString();

  Map<String, dynamic> toJson() => {
        'id': id,
        'episode_num': episodeNum,
        'title': title,
        'container_extension': containerExtension,
        'info': info?.toJson(),
        'custom_sid': customSid,
        'added': added,
        'season': season,
        'direct_source': directSource
      };
}

class InfoEpisode {
  final String? movieImage;
  final String? plot;
  final String? releasedate;
  final String? rating;
  final String? name;
  final String? durationSecs;
  final String? duration;

  final String? bitrate;

  InfoEpisode({
    this.movieImage,
    this.plot,
    this.releasedate,
    this.rating,
    this.name,
    this.durationSecs,
    this.duration,
    this.bitrate,
  });

  InfoEpisode.fromJson(Map<String, dynamic> json)
      : movieImage = json['movie_image'].toString(),
        plot = json['plot'] == null ? "" : json['plot'].toString(),
        releasedate = json['releasedate'].toString(),
        rating = json['rating'].toString(),
        name = json['name'] == null ? null : json['name'].toString(),
        durationSecs = json['duration_secs'].toString(),
        duration = json['duration'].toString(),
        bitrate = json['bitrate'].toString();

  Map<String, dynamic> toJson() => {
        'movie_image': movieImage,
        'plot': plot,
        'releasedate': releasedate,
        'rating': rating,
        'name': name,
        'duration_secs': durationSecs,
        'duration': duration,
        'bitrate': bitrate
      };
}
