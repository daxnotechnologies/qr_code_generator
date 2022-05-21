class Menu {
  String? resturantName;
  String? address;
  String? city;
  String? contact;
  String? name;
  List<Items>? items;
  String? headerImg;
  String? backgroundImg;
  String? uid;

  Menu({
    this.resturantName,
    this.address,
    this.city,
    this.contact,
    this.name,
    this.items,
    this.headerImg,
    this.backgroundImg,
    this.uid,
  });

  Menu.fromJson(Map<String, dynamic> json) {
    resturantName = json['resturantName'];
    address = json['address'];
    city = json['city'];
    contact = json['contact'];
    name = json['name'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    headerImg = json['headerImg'];
    backgroundImg = json['backgroundImg'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resturantName'] = resturantName;
    data['address'] = address;
    data['city'] = city;
    data['contact'] = contact;
    data['name'] = name;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['headerImg'] = headerImg;
    data['backgroundImg'] = backgroundImg;
    data['uid'] = uid;
    return data;
  }
}

class Items {
  String? id;
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
