class UserModel {
  final UserInfo? userInfo;
  final ServerInfo? serverInfo;

  UserModel({
    this.userInfo,
    this.serverInfo,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : userInfo = (json['user_info'] as Map<String, dynamic>?) != null
      ? UserInfo.fromJson(json['user_info'] as Map<String, dynamic>)
      : null,
      serverInfo = (json['server_info'] as Map<String, dynamic>?) != null
      ? ServerInfo.fromJson(json['server_info'] as Map<String, dynamic>)
      : null;
  Map<String, dynamic> toJson() =>
      {'user_info': userInfo?.toJson(), 'server_info': serverInfo?.toJson()};
}

class UserInfo {
  final String? username;
  final String? password;
  final String? message;
  final int? auth;
  final String? status;
  final String? expDate;
  final String? isTrial;
  final dynamic activeCons;
  final String? createdAt;
  final String? maxConnections;
  final List<String>? allowedOutputFormats;

  UserInfo({
    this.username,
    this.password,
    this.message,
    this.auth,
    this.status,
    this.expDate,
    this.isTrial,
    this.activeCons,
    this.createdAt,
    this.maxConnections,
    this.allowedOutputFormats,
  });

  UserInfo.fromJson(Map<String, dynamic> json)
      : username = json['username'] as String?,
        password = json['password'] as String?,
        message = json['message'] as String?,
        auth = json['auth'] as int?,
        status = json['status'] as String?,
        expDate = json['exp_date'] as String?,
        isTrial = json['is_trial'] as String?,
        activeCons = json['active_cons'],
        createdAt = json['created_at'] as String?,
        maxConnections = json['max_connections'] as String?,
        allowedOutputFormats = (json['allowed_output_formats'] as List?)
            ?.map((dynamic e) => e as String)
            .toList();

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'message': message,
        'auth': auth,
        'status': status,
        'exp_date': expDate,
        'is_trial': isTrial,
        'active_cons': activeCons,
        'created_at': createdAt,
        'max_connections': maxConnections,
        'allowed_output_formats': allowedOutputFormats
      };
}

class ServerInfo {
  final String? url;
  final String? port;
  final String? httpsPort;
  final String? serverProtocol;
  final String? rtmpPort;
  final String? timezone;
  final int? timestampNow;
  final String? timeNow;
  final bool? process;
  final String? serverUrl;

  ServerInfo({
    this.serverUrl,
    this.url,
    this.port,
    this.httpsPort,
    this.serverProtocol,
    this.rtmpPort,
    this.timezone,
    this.timestampNow,
    this.timeNow,
    this.process,
  });

  ServerInfo.fromJson(Map<String, dynamic> json)
      : url = json['url'] as String?,
        port = json['port'] as String?,
        httpsPort = json['https_port'] as String?,
        serverProtocol = json['server_protocol'] as String?,
        rtmpPort = json['rtmp_port'] as String?,
        timezone = json['timezone'] as String?,
        timestampNow = json['timestamp_now'] as int?,
        timeNow = json['time_now'] as String?,
        process = json['process'] as bool?,
        serverUrl = json['server_url'] ??
            "${json['server_protocol']}://${json['url']}:${json['port']}";

  Map<String, dynamic> toJson() => {
        'url': url,
        'port': port,
        'https_port': httpsPort,
        'server_protocol': serverProtocol,
        'rtmp_port': rtmpPort,
        'timezone': timezone,
        'timestamp_now': timestampNow,
        'time_now': timeNow,
        'process': process,
        'server_url': serverUrl
      };
}
