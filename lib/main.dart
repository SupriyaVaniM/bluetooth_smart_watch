import 'package:flutter/material.dart';
import 'package:smart_wear/src/core/injection_conatiner.dart' as s1;
import 'package:smart_wear/src/features/devices/presentation/widgets/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await s1.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}