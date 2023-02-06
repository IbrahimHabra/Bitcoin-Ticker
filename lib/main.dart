import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coin Ticker',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.lightBlue,
      ),
      home: PriceScreen(),
    );
  }
}
