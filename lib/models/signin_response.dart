class SignInResponse {
  bool? message;
  String? token;
  User? user;

  SignInResponse({this.message, this.token, this.user});

  SignInResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? gender;
  String? dob;
  String? contact;
  String? email;
  String? password;
  String? resetToken;
  String? expires;
  int? iV;

  User({
    this.sId,
    this.firstName,
    this.lastName,
    this.gender,
    this.dob,
    this.contact,
    this.email,
    this.password,
    this.resetToken,
    this.expires,
    this.iV,
  });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    dob = json['dob'];
    contact = json['contact'];
    email = json['email'];
    password = json['password'];
    resetToken = json['resetToken'];
    expires = json['expires'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['dob'] = dob;
    data['contact'] = contact;
    data['email'] = email;
    data['password'] = password;
    data['resetToken'] = resetToken;
    data['expires'] = expires;
    data['__v'] = iV;
    return data;
  }
}
