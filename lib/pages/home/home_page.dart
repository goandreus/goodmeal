import 'package:flutter/material.dart';
import 'package:goodmeal/data/models/weather.dart';
import 'package:goodmeal/data/providers/weather_provider.dart';
import 'package:goodmeal/pages/widget/bottom_row.dart';
import 'package:goodmeal/pages/widget/graph/custom_graph.dart';
import 'package:goodmeal/utils/colors.dart';
import 'package:provider/provider.dart';

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
        backgroundColor: CustomColors.white,
        appBar: AppBar(
          toolbarHeight: 90.0,
          title: Container(
            padding: EdgeInsets.only(top: 25.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<WeatherProvider>(builder: (context, provider, child) {
                  String hintText = provider.isWeatherAvailable
                      ? provider.weeklyWeather.city
                      : "Ingresa tu ciudad ...";
                  return TextField(
                    textAlign: TextAlign.center,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: CustomColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: hintText,
                    ),
                    onSubmitted: (value) {
                      print("entro $value");
                      provider.fetchWeatherAction(value);
                    },
                  );
                }),
              ],
            ),
          ),
          elevation: 0.0,
        ),
        body: Consumer<WeatherProvider>(
          builder: (context, provider, child) {
            if (!provider.isWeatherAvailable)
              return Center(
                child: Text(
                  "Aun no tengo informacion",
                  style: TextStyle(
                    color: CustomColors.gray,
                    fontSize: 20.0,
                  ),
                ),
              );

            String suitableTemp = (() {
              var partOfDay = provider.weeklyWeather.partOfDay;
              if (partOfDay == PartOfDay.morning)
                return provider.weeklyWeather.weather[0].morningTemp;
              if (partOfDay == PartOfDay.day)
                return provider.weeklyWeather.weather[0].dayTemp;
              if (partOfDay == PartOfDay.evening)
                return provider.weeklyWeather.weather[0].eveningTemp;
              return provider.weeklyWeather.weather[0].nightTemp;
            })();

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
                      color: CustomColors.black,
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
                      color: CustomColors.black,
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
                            color: CustomColors.black,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          provider.weeklyWeather.weather[0].weatherDescription,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: CustomColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildGraph(
                      dataY: [
                        provider.weeklyWeather.weather[0].morningTempValue
                            .round(),
                        provider.weeklyWeather.weather[0].dayTempValue.round(),
                        provider.weeklyWeather.weather[0].eveningTempValue
                            .round(),
                        provider.weeklyWeather.weather[0].nightTempValue
                            .round(),
                      ],
                      labelTexts: [
                        "Mañana",
                        "Dia",
                        "Tarde",
                        "Noche",
                      ],
                      labelImageUrls: [
                        provider.weeklyWeather.weather[0].weatherIconURL,
                        provider.weeklyWeather.weather[0].weatherIconURL,
                        provider.weeklyWeather.weather[0].weatherIconURL,
                        provider.weeklyWeather.weather[0].weatherIconURL,
                      ],
                      highlightedIndex: (() {
                        final partsOfDay = [
                          PartOfDay.morning,
                          PartOfDay.day,
                          PartOfDay.evening,
                          PartOfDay.night
                        ];
                        return partsOfDay
                            .indexOf(provider.weeklyWeather.partOfDay);
                      })()),
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
