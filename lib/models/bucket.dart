import 'package:qr_code_generator/models/menu_response.dart';

class Bucket {
  String? folderName;
  String? dateCreated;
  Menu? menu;

  Bucket({this.folderName, this.dateCreated, this.menu});

  Bucket.fromJson(Map<String, dynamic> json) {
    folderName = json['folderName'];
    dateCreated = json['dateCreated'];
    menu = json['menu'] != null ? Menu.fromJson(json['menu']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['folderName'] = folderName;
    data['dateCreated'] = dateCreated;
    if (menu != null) {
      data['menu'] = menu!.toJson();
    }
    return data;
  }
}
