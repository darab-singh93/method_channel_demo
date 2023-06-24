import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practical_task/views/screens/home.dart';
import 'package:practical_task/views/screens/user_profile.dart';

import '../views/screens/random_image_screen.dart';

class RoutePath {
  static const String randomImage = "/bottomNav";
  static const String profile = "/profile";
  static const String home = "/home";
}

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.home:
        return CupertinoPageRoute(builder: (ctx) => const Home());
      case RoutePath.randomImage:
        return CupertinoPageRoute(builder: (ctx) => const RandomImageScreen());
      case RoutePath.profile:
        return CupertinoPageRoute(builder: (ctx) => const UserProfile());
      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
