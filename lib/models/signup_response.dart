class SignUpResponse {
  bool? message;
  String? token;
  String? user;
  String? success;

  SignUpResponse({this.message, this.token, this.user, this.success});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    data['user'] = this.user;
    data['success'] = this.success;
    return data;
  }
}
