class MPackage {
  MPackage({
    this.id,
    this.description,
    this.url,
  });

  String? id;
  String? description;
  String? url;

  factory MPackage.fromJson(Map<String, dynamic> json) => MPackage(
        id: json["id"],
        description: json["description"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "url": url,
      };
}
