import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:goodmeal/data/providers/weather_provider.dart';
import 'package:goodmeal/pages/widget/survise_visual/sunrise_sunset.dart';
import 'package:goodmeal/utils/colors.dart';
import 'package:goodmeal/utils/datetime.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: CustomColors.white,
        body: Consumer<WeatherProvider>(
          builder: (context, provider, child) {
            if (!provider.isWeatherAvailable)
              return Center(
                child: Text(
                  "Aun no hay informacion",
                  style: TextStyle(
                    color: CustomColors.gray,
                    fontSize: 20.0,
                  ),
                ),
              );
            return Container(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 45.0, bottom: 20.0),
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Esta semana",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CustomColors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .50,
                    child: ListView.builder(
                        itemCount: 7,
                        padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Text(
                                    provider
                                        .weeklyWeather.weather[index].weekDay,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: CustomColors.black,
                                    ),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    provider
                                        .weeklyWeather.weather[index].dayTemp,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: CustomColors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              Expanded(
                                flex: 6,
                                child: Row(
                                  children: [
                                    Image(
                                        image: NetworkImage(provider
                                            .weeklyWeather
                                            .weather[index]
                                            .weatherIconURL)),
                                    SizedBox(width: 10.0),
                                    Text(
                                      provider.weeklyWeather.weather[index]
                                          .weatherDescription,
                                      style: TextStyle(
                                        color: CustomColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Sol",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CustomColors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                      child: SunriseSunset(
                    sunRise: provider.weeklyWeather.weather[0].sunriseTime,
                    sunSet: provider.weeklyWeather.weather[0].sunsetTime,
                    coverPercent: getPercentCover(
                        dateTime: provider.weeklyWeather.currentDateTime,
                        minDateTime:
                            provider.weeklyWeather.weather[0].sunriseDateTime,
                        maxDateTime:
                            provider.weeklyWeather.weather[0].sunsetDateTime),
                  )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
