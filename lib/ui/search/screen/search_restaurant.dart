import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/network/api_service.dart';
import 'package:submission3nanda/ui/search/controller/search_controller.dart';
import 'package:submission3nanda/utils/result_state.dart';
import 'package:submission3nanda/utils/widget/card_restaurant.dart';


final SearchRestaurantController searchController = Get.put(SearchRestaurantController(apiService: ApiService()));

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Restaurant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Search Restaurant',
                  floatingLabelStyle: const TextStyle(color: Colors.blue),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchController.search(searchController.query);
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
                onSubmitted: (value) {
                  searchController.query = value;
                  searchController.search(searchController.query);
                },
              ),
            ),
            Obx(() {
              final state = searchController.state;
              if (state == ResultState.loading) {
                return const Expanded(
                  flex: 9,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state == ResultState.hasData) {
                return Expanded(
                  flex: 9,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchController.result.restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant = searchController.result.restaurants[index];
                      return CardRestaurant(restaurant: restaurant);
                    },
                  ),
                );
              } else {
                return Expanded(
                  flex: 9,
                  child: Center(
                    child: Text(state == ResultState.noData ? searchController.message : 'Error occurred'),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}