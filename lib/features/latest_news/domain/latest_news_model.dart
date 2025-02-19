class LatestNewsModel {
  String? status;
  int? totalResults;
  List<Results>? results;
  String? nextPage;

  LatestNewsModel(
      {this.status, this.totalResults, this.results, this.nextPage});

  LatestNewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    nextPage = json['nextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['totalResults'] = totalResults;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['nextPage'] = nextPage;
    return data;
  }
}

class Results {
  String? articleId;
  String? title;
  String? link;
  String? pubDate;
  String? imageUrl;
<<<<<<< HEAD
  String? description;

=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
  List<String>? keywords;

  Results({
    this.articleId,
    this.title,
    this.link,
    this.pubDate,
    this.imageUrl,
    this.keywords,
<<<<<<< HEAD
    this.description,
=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
  });

  Results.fromJson(Map<String, dynamic> json) {
    articleId = json['article_id'];
    title = json['title'];
    link = json['link'];
    pubDate = json['pubDate'];
<<<<<<< HEAD
    description=json['description'];
=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
    imageUrl = json['image_url'];
    keywords =
        json['keywords'] != null ? List<String>.from(json['keywords']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['article_id'] = articleId;
    data['title'] = title;
    data['link'] = link;
<<<<<<< HEAD
    data['description'] = description;

=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
    data['pubDate'] = pubDate;
    data['image_url'] = imageUrl;
    data['keywords'] = keywords;
    return data;
  }
}
