class MApp {
  String? id;
  String? name;
  String? cover;

  MApp({this.id, this.name, this.cover});

  factory MApp.fromJson(Map<String, dynamic> json) => MApp(
        id: json['id'],
        name: json['name'],
        cover: json['cover'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'cover': cover,
      };
}
