import 'package:flutter/material.dart';
import 'package:practical_task/providers/bluetooth_operations_provider.dart';
import 'package:practical_task/providers/profile_provider.dart';
import 'package:practical_task/providers/random_image_provider.dart';
import 'package:practical_task/routes/route_path.dart';
import 'package:practical_task/utils/string_utils.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RandomImageProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => BluetoothOperationsProvider()),
      ],
      child: MaterialApp(
        title: StringUtils.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: Routers.generateRoute,
        initialRoute: RoutePath.home,
      ),
    );
  }
}
