class Folder {
  String? folderName;
  String? dateCreated;
  List<String>? items;

  Folder({this.folderName, this.dateCreated, this.items});

  Folder.fromJson(Map<String, dynamic> json) {
    folderName = json['folderName'];
    dateCreated = json['dateCreated'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['folderName'] = folderName;
    data['dateCreated'] = dateCreated;
    if (items != null) {
      data['items'] = items!;
    }
    return data;
  }
}
