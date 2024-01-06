import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:submission3nanda/ui/detail/screen/detail_restaurant_screen.dart';
import 'package:submission3nanda/ui/search/controller/search_controller.dart';
import 'package:submission3nanda/utils/resource_helper/assets.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';
import 'package:submission3nanda/utils/resource_helper/fonts.dart';
import 'package:submission3nanda/utils/resource_helper/sizes.dart';
import '../../../data/const/constants.dart';

final SearchRestaurantController searchController =
    Get.put(SearchRestaurantController());

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Get.isDarkMode ? CustomColors.jetColor : CustomColors.darkOrange,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Obx(
            () => SizedBox(
              height: Get.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      Constants.search,
                      style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? CustomColors.whiteColor
                              : CustomColors.darkOrange,
                          fontSize: displayWidth(context) * 0.08,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Text(
                      Constants.searchRestaurantYourLikes,
                      style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? CustomColors.whiteColor
                              : CustomColors.darkOrange,
                          fontSize: displayWidth(context) * 0.05),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    onChanged: (text) {
                      searchController.queryInp.value = text;
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? CustomColors.whiteColor
                              : CustomColors.darkOrange,
                        ),
                        labelText: Constants.inputData,
                        hintText: Constants.search),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: Get.height,
                      child: Center(
                        child: Container(
                          child: searchController.queryInp.value.isNotEmpty
                              ? FutureBuilder(
                                  future: searchController.getListRestaurant(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      // Handle error, including no internet connection
                                      return Container(
                                        alignment: Alignment.center,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(ImageAssets
                                                .imageNoInternetAccess),
                                            const SizedBox(height: 20),
                                            Center(
                                              child: Text(
                                                Constants.noInternetAccess,
                                                style: TextStyle(
                                                  color: Colors.deepOrange,
                                                  fontSize:
                                                      displayWidth(context) *
                                                          0.05,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (snapshot.hasData) {
                                      return ListView.builder(
                                        itemCount: searchController
                                            .listBodyRestaurants.length,
                                        itemBuilder: (context, index) {
                                          var data = searchController
                                              .listBodyRestaurants[index];
                                          return InkWell(
                                            onTap: () {
                                              Get.to(
                                                () => DetailRestaurantScreen(
                                                    restaurantID:
                                                        data[Constants.id],
                                                    restaurantNAME:
                                                        data[Constants.name],
                                                    restaurantCITY:
                                                        data[Constants.city],
                                                    restaurantDESCRIPTION: data[
                                                        Constants.description],
                                                    restaurantPICTUREID:
                                                        data[Constants.image],
                                                    restaurantRATING:
                                                        data[Constants.rating]
                                                            .toString()),
                                              );
                                            },
                                            child: Card(
                                              margin: const EdgeInsets.only(
                                                  left: 12,
                                                  right: 8,
                                                  top: 4,
                                                  bottom: 12),
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? CustomColors.jetColor
                                                  : CustomColors.lavenderColor,
                                              elevation: 8,
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          16, 12, 8, 12),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.network(
                                                            'https://restaurant-api.dicoding.dev/images/medium/${data[Constants.image]}',
                                                            fit: BoxFit.cover,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: 80),
                                                      ),
                                                    ),
                                                  ),
                                                  AppSizes.wSizeBox15,
                                                  SizedBox(
                                                      height: 50,
                                                      child: VerticalDivider(
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? CustomColors
                                                                  .darkOrange
                                                              : CustomColors
                                                                  .scarletColor)),
                                                  Flexible(
                                                    flex: 2,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              data[Constants
                                                                  .name],
                                                              style: TextStyle(
                                                                  color: Theme.of(context)
                                                                              .brightness ==
                                                                          Brightness
                                                                              .dark
                                                                      ? CustomColors
                                                                          .orangePeel
                                                                      : CustomColors
                                                                          .darkOrange,
                                                                  fontSize: displayWidth(
                                                                          context) *
                                                                      FontSize
                                                                          .s0045,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      Constants
                                                                          .helvetica),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .location_on_outlined,
                                                                color: Theme.of(context)
                                                                            .brightness ==
                                                                        Brightness
                                                                            .dark
                                                                    ? CustomColors
                                                                        .greenRyb
                                                                    : CustomColors
                                                                        .scarletColor),
                                                            AppSizes.wSizeBox8,
                                                            Text(
                                                              data[Constants
                                                                  .city],
                                                              style: TextStyle(
                                                                  fontSize: displayWidth(
                                                                          context) *
                                                                      FontSize
                                                                          .s0045,
                                                                  color: Theme.of(context)
                                                                              .brightness ==
                                                                          Brightness
                                                                              .dark
                                                                      ? CustomColors
                                                                          .greenRyb
                                                                      : CustomColors
                                                                          .scarletColor),
                                                            ),
                                                          ],
                                                        ),
                                                        AppSizes.hSizeBox15,
                                                        Row(
                                                          children: [
                                                            RatingBar.builder(
                                                              ignoreGestures:
                                                                  true,
                                                              itemSize:
                                                                  displayWidth(
                                                                          context) *
                                                                      FontSize
                                                                          .s005,
                                                              initialRating: data[
                                                                      Constants
                                                                          .rating]
                                                                  .toDouble(),
                                                              glowColor: Colors
                                                                  .transparent,
                                                              minRating: 1,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              itemCount: 5,
                                                              itemPadding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      Icon(
                                                                Icons.star,
                                                                color: Theme.of(context)
                                                                            .brightness ==
                                                                        Brightness
                                                                            .dark
                                                                    ? CustomColors
                                                                        .goldColor
                                                                    : CustomColors
                                                                        .darkCornflowerBlue,
                                                              ),
                                                              onRatingUpdate:
                                                                  (rating) {},
                                                            ),
                                                            AppSizes.wSizeBox50
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Lottie.asset(JsonAssets.search),
                                      const SizedBox(height: 20),
                                      Center(
                                        child: Text(
                                          Constants.noDataYet,
                                          style: TextStyle(
                                            color: Colors.deepOrange,
                                            fontSize:
                                                displayWidth(context) * 0.05,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
