import 'package:flutter/material.dart';
import 'package:goodmeal/data/providers/weather_provider.dart';
import 'package:goodmeal/pages/details/details_page.dart';
import 'package:goodmeal/pages/home/home_page.dart';
import 'package:goodmeal/utils/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeatherProvider>(
      create: (_) => WeatherProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: CustomColors.white),
        home: PageView(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          children: [
            HomePage(),
            DetailsPage(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
