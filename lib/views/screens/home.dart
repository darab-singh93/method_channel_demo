import 'package:flutter/material.dart';
import 'package:practical_task/providers/bluetooth_operations_provider.dart';
import 'package:practical_task/providers/profile_provider.dart';
import 'package:practical_task/utils/string_utils.dart';
import 'package:practical_task/views/shared/appbar.dart';
import 'package:provider/provider.dart';
import '../../providers/random_image_provider.dart';
import '../shared/home_button.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget homeButtonsWidget() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HomeButton(
            buttonLabel: StringUtils.randomImages,
            onPress: () {
              var ref =
                  Provider.of<RandomImageProvider>(context, listen: false);
              ref.goToRandomImagesScreen(context);
            },
          ),
          HomeButton(
            buttonLabel: StringUtils.enableBluetooth,
            onPress: () {
              final ref = Provider.of<BluetoothOperationsProvider>(context,
                  listen: false);
              ref.callBluetoothEnable();
            },
          ),
          HomeButton(
            buttonLabel: StringUtils.profile,
            onPress: () {
              var ref = Provider.of<ProfileProvider>(context, listen: false);
              ref.goToProfileScreen(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: StringUtils.appName, back: false),
      body: homeButtonsWidget(),
    );
  }
}
