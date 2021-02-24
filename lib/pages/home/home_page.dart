import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90.0,
          title: Container(
            padding: EdgeInsets.only(top: 25.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            ),
          ),
          elevation: 0.0,
        ),
        body: Consumer<WeatherProvider>(
          builder: (context, provider, child) {
            if (!provider.isWeatherAvailable)
              return Center(
                child: Text(
                  "I don't have any information yet!",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              );

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    provider.weeklyWeather.currentTime,
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    provider.weeklyWeather.date,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: NetworkImage(provider
                              .weeklyWeather.weather[0].bigWeatherIconURL),
                        ),
                        Text(
                          suitableTemp,
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          provider.weeklyWeather.weather[0].weatherDescription,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BottomRow(
                    humidity: provider.weeklyWeather.weather[0].humidity,
                    pressure: provider.weeklyWeather.weather[0].pressure,
                    wind: provider.weeklyWeather.weather[0].wind,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
