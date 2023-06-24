import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpLog {
  HttpLog.displayResponse({payload, http.Response? res, String? requestType}) {
    if (kDebugMode) {
      if (payload != null) log("payload:- $payload", name: "Http Log");
      if (res != null) {
        log("headers: ${res.headers}", name: "Http Log");
        logWrapped(res.request!.url.toString());
        if (requestType != null) {
          log("requestType:- $requestType", name: "Http Log");
        }
        log("statusCode:- ${res.statusCode}", name: "Http Log");
        log("response:- ${res.body}", name: "Http Log");
      } else {
        log("Log Response is: $res", name: "Http Log");
      }
    } else {
      log("App is not in debug mode", name: "Http Log");
    }
  }
  // Used to log response when response length is large
  void logWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach(
            (match) => log("logWrapped:- ${match.group(0)}", name: "Http Log"));
  }
}