import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/database/database_helper.dart';
import 'package:submission3nanda/data/model/restaurant_model.dart';
import 'package:submission3nanda/ui/favorite/controller/favorite_controller.dart';

class CardRestaurant extends StatefulWidget {
  final Restaurant restaurant;

  CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<CardRestaurant> createState() => _CardRestaurantState();
}

class _CardRestaurantState extends State<CardRestaurant> {
  final FavoriteController databaseController =
  Get.put(FavoriteController(databaseHelper: DatabaseHelper()));

  @override
  Widget build(BuildContext context) {
    String? imageBaseUrl = 'https://restaurant-api.dicoding.dev/images/small/';
    return FutureBuilder<bool>(
      future: databaseController.isFavorite(widget.restaurant.id.toString()),
      builder: (context, snapshot) {
        var isFavorite = snapshot.data ?? false;
        print('isfavorite${snapshot.data}');
        return Material(
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0, left: 4.0),
            child: Card(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey, width: 0.2),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: ListTile(
                trailing: isFavorite
                    ? IconButton(
                  onPressed: () {
                    setState(() {
                      databaseController.removeFavorite(
                          widget.restaurant.id.toString());
                    });
                  },
                  icon: const Icon(Icons.favorite, color: Colors.red),
                )
                    : IconButton(
                  onPressed: () {
                    setState(() {
                      databaseController.addFavorite(widget.restaurant);
                    });
                  },
                  icon: const Icon(Icons.favorite_border),
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: widget.restaurant.pictureId != null
                    ? Hero(
                  tag: widget.restaurant.pictureId.toString(),
                  child: Image.network(
                    '$imageBaseUrl${widget.restaurant.pictureId}',
                    fit: BoxFit.cover,
                    width: 100,
                  ),
                )
                    : const Center(
                  child: Text('No Image Available'),
                ),
                title: Text(
                  widget.restaurant.name ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey,
                          size: 15,
                        ),
                        Text(
                          widget.restaurant.city ?? "",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 15,
                        ),
                        Text(
                          widget.restaurant.rating.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  // Navigation.intentWithData(DetailsPage.routeName, restaurant);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}