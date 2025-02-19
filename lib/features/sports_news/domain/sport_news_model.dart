class SportNewsModel {
  String? status;
  int? totalResults;
  List<Results>? results;
  String? nextPage;

  SportNewsModel({this.status, this.totalResults, this.results, this.nextPage});

  SportNewsModel.fromJson(Map<String, dynamic> json) {
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

  // Implementing the copyWith method
  SportNewsModel copyWith({
    String? status,
    int? totalResults,
    List<Results>? results,
    String? nextPage,
  }) {
    return SportNewsModel(
      status: status ?? this.status,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
      nextPage: nextPage ?? this.nextPage,
    );
  }
}

class Results {
  String? articleId;
  String? title;
  String? link;
  String? pubDate;
  String? imageUrl;
  List<String>? keywords;

  Results({
    this.articleId,
    this.title,
    this.link,
    this.pubDate,
    this.imageUrl,
    this.keywords,
  });

  Results.fromJson(Map<String, dynamic> json) {
    articleId = json['article_id'];
    title = json['title'];
    link = json['link'];
    pubDate = json['pubDate'];
    imageUrl = json['image_url'];
    keywords =
        json['keywords'] != null ? List<String>.from(json['keywords']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['article_id'] = articleId;
    data['title'] = title;
    data['link'] = link;
    data['pubDate'] = pubDate;
    data['image_url'] = imageUrl;
    data['keywords'] = keywords;
    return data;
  }
}
