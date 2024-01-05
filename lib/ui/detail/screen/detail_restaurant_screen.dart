import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/ui/detail/controller/detail_controller.dart';
import 'package:submission3nanda/ui/review/screen/add_field_review_screen.dart';
import 'package:submission3nanda/utils/resource_helper/assets.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';
import 'package:submission3nanda/utils/resource_helper/fonts.dart';
import 'package:submission3nanda/utils/resource_helper/sizes.dart';
import 'package:submission3nanda/utils/result_state.dart';
import 'package:submission3nanda/utils/widget/drinks_list.dart';
import 'package:submission3nanda/utils/widget/foods_list.dart';

final detailController = Get.put(DetailRestaurantController());

class DetailRestaurantScreen extends GetView<DetailRestaurantController> {
  static const routeName = '/details';

  DetailRestaurantScreen({
    Key? key,
    required this.restaurantID,
    required this.restaurantPICTUREID,
    required this.restaurantNAME,
    required this.restaurantCITY,
    required this.restaurantRATING,
    required this.restaurantDESCRIPTION,
  }) : super(key: key) {
    detailController.getListRestaurant(restaurantID);
  }

  final String? restaurantID;
  final String? restaurantPICTUREID;
  final String? restaurantNAME;
  final String? restaurantCITY;
  final String? restaurantRATING;
  final String? restaurantDESCRIPTION;
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (detailController.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (detailController.state == ResultState.hasData) {
        return Scaffold(
          body: LiquidPullToRefresh(
            key: _refreshIndicatorKey,
            onRefresh: _handleRefresh,
            showChildOpacityTransition: false,
            child: SizedBox(
              height: Get.height,
              child: ListView(children: [
                _buildStack(context),
                Container(
                  padding: const EdgeInsets.all(17),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$restaurantNAME',
                          style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? CustomColors.pearColor
                                  : CustomColors.darkOrange,
                              fontSize: displayWidth(context) * FontSize.s008,
                              fontWeight: FontWeight.bold,
                              fontFamily: Constants.helvetica),
                        ),
                        AppSizes.hSizeBox15,
                        Container(
                          padding: EdgeInsets.zero,
                          child: Row(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Icon(
                                      Icons.location_on_outlined,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? CustomColors.darkOrange
                                          : CustomColors.greenRyb,
                                    ),
                                  ),
                                  AppSizes.wSizeBox10,
                                  Center(
                                    child: Text(
                                      '$restaurantCITY',
                                      style: TextStyle(
                                        fontSize: displayWidth(context) *
                                            FontSize.s005,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? CustomColors.darkOrange
                                            : CustomColors.greenRyb,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                  height: 30,
                                  child: VerticalDivider(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? CustomColors.greenRyb
                                          : Colors.orange)),
                              Center(
                                child: Text(
                                  Constants.ratingDetail,
                                  style: TextStyle(
                                      fontSize:
                                          displayWidth(context) * FontSize.s005,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? CustomColors.orangePeel
                                          : CustomColors.darkOrange),
                                ),
                              ),
                              RatingBar.builder(
                                ignoreGestures: true,
                                itemSize:
                                    displayWidth(context) * FontSize.s0045,
                                initialRating:
                                    double.parse("$restaurantRATING"),
                                glowColor: Colors.transparent,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (_, __) => Icon(Icons.star,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? CustomColors.goldColor
                                        : CustomColors.goldColor),
                                onRatingUpdate: (rating) {},
                              ),
                            ],
                          ),
                        ),
                        AppSizes.hSizeBox15,
                        Divider(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? CustomColors.usaFaBlue
                              : CustomColors.spanishViRiDian,
                          thickness: 5,
                        ),
                        const Padding(padding: EdgeInsets.all(3)),
                        Container(
                          margin: const EdgeInsets.only(bottom: 24),
                          child: Center(
                            child: Text(
                              '$restaurantDESCRIPTION'.toString(),
                              textAlign: TextAlign.justify,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? CustomColors.whiteColor
                                      : CustomColors.blackColor,
                                  fontSize:
                                      displayWidth(context) * FontSize.s005,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                                height: 30,
                                child: VerticalDivider(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? CustomColors.spanishViRiDian
                                        : CustomColors.scarletColor)),
                            Text(Constants.menuFoods,
                                style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? CustomColors.spanishViRiDian
                                        : CustomColors.scarletColor,
                                    fontSize:
                                        displayWidth(context) * FontSize.s005,
                                    fontFamily: Constants.helvetica)),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 100,
                              child: FoodsList(
                                  foods: detailController.result.value
                                          .restaurant?.menus.foods ??
                                      []),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                                height: 30,
                                child: VerticalDivider(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? CustomColors.darkOrange
                                        : CustomColors.royalBlueDark)),
                            Text(Constants.menuDrinks,
                                style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? CustomColors.darkOrange
                                        : CustomColors.royalBlueDark,
                                    fontSize:
                                        displayWidth(context) * FontSize.s005,
                                    fontFamily: Constants.helvetica)),
                          ],
                        ),
                        Column(children: [
                          SizedBox(
                            height: 100,
                            child: DrinksList(
                                drinks: detailController.result.value.restaurant
                                        ?.menus.drinks ??
                                    []),
                          ),
                        ]),
                      ]),
                ),
              ]),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: Container(
            margin: const EdgeInsets.only(top: 30),
            child: FloatingActionButton.extended(
              icon: IconAssets.addIcon,
              label: const Text(Constants.addReviewRestaurant,
                  style: TextStyle(color: Colors.white)),
              hoverColor: CustomColors.scarletColor,
              tooltip: Constants.addReview,
              backgroundColor: Get.isDarkMode
                  ? CustomColors.usaFaBlue
                  : CustomColors.spanishViRiDian,
              onPressed: () {
                Get.to(
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            AddReviewFormScreen(restaurantID: restaurantID)),
                  ),
                );
              },
            ),
          ),
        );
      } else if (detailController.state == ResultState.error) {
        final error = detailController.result.value.error;
        debugPrint('Error: $error');
        return const Center(child: Text('Error occurred'));
      } else {
        return const Center(child: Text('Empty state'));
      }
    });
  }

  Widget _buildStack(context) {
    return Stack(
      alignment: const Alignment(0.9, 0.9),
      children: [
        ClipRRect(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(15)),
          child: Image.network(
            'https://restaurant-api.dicoding.dev/images/medium/$restaurantPICTUREID',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blue,
                spreadRadius: 3,
                blurRadius: 50,
                offset: Offset(
                  5.0,
                  5.0,
                ), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              RatingBar.builder(
                ignoreGestures: true,
                itemSize: 30,
                initialRating: double.parse("$restaurantRATING"),
                glowColor: Colors.transparent,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (_, __) => const Icon(
                  Icons.star,
                  color: CustomColors.goldColor,
                ),
                onRatingUpdate: (rating) {},
              ),
              Container(
                margin: const EdgeInsets.only(left: 125, right: 4),
                child: Text(
                  double.parse("$restaurantRATING").toString(),
                  style: const TextStyle(
                      color: CustomColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _handleRefresh() async {
    _refreshIndicatorKey.currentState?.show(atTop: false);
    await detailController.getListRestaurant(restaurantID);
  }
}
