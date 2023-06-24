import 'package:flutter/material.dart';
import '../services/http_service.dart';

class BluetoothOperationsProvider with ChangeNotifier {
  final HttpService _httpService = HttpService();

  Future<void> callBluetoothEnable() async {
    await _httpService.enableBluetooth();
  }
}