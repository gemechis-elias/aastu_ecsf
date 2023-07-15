class RecommendedModel {
  String name;
  String tagLine;
  String image;
  List<String> images;
  String description;
  int price;

  RecommendedModel(this.name, this.tagLine, this.image, this.images,
      this.description, this.price);
}

List<RecommendedModel> recommendations = recommendationsData
    .map((item) => RecommendedModel(
        item['name'] as String,
        item['tagLine'] as String,
        item['image'] as String,
        (item['images'] as List<dynamic>).cast<String>(),
        item['description'] as String,
        item['price'] as int))
    .toList();

var recommendationsData = [
  {
    "name": "Welcome!",
    "tagLine": "Welcome!",
    "image": "assets/images/get_started.png",
    "images": [
      "assets/images/get_started.png",
    ],
    "description":
        "Exprience the joy of fellowship wherever you are. Join our christian fellowship App and dicover inspiring content, engaging discussion, and opportunity to serve others",
    "price": 100
  },
];
