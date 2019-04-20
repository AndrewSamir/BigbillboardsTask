import 'package:first_flutter_app/fetch_data/products.dart';

class Response {
  String status;
  Product data;

  Response._({this.status, this.data});

  factory Response.fromJson(Map<String, dynamic> json) {
    return new Response._(
      status: json['status'],
      data: Product.fromJson(json['data']),
    );
  }
}
