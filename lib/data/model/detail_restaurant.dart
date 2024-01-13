class DetailRestaurant {
  bool? error;
  String? message;
  Restaurant? restaurant;

  DetailRestaurant({
    this.error,
    this.message,
    this.restaurant,
  });

  factory DetailRestaurant.fromJson(Map<String, dynamic> json) {
    return DetailRestaurant(
      error: json["error"],
      message: json["message"],
      restaurant: json["restaurant"] != null
          ? Restaurant.fromJson(json["restaurant"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "error": error,
      "message": message,
      "restaurant": restaurant?.toJson(),
    };
  }
}

class Restaurant {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menus menus;
  double rating;
  List<CustomerReview> customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      city: json["city"],
      address: json["address"],
      pictureId: json["pictureId"],
      categories: (json["categories"] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((x) => Category.fromJson(x))
          .toList(),
      menus: Menus.fromJson(json["menus"]),
      rating: json["rating"]?.toDouble() ?? 0.0,
      customerReviews: (json["customerReviews"] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((x) => CustomerReview.fromJson(x))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "city": city,
      "address": address,
      "pictureId": pictureId,
      "categories": categories.map((x) => x.toJson()).toList(),
      "menus": menus.toJson(),
      "rating": rating,
      "customerReviews": customerReviews.map((x) => x.toJson()).toList(),
    };
  }
}

class Category {
  String name;

  Category({
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }
}

class CustomerReview {
  String name;
  String review;
  String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      name: json["name"],
      review: json["review"],
      date: json["date"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "review": review,
      "date": date,
    };
  }
}

class Menus {
  List<Category> foods;
  List<Category> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods:
          List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
      drinks:
          List<Category>.from(json["drinks"].map((x) => Category.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
      "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
    };
  }
}
