class NewsModel {
  final String title;
  final String description;
  final NewsImageModel images;

  NewsModel({
    required this.title,
    required this.description,
    required this.images,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      images: NewsImageModel.fromJson(json['image'] ?? {}),
    );
  }
}

class NewsImageModel {
  final String small;
  final String large;

  NewsImageModel({
    required this.small,
    required this.large,
  });

  factory NewsImageModel.fromJson(Map<String, dynamic> json) {
    return NewsImageModel(
      small: json['small'] ?? '',
      large: json['large'] ?? '',
    );
  }
}
