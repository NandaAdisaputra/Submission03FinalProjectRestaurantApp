import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/data/database/database_helper.dart';
import 'package:submission3nanda/data/model/restaurant_model.dart';
import 'package:submission3nanda/ui/detail/screen/detail_restaurant_screen.dart';
import 'package:submission3nanda/ui/favorite/controller/favorite_controller.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';
import 'package:submission3nanda/utils/resource_helper/fonts.dart';
import 'package:submission3nanda/utils/resource_helper/sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardRestaurant extends StatefulWidget {
  final Restaurant restaurant;
  final bool isAccessedFromHomePage;

  const CardRestaurant({
    Key? key,
    required this.restaurant,
    required this.isAccessedFromHomePage,
  }) : super(key: key);

  @override
  State<CardRestaurant> createState() => _CardRestaurantState();
}

class _CardRestaurantState extends State<CardRestaurant> {
  final FavoriteController favoriteController =
      Get.put(FavoriteController(databaseHelper: DatabaseHelper()));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: favoriteController.isFavorite(widget.restaurant.id.toString()),
      builder: (context, snapshot) {
        var isFavorite = snapshot.data ?? false;
        return Material(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Card(
              margin: const EdgeInsets.only(
                left: 12,
                right: 8,
                top: 4,
                bottom: 12,
              ),
              color: Get.isDarkMode
                  ? CustomColors.jetColor
                  : CustomColors.lavenderColor,
              elevation: 8,
              child: buildListTile(isFavorite),
            ),
          ),
        );
      },
    );
  }

  ListTile buildListTile(bool isFavorite) {
    return ListTile(
      trailing: isFavorite ? buildFavoriteIcon() : buildFavoriteBorderIcon(),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: buildLeadingImage(),
      title: buildTitle(),
      subtitle: buildSubtitle(),
      onTap: navigateToDetailRestaurant,
    );
  }

  IconButton buildFavoriteIcon() {
    return IconButton(
      onPressed: showDeleteConfirmationDialog,
      icon: const Icon(Icons.favorite, color: Colors.red),
    );
  }

  IconButton buildFavoriteBorderIcon() {
    return IconButton(
      onPressed: () {
        setState(() {
          favoriteController.addFavorite(widget.restaurant);
          favoriteController.update();
        });
      },
      icon: const Icon(Icons.favorite_border),
    );
  }

  Widget buildLeadingImage() {
    return widget.restaurant.pictureId.isNotEmpty
        ? Hero(
            tag: widget.isAccessedFromHomePage
                ? 'home-${widget.restaurant.pictureId}'
                : 'favorite-${widget.restaurant.pictureId}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl:
                    'https://restaurant-api.dicoding.dev/images/medium/${widget.restaurant.pictureId}',
                fit: BoxFit.cover,
                width: 100,
                height: MediaQuery.of(context).size.height,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          )
        : const Center(child: Text('No Image Available'));
  }

  Text buildTitle() {
    return Text(
      widget.restaurant.name,
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.dark
            ? CustomColors.orangePeel
            : CustomColors.darkOrange,
        fontSize: displayWidth(context) * FontSize.s0045,
        fontWeight: FontWeight.bold,
        fontFamily: Constants.helvetica,
      ),
    );
  }

  Column buildSubtitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildLocationRow(),
        const SizedBox(height: 5),
        buildRatingRow(),
      ],
    );
  }

  Row buildLocationRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on_outlined,
          color: Theme.of(context).brightness == Brightness.dark
              ? CustomColors.greenRyb
              : CustomColors.scarletColor,
        ),
        AppSizes.wSizeBox8,
        Text(
          widget.restaurant.city,
          style: TextStyle(
            fontSize: displayWidth(context) * FontSize.s0045,
            color: Theme.of(context).brightness == Brightness.dark
                ? CustomColors.greenRyb
                : CustomColors.scarletColor,
          ),
        ),
      ],
    );
  }

  Row buildRatingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RatingBar.builder(
          ignoreGestures: true,
          itemSize: displayWidth(context) * FontSize.s005,
          initialRating: widget.restaurant.rating.toDouble(),
          glowColor: Colors.transparent,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Theme.of(context).brightness == Brightness.dark
                ? CustomColors.goldColor
                : CustomColors.darkCornflowerBlue,
          ),
          onRatingUpdate: (rating) {},
        ),
        AppSizes.wSizeBox50
      ],
    );
  }

  void navigateToDetailRestaurant() {
    Get.to(() => DetailRestaurantScreen(
          restaurantID: widget.restaurant.id,
          restaurantPICTUREID: widget.restaurant.pictureId,
          restaurantNAME: widget.restaurant.name,
          restaurantCITY: widget.restaurant.city,
          restaurantRATING: widget.restaurant.rating.toString(),
          restaurantDESCRIPTION: widget.restaurant.description,
        ));
  }

  void showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(Constants.deleteConfirmation),
          content: const Text(Constants.areYouSure),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  favoriteController
                      .removeFavorite(widget.restaurant.id.toString());
                });
                Navigator.of(context).pop();
                favoriteController.update();
              },
              child: const Text(Constants.yesAction),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                favoriteController.update(); // Close the dialog
              },
              child: const Text(Constants.noAction),
            ),
          ],
        );
      },
    );
  }
}
