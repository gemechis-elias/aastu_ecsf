class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.lessonCount = 0,
    this.money = 0,
    this.rating = 0.0,
  });

  String title;
  int lessonCount;
  int money;
  double rating;
  String imagePath;
  static List<Category> postList = <Category>[
    Category(
      imagePath: 'assets/images/slide-1.png',
      title: 'In Christ, we are one body, united in faith and purpose',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
    ),
    Category(
      imagePath: 'assets/images/slide-1.png',
      title: 'In Christ, we are one body, united in faith and purpose',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
    ),
  ];
  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'Your Progress',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
    ),
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace3.png',
      title: 'Event Calendar',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/design_course/interFace4.png',
      title: 'Bible Study Resources',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
    Category(
      imagePath: 'assets/design_course/interFace3.png',
      title: 'Discussion Forum',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/design_course/interFace4.png',
      title: 'Bible Trivia',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
  ];
}
