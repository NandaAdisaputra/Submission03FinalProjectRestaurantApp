import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:submission3nanda/data/model/list_restaurant.dart';
import 'package:submission3nanda/data/network/api_service.dart';

@GenerateMocks([http.Client])
void main() {
  group(
    'Testing Restaurant Api',
    () {
      test('if http call complete success return list of restaurant', () async {
        final client = MockClient((request) async {
          final response = {
            "error": false,
            "message": "success",
            "count": 20,
            "restaurants": []
          };
          return Response(json.encode(response), 200);
        });
        expect(
          await ApiService(client).listRestaurant(),
          isA<ListRestaurant>(),
        );
      });
    },
  );
}
