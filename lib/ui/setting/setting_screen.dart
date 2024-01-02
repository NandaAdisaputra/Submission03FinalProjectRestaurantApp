import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/preferences/preferences.dart';
import 'package:submission3nanda/ui/scheduling/sheduling_controller.dart';

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
              Material(
                child: ListTile(
                  title: const Text('Dark Theme'),
                  trailing: Switch.adaptive(
                    value: controller.isDarkTheme.value,
                    onChanged: (value) {
                      controller.enableDarkTheme(value);
                    },
                  ),
                ),
              ),
              Material(
                child: ListTile(
                  title: const Text('Daily Restaurant Reminder'),
                  trailing: GetBuilder<SchedulingController>(
                    builder: (scheduled) {
                      return Switch.adaptive(
                        value: controller.isRestaurantDailyActive.value,
                        onChanged: (value) async {
                          scheduled.scheduledRestaurant(value);
                          controller.enableDailyRestaurant(value);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
