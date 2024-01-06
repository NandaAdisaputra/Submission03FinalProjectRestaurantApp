import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:submission3nanda/data/model/detail_restaurant.dart';
import 'package:submission3nanda/data/model/list_restaurant.dart';
import 'package:submission3nanda/data/model/review_model.dart';
import 'package:submission3nanda/utils/error_helper/error_handler.dart';
import 'package:http/http.dart' show Client;
import 'package:submission3nanda/data/base/endpoints.dart' as end_points;

class ApiService {
  Dio dio = Dio();
  final Client client;

  ApiService(this.client);

  Future<ListRestaurant> listRestaurant() async {
    final response = await client.get(
      Uri.parse(end_points.getListRestaurant.list),
    );
    if (response.statusCode == 200) {
      return ListRestaurant.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception(ErrorHandler.handle(dynamic));
    }
  }

  Future<DetailRestaurant> detailRestaurant(String? id) async {
    final response = await client.get(
      Uri.parse(end_points.getDetailRestaurant.detail + id.toString()),
    );
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(
        json.decode(response.body),
      );
    } else {
      throw DetailRestaurant.fromJson(
        json.decode(response.body),
      );
    }
  }

  Future<List<Review>> createReview(
      {String? id, String? name, String? review, String? date}) async {
    try {
      final response = await dio
          .post(end_points.postReview.review, data: {'id': id, 'name': name, 'review': review});

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
