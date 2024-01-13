import 'dart:convert';
import 'package:submission3nanda/data/model/restaurant_model.dart';

ListRestaurant listRestaurantFromJson(String str) =>
    ListRestaurant.fromJson(json.decode(str));

String listRestaurantToJson(ListRestaurant data) => json.encode(data.toJson());

class ListRestaurant {
  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  ListRestaurant({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory ListRestaurant.fromJson(Map<String, dynamic> json) => ListRestaurant(
    error: json["error"] ?? false,
    message: json["message"] ?? "",
    count: json["count"] ?? 0,
    restaurants: (json["restaurants"] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map((x) => Restaurant.fromJson(x))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "restaurants": restaurants.map((x) => x.toJson()).toList(),
  };
}