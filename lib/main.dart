import 'package:flutter/material.dart';
import 'my_app/my_app.dart';
import 'my_app/setup.dart';

void main()async{
  await setup();
  runApp(const MyApp());
}
