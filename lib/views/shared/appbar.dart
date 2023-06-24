import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar({required String title, required bool back}){
  return AppBar(
    title: Text(title),
    automaticallyImplyLeading: back,
    centerTitle: true,
  );
}
