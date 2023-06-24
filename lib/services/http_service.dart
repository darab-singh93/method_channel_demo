import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:practical_task/models/random_image.dart';
import 'package:practical_task/services/web_service.dart';
import 'package:practical_task/utils/http_log.dart';
import '../models/profile_details.dart';


class HttpService {
  final http.Client? httpClient;
  HttpService({this.httpClient});

  // Method channel name
  static const platform = MethodChannel('bluetooth_channel');

  // Function to enable bluetooth
  Future<void> enableBluetooth() async {
    try {
      await platform.invokeMethod('enableBluetooth');
      log('Bluetooth enabled successfully.');
    } catch (e) {
      log('Failed to enable Bluetooth: $e');
    }
  }

//  Call profile details
  Future<ProfileDetails?> callProfileDetails() async {
    try {
      final response = await http.get(Uri.parse(WebService.profile));
      HttpLog.displayResponse(res: response, requestType: "GET");
      return profileDetailsFromJson(response.body);
    } catch (e) {
      log("Exception: $e", name: "callProfileDetails");
      return null;
    }
  }

  //  Call random image
  Future<RandomImage?> callRandomImage() async {
    try {
      final response = await http.get(Uri.parse(WebService.randomImage));
      HttpLog.displayResponse(res: response, requestType: "GET");
      return randomImageFromJson(response.body);
    } catch (e) {
      log("Exception: $e", name: "callRandomImage");
      return null;
    }
  }
}
