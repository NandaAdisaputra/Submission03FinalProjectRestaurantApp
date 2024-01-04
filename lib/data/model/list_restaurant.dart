import 'dart:convert';
import 'package:submission3nanda/data/model/restaurant_model.dart';

ListRestaurant listRestaurantFromJson(String str) => ListRestaurant.fromJson(
      json.decode(str),
    );

String listRestaurantToJson(ListRestaurant data) => json.encode(
      data.toJson(),
    );

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
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
          json["restaurants"].map(
            (x) => Restaurant.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(
          restaurants.map(
            (x) => x.toJson(),
          ),
        ),
      };
}
