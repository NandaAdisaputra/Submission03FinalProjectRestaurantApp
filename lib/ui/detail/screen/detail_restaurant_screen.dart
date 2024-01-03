import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/model/detail_restaurant.dart';
import 'package:submission3nanda/data/preferences/preferences.dart';
import 'package:submission3nanda/ui/detail/controller/detail_controller.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';

class DetailRestaurantScreen extends GetView<DetailRestaurantController> {
  static const routeName = '/restaurant_detail';

  final String restaurantId;

  const DetailRestaurantScreen({Key? key, required this.restaurantId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<PreferencesController>().themeData;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double percentSpace =
                ((constraints.maxHeight - kToolbarHeight) /
                    (200 - kToolbarHeight));
                return FlexibleSpaceBar(
                  centerTitle: percentSpace > 0.5,
                  titlePadding: EdgeInsets.symmetric(
                      horizontal: percentSpace > 0.5 ? 0 : 72, vertical: 16),
                  background: Hero(
                    tag: controller.result.restaurant.pictureId,
                    child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/medium/${controller.result.restaurant.pictureId}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    controller.result.restaurant.name,
                    style: TextStyle(
                      color: percentSpace > 0.5
                          ? CustomColors.DarkOrange
                          : theme.colorScheme.onSecondaryContainer,
                    ),
                  ),
                );
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on),
                          const SizedBox(width: 5),
                          Text(controller.result.restaurant.city),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow),
                          const SizedBox(width: 5),
                          Text(controller.result.restaurant.rating.toString()),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        controller.result.restaurant.description,
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Menus',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Foods',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.result.restaurant.menus.foods.length,
                          itemBuilder: (context, index) {
                            return _buildFoodItem(
                                context, controller.result.restaurant.menus.foods[index]);
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Drinks',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.result.restaurant.menus.drinks.length,
                          itemBuilder: (context, index) {
                            return _buildDrinkItem(context,
                                controller.result.restaurant.menus.drinks[index]);
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Customer Reviews',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          border: Border.all(color:  CustomColors.DarkOrange),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Obx(
                              () => ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: controller.result.restaurant.customerReviews.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                    controller.result.restaurant.customerReviews[index].name),
                                subtitle: Text(
                                    controller.result.restaurant.customerReviews[index].review),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodItem(BuildContext context, Category food) {
    return SizedBox(
      width: 100,
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/food.png', fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Text(food.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color:  CustomColors.DarkOrange,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrinkItem(BuildContext context, Category drink) {
    return SizedBox(
      width: 100,
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/drink.png', fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Text(
                drink.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color:  CustomColors.DarkOrange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
