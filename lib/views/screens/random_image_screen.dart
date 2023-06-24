import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practical_task/providers/random_image_provider.dart';
import 'package:practical_task/utils/string_utils.dart';
import 'package:practical_task/views/shared/appbar.dart';
import 'package:provider/provider.dart';
import '../shared/home_button.dart';

class RandomImageScreen extends StatefulWidget {
  const RandomImageScreen({Key? key}) : super(key: key);

  @override
  State<RandomImageScreen> createState() => _RandomImageScreenState();
}

class _RandomImageScreenState extends State<RandomImageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final ref = Provider.of<RandomImageProvider>(context, listen: false);
      ref.getRefreshImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    var listenPro = Provider.of<RandomImageProvider>(context, listen: true);
    return Scaffold(
      appBar: customAppBar(title: StringUtils.randomImages, back: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              listenPro.loading
                  ? const SizedBox(
                      height: 400.0, child: CupertinoActivityIndicator())
                  : Image.network(
                      listenPro.randomImage!.message,
                      fit: BoxFit.fitHeight,
                      height: 400.0,
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: HomeButton(
                  onPress: () {
                    final ref = Provider.of<RandomImageProvider>(context,
                        listen: false);
                    ref.getRefreshImage();
                  },
                  buttonLabel: StringUtils.refresh,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
