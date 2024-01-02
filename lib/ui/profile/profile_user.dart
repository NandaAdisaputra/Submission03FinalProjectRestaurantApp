import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/base/components/sliver_delegate.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/ui/profile/profile_user_controller.dart';
import 'package:submission3nanda/ui/search/search_restaurant.dart';
import 'package:submission3nanda/utils/resource_helper/assets.dart';
import 'package:submission3nanda/utils/resource_helper/sizes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/resource_helper/colors.dart';
import '../../utils/resource_helper/fonts.dart';

var profileUsers = Get.put(ProfileUserController());

class ProfileUserScreen extends GetView<ProfileUserController> {
  const ProfileUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(ImageAssets.imageLeading),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Tooltip(
              message: Constants.search,
              child: Material(
                color: Theme.of(context).brightness == Brightness.dark
                    ? CustomColors.Jet
                    : CustomColors.DarkOrange,
                child: InkWell(
                  onTap: () => Get.to(
                    const SearchScreen(),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              minHeight: 50,
              maxHeight: 50,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  Constants.detailProfile,
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? CustomColors.White
                          : CustomColors.DarkOrange,
                      fontFamily: Constants.helvetica,
                      fontSize: displayWidth(context) * FontSize.s005),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 24),
              child: Image(
                  image: AssetImage('assets/images/profile.png'),
                  width: 150,
                  height: 150),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          const SliverToBoxAdapter(
            child: Center(
              child: Text(
                Constants.nameProfile,
                style: TextStyle(
                    color: CustomColors.OrangePeel,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                Constants.descriptionProfile,
                maxLines: 10,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: CustomColors.OrangePeel),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 40,
              margin: const EdgeInsets.all(8),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? CustomColors.Jet
                              : CustomColors.DarkOrange),
                  onPressed: () {
                    launchUrlStart(
                        url: "https://www.linkedin.com/in/nandaadisaputra/");
                  },
                  child: Text(
                    Constants.visitLinkedin,
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? CustomColors.White
                            : CustomColors.White,
                        fontFamily: Constants.helvetica,
                        fontSize: displayWidth(context) * FontSize.s005),
                  )),
            ),
          )
        ],
      ),
    );
  }

  Future<void> launchUrlStart({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
