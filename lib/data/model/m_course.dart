class MCourse {
  MCourse({
    this.idCourse,
    this.name,
    this.cover,
    this.publishedAt,
  });

  String? idCourse;
  String? name;
  String? cover;
  List? publishedAt;

  factory MCourse.fromJson(Map<String, dynamic> json) => MCourse(
        idCourse: json["id_course"],
        name: json["name"],
        cover: json["cover"],
        publishedAt: json["published_at"] ?? [],
      );

  Map<String, dynamic> toJson() => {
        "id_course": idCourse,
        "name": name,
        "cover": cover,
        "published_at": publishedAt ?? [],
      };
}
