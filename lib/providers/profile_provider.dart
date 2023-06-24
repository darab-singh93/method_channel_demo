import 'package:flutter/material.dart';
import 'package:practical_task/models/profile_details.dart';
import 'package:practical_task/services/http_service.dart';
import '../routes/route_path.dart';

class ProfileProvider with ChangeNotifier {
  final HttpService _httpService = HttpService();
  ProfileDetails? profileDetails;
  bool loading = true;

  // Get profile details to provider
  Future<ProfileDetails?> getProfile() async {
    profileDetails = null;
    loading = true;
    Future.delayed(const Duration(milliseconds: 200), () async {
      profileDetails = await _httpService.callProfileDetails();
      loading = false;
      notifyListeners();
    });
    notifyListeners();
    return profileDetails;
  }

  goToProfileScreen(BuildContext context) {
    Navigator.pushNamed(context, RoutePath.profile);
  }
}
