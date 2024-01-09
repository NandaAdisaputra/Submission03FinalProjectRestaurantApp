import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:submission3nanda/ui/detail/screen/detail_restaurant_screen.dart';
import 'package:submission3nanda/ui/search/controller/search_controller.dart';
import 'package:submission3nanda/utils/resource_helper/assets.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';
import 'package:submission3nanda/utils/resource_helper/fonts.dart';
import 'package:submission3nanda/utils/resource_helper/sizes.dart';
import 'package:submission3nanda/utils/widget/load_data_error.dart';
import '../../../data/const/constants.dart';

final SearchRestaurantController searchController =
    Get.put(SearchRestaurantController());

class SearchScreen extends GetView<SearchRestaurantController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dynamicHeight = Get.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Get.isDarkMode
            ? CustomColors.jetColor
            : CustomColors.darkOrange,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(17.0),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  Constants.searchRestaurantYourLikes,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? CustomColors.whiteColor
                        : CustomColors.darkOrange,
                    fontSize: displayWidth(context) * 0.05,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                onChanged: (text) {
                  if (text.isNotEmpty) {
                    searchController.queryInp.value = text;
                    searchController.getListRestaurant();
                  } else {
                    searchController.clearRestaurantData();
                    searchController.queryInp.value = '';
                  }
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
                  hintText: Constants.search,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (searchController.isDataLoading.value)
                        const Center(child: CircularProgressIndicator())
                      else if (searchController.hasError.value)
                        LoadDataError(
                          title: Constants.problemOccurred,
                          subtitle: searchController.message,
                          bgColor: Colors.red,
                          onTap: () {
                            searchController.getListRestaurant();
                          },
                        )
                      else if (searchController.hasData.value)
                          searchController.listBodyRestaurants.isEmpty
                              ? buildNoDataView(context,Constants.noDataYet)
                              : buildRestaurantList(context, dynamicHeight)
                        else
                          buildNoDataView(context,Constants.noDataYet),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRestaurantList(BuildContext context, double dynamicHeight) {
    return Obx(
          () {
        if (searchController.isDataLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (searchController.hasError.value) {
          return Container(
            alignment: Alignment.topCenter,
            child: LoadDataError(
              title: Constants.problemOccurred,
              subtitle: searchController.message,
              bgColor: Colors.red,
              onTap: () {
                searchController.getListRestaurant();
              },
            ),
          );
        } else if (searchController.hasData.value) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: searchController.listBodyRestaurants.length,
            itemBuilder: (context, index) {
              var data = searchController.listBodyRestaurants[index];
              return InkWell(
                onTap: () {
                  Get.to(
                        () => DetailRestaurantScreen(
                      restaurantID: data[Constants.id],
                      restaurantNAME: data[Constants.name],
                      restaurantCITY: data[Constants.city],
                      restaurantDESCRIPTION: data[Constants.description],
                      restaurantPICTUREID: data[Constants.image],
                      restaurantRATING: data[Constants.rating].toString(),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.only(
                    left: 12,
                    right: 8,
                    top: 4,
                    bottom: 12,
                  ),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? CustomColors.jetColor
                      : CustomColors.lavenderColor,
                  elevation: 8,
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://restaurant-api.dicoding.dev/images/medium/${data[Constants.image]}',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                            ),
                          ),
                        ),
                      ),
                      AppSizes.wSizeBox15,
                      SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? CustomColors.darkOrange
                              : CustomColors.scarletColor,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  data[Constants.name],
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                        Brightness.dark
                                        ? CustomColors.orangePeel
                                        : CustomColors.darkOrange,
                                    fontSize: displayWidth(context) *
                                        FontSize.s0045,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Constants.helvetica,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Theme.of(context).brightness ==
                                      Brightness.dark
                                      ? CustomColors.greenRyb
                                      : CustomColors.scarletColor,
                                ),
                                AppSizes.wSizeBox8,
                                Text(
                                  data[Constants.city],
                                  style: TextStyle(
                                    fontSize: displayWidth(context) *
                                        FontSize.s0045,
                                    color: Theme.of(context).brightness ==
                                        Brightness.dark
                                        ? CustomColors.greenRyb
                                        : CustomColors.scarletColor,
                                  ),
                                ),
                              ],
                            ),
                            AppSizes.hSizeBox15,
                            Row(
                              children: [
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  itemSize:
                                  displayWidth(context) * FontSize.s005,
                                  initialRating:
                                  data[Constants.rating].toDouble(),
                                  glowColor: Colors.transparent,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Theme.of(context).brightness ==
                                        Brightness.dark
                                        ? CustomColors.goldColor
                                        : CustomColors.darkCornflowerBlue,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                                AppSizes.wSizeBox50,
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildNoDataView(BuildContext context, String message) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(JsonAssets.search),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.all(8),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: Text(
              message,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? CustomColors.orangePeel
                    : CustomColors.darkOrange,
                fontSize: displayWidth(context) * FontSize.s0045,
                fontWeight: FontWeight.bold,
                fontFamily: Constants.helvetica,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

