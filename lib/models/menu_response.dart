class MenuResponse {
  bool? message;
  Menu? menu;

  MenuResponse({this.message, this.menu});

  MenuResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    menu = json['menu'] != null ? Menu.fromJson(json['menu']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (menu != null) {
      data['menu'] = menu!.toJson();
    }
    return data;
  }
}

class Menu {
  List<Items>? items;
  String? sId;
  String? resturantName;
  String? address;
  String? city;
  String? contact;
  String? name;
  String? headerImg;
  String? backgroundImg;
  String? qrcode;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Menu({
    this.items,
    this.sId,
    this.resturantName,
    this.address,
    this.city,
    this.contact,
    this.name,
    this.headerImg,
    this.backgroundImg,
    this.qrcode,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Menu.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    sId = json['_id'];
    resturantName = json['resturantName'];
    address = json['address'];
    city = json['city'];
    contact = json['contact'];
    name = json['name'];
    headerImg = json['headerImg'];
    backgroundImg = json['backgroundImg'];
    qrcode = json['qrcode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['resturantName'] = resturantName;
    data['address'] = address;
    data['city'] = city;
    data['contact'] = contact;
    data['name'] = name;
    data['headerImg'] = headerImg;
    data['backgroundImg'] = backgroundImg;
    data['qrcode'] = qrcode;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Items {
  // String
  int? id;
  String? name;
  String? price;
  String? description;

  Items({this.id, this.name, this.price, this.description});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    return data;
  }
}
