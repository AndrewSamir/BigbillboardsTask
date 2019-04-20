class Product {
  final String title;
  final String photo;

  Product._({this.title, this.photo});

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product._(
      title: json['title'] as String,
      photo: json['photo'] as String,
    );
  }
}
