class AllSurveys {
  bool? message;
  List<Surveys>? surveys;

  AllSurveys({this.message, this.surveys});

  AllSurveys.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['surveys'] != null) {
      surveys = <Surveys>[];
      json['surveys'].forEach((v) {
        surveys!.add(Surveys.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (surveys != null) {
      data['surveys'] = surveys!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Surveys {
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
  String? qrcode;

  Surveys({
    this.sId,
    this.name,
    this.address,
    this.city,
    this.description,
    this.image,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.qrcode,
  });

  Surveys.fromJson(Map<String, dynamic> json) {
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
    qrcode = json['qrcode'];
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
    data['qrcode'] = qrcode;
    return data;
  }
}
