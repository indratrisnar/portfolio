import 'm_download.dart';

class MApp {
  String? id;
  String? name;
  String? cover;
  String? description;
  String? playstore;
  String? youtube;
  List<MDownload>? download;
  List<String>? feature;
  List<String>? screenshot;
  List<String>? tools;

  MApp({
    this.id,
    this.name,
    this.cover,
    this.tools,
    this.description,
    this.download,
    this.feature,
    this.playstore,
    this.youtube,
    this.screenshot,
  });

  factory MApp.fromJson(Map<String, dynamic> json) => MApp(
        id: json['id'],
        name: json['name'],
        cover: json['cover'],
        description: json['description'],
        playstore: json['playstore'],
        youtube: json['youtube'],
        tools: List.castFrom(json['tools']),
        download: json['download'] == null
            ? null
            : List.of(json['download'])
                .map((e) => MDownload.fromJson(e))
                .toList(),
        feature: List.castFrom(json['feature']),
        screenshot: List.castFrom(json['screenshot']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'cover': cover,
        'tools': tools,
        'description': description,
        'download': download,
        'feature': feature,
        'playstore': playstore,
        'youtube': youtube,
        'screenshot': screenshot,
      };
}
