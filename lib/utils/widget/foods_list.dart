import 'package:flutter/material.dart';
import 'package:submission3nanda/data/model/detail_restaurant.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';
import 'package:submission3nanda/utils/resource_helper/fonts.dart';
import 'package:submission3nanda/utils/resource_helper/sizes.dart';

class FoodsList extends StatelessWidget {
  final List<Category> foods;

  const FoodsList({super.key, required this.foods});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: foods.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: Card(
              elevation: 8,
              margin: const EdgeInsets.all(8),
              shadowColor: CustomColors.OrangePeel,
              color: Theme.of(context).brightness == Brightness.dark
                  ? CustomColors.SpanishViridian
                  : CustomColors.Scarlet,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              semanticContainer: true,
              surfaceTintColor: CustomColors.RoyalBlueDark,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  foods[index].name,
                  style: TextStyle(
                      color:
                      Theme.of(context).brightness ==
                          Brightness.dark
                          ? CustomColors.White
                          : CustomColors.MiddleYellow,
                      fontSize: displayWidth(context) *
                          FontSize.s0045,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
