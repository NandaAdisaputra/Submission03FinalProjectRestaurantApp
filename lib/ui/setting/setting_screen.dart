import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/ui/scheduling/controller/sheduling_controller.dart';

import '../../data/preferences/preferences_controller.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final PreferencesController preferencesController =
  Get.put(PreferencesController());
  final SchedulingController schedulingController =
  Get.put(SchedulingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PreferencesController>(
        builder: (controller) {
          return ListView(
            children: [
              ListTile(
                title: const Text(Constants.darkTheme),
                trailing: Switch.adaptive(
                  value: controller.isDarkTheme.value,
                  onChanged: (value) {
                    controller.enableDarkTheme(value);
                  },
                ),
              ),
              ListTile(
                title: const Text('Daily Restaurant Reminder'),
                trailing: GetBuilder<SchedulingController>(
                  builder: (scheduled) {
                    return Switch.adaptive(
                      value: preferencesController.isRestaurantDailyActive.value,
                      onChanged: (value) async {
                        scheduled.scheduledRestaurant(value);
                        controller.enableDailyRestaurant(value);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}