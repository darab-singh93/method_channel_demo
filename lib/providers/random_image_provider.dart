import 'package:flutter/material.dart';
import 'package:practical_task/models/random_image.dart';
import 'package:practical_task/routes/route_path.dart';
import '../services/http_service.dart';

class RandomImageProvider with ChangeNotifier {
  final HttpService _httpService = HttpService();
  RandomImage? randomImage;
  bool loading = true;

  // Get random image to provider
  Future<RandomImage?> getRefreshImage() async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 200), () async {
      randomImage = await _httpService.callRandomImage();
      loading = false;
      notifyListeners();
    });
    notifyListeners();
    return randomImage;
  }

  goToRandomImagesScreen(BuildContext context) {
    Navigator.pushNamed(context, RoutePath.randomImage);
  }
}
