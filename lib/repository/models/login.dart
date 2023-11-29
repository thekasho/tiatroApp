class LoginModel {
  String? username;
  String? password;
  String? domain;
  String? port;

  LoginModel({
    this.username,
    this.password,
    this.domain,
    this.port,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    domain = json['domain'];
    port = json['port'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['domain'] = domain;
    data['port'] = port;
    return data;
  }


}
