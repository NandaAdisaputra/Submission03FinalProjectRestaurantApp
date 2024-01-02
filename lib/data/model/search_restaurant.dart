import 'dart:convert';

import 'package:submission3nanda/data/model/restaurant_model.dart';

SearchRestaurant searchRestaurantFromJson(String str) =>
    SearchRestaurant.fromJson(
      json.decode(str),
    );

String searchRestaurantToJson(SearchRestaurant data) => json.encode(
  data.toJson(),
);

class SearchRestaurant {
  bool error;
  int founded;
  List<Restaurant> restaurants;

  SearchRestaurant({
    this.error = false,
    this.founded = 0,
    this.restaurants = const [],
  });

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) =>
      SearchRestaurant(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
          json["restaurants"].map(
                (x) => Restaurant.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "founded": founded,
    "restaurants": List<dynamic>.from(
      restaurants.map(
            (x) => x.toJson(),
      ),
    ),
  };
}
