class MDownload {
  MDownload({
    this.url,
    this.version,
  });

  String? url;
  String? version;

  factory MDownload.fromJson(Map<String, dynamic> json) => MDownload(
        url: json["url"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "version": version,
      };
}
