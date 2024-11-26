class UserCategoriesModel {
  final String userId;
  final List<String> categories;

  UserCategoriesModel({
    required this.userId,
    required this.categories,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'categories': categories,
    };
  }

  factory UserCategoriesModel.fromJson(Map<String, dynamic> json) {
    return UserCategoriesModel(
      userId: json['userId'] as String,
      categories: List<String>.from(json['categories'] as List),
    );
  }
}
