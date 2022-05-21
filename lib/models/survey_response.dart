class SurveyResponse {
  bool? message;
  Survey? survey;

  SurveyResponse({this.message, this.survey});

  SurveyResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    survey = json['survey'] != null ? Survey.fromJson(json['survey']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (survey != null) {
      data['survey'] = survey!.toJson();
    }
    return data;
  }
}

class Survey {
  String? sId;
  String? name;
  String? address;
  String? city;
  String? description;
  String? image;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Survey(
      {this.sId,
      this.name,
      this.address,
      this.city,
      this.description,
      this.image,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Survey.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    description = json['description'];
    image = json['image'];
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['address'] = address;
    data['city'] = city;
    data['description'] = description;
    data['image'] = image;
    data['user'] = user;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
