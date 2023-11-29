class ChannelMovie {
  final dynamic num;
  final dynamic name;
  final dynamic streamType;
  final dynamic streamId;
  final dynamic streamIcon;
  final dynamic rating;
  final dynamic rating5based;
  final dynamic added;
  final dynamic isAdult;
  final dynamic categoryId;
  final dynamic containerExtension;
  final dynamic customSid;
  final dynamic directSource;

  ChannelMovie({
    this.num,
    this.name,
    this.streamType,
    this.streamId,
    this.streamIcon,
    this.rating,
    this.rating5based,
    this.added,
    this.isAdult,
    this.categoryId,
    this.containerExtension,
    this.customSid,
    this.directSource,
  });

  ChannelMovie.fromJson(Map<String, dynamic> json)
      : num = json['num'] == null ? null : json['num'],
        name = json['name'],
        streamType = json['stream_type'],
        streamId =
            json['stream_id'] == null ? null : json['stream_id'],
        streamIcon = json['stream_icon'],
        rating = json['rating'],
        rating5based = json['rating_5based'] == null
            ? null
            : json['rating_5based'],
        added = json['added'],
        isAdult = json['is_adult'],
        categoryId = json['category_id'],
        containerExtension = json['container_extension'],
        customSid = json['custom_sid'],
        directSource = json['direct_source'];

  Map<String, dynamic> toJson() => {
        'num': num,
        'name': name,
        'stream_type': streamType,
        'stream_id': streamId,
        'stream_icon': streamIcon,
        'rating': rating,
        'rating_5based': rating5based,
        'added': added,
        'is_adult': isAdult,
        'category_id': categoryId,
        'container_extension': containerExtension,
        'custom_sid': customSid,
        'direct_source': directSource
      };
}
