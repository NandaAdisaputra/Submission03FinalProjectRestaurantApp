import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:submission3nanda/data/base/base_url.dart';
import 'package:submission3nanda/data/model/detail_restaurant.dart';
import 'package:submission3nanda/data/model/list_restaurant.dart';
import 'package:submission3nanda/data/model/review_model.dart';
import 'package:submission3nanda/utils/error_helper/error_handler.dart';
import 'package:http/http.dart' as http;
import 'package:submission3nanda/data/base/endpoints.dart' as Endpoints;

class ApiService {
  Dio dio = Dio();
  // ApiServices() {
  //   dio = Dio(BaseOptions(baseUrl: base));
  // }

  late final Client client;

  ApiService({Client? client}) {
    this.client = client ?? http.Client();
  }

  Future<ListRestaurant> listRestaurant() async {
    print("Fetching list of restaurants...");

    final response = await client.get(
      Uri.parse(Endpoints.getListRestaurant.list),
    );

    if (response.statusCode == 200) {
      print("Response body: ${response.body}");

      return ListRestaurant.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load list restaurant. Status code: ${response.statusCode}");
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<DetailRestaurant> detailRestaurant(String id) async {
    final response = await client.get(
      Uri.parse('${base}detail/$id'),
    );
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<List<Review>> createReview(
      {String? id, String? name, String? review, String? date}) async {
    try {
      final response = await dio
          .post("/review", data: {'id': id, 'name': name, 'review': review});

      if (response.statusCode == 201) {
        debugPrint(response.data.toString());
        final reviewData = response.data?['customerReviews'];
        final reviews = <Review>[];
        for (var review in reviewData) {
          reviews.add(
            Review(
              id: id.toString(),
              name: name.toString(),
              review: review.toString(),
              date: date.toString(),
            ),
          );
        }
        return reviews;
      } else {
        throw Exception(ErrorHandler.handle(dynamic));
      }
    } catch (e) {
      throw Exception(ErrorHandler.handle(dynamic));
    }
  }
}
