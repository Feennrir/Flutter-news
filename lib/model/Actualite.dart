class Actualite {
  final int id;
  final String title;
  final String description;
  final String pictureUrl;
  final DateTime publishedAt;
  final double latitude;
  final double longitude;

  Actualite({
    required this.id,
    required this.title,
    required this.description,
    required this.pictureUrl,
    required this.publishedAt,
    required this.latitude,
    required this.longitude,
  });

  factory Actualite.fromJson(Map<String, dynamic> json) {
    return Actualite(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      pictureUrl: json['picture_url'] ?? '',
      publishedAt: DateTime.fromMillisecondsSinceEpoch(json['published_at'] * 1000),
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}