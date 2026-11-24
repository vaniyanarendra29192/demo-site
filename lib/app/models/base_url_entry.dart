class BaseUrlEntry {
  final String url;
  final String name;

  const BaseUrlEntry({required this.url, required this.name});

  factory BaseUrlEntry.fromJson(Map<String, dynamic> json) {
    return BaseUrlEntry(
      url: json['url'] as String,
      name: json['name'] as String,
    );
  }
}
