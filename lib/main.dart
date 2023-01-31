import 'package:eight/screens/food_screen.dart';
import 'package:eight/screens/home_screen.dart';
import 'package:eight/screens/map.dart';
import 'package:eight/screens/order_screen.dart';
import 'package:eight/screens/order_status.dart';
import 'package:eight/widget/cart_widget.dart';
import 'package:eight/widget/wlocation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '8',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const HomeScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/foodscreen': (context) => FoodScreen(),
        '/map': (context) => LocationMap(),
        '/orderscreen' : (context) => OrderScreen(),
      },
    );
  }
}
