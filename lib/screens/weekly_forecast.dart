import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeeklyForecast extends StatefulWidget {
  final Map<String, dynamic> currentValue;
  final String city;
  final List<dynamic> pastweek;
  final List<dynamic> next7days;
  const WeeklyForecast({
    super.key,
    required this.city,
    required this.currentValue,
    required this.pastweek,
    required this.next7days,
  });

  @override
  State<WeeklyForecast> createState() => _WeeklyForecastState();
}

class _WeeklyForecastState extends State<WeeklyForecast> {
  String formatApiData(String dataString) {
    DateTime date = DateTime.parse(dataString);
    return DateFormat('d MMMM, EEEE').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Your weekly forecast UI components go here
              Center(
                child: Column(
                  children: [
                    Text(
                      widget.city,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 40,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    Text(
                      "${widget.currentValue['temp_c']}°C",
                      style: TextStyle(
                        fontSize: 50,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${widget.currentValue['condition']?['text'] ?? ''}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Image.network(
                      "https:${widget.currentValue['condition']?['icon'] ?? ''}",
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              // Next 7 days forecast
              SizedBox(height: 20),
              Text(
                "Next 7 Days Forecast",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 10),
              ...widget.next7days.map((day) {
                final data = day['date'] ?? "";
                final condition = day['day']?['condition']?['text'] ?? "";
                final icon = day['day']?['condition']?['icon'] ?? "";
                final maxTemp = day['day']?['maxtemp_c'] ?? "";
                final minTemp = day['day']?['mintemp_c'] ?? "";
                return ListTile(
                  leading: Image.network("https:$icon", width: 50),
                  title: Text(
                    formatApiData(data),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  subtitle: Text(
                    "$condition $minTemp°C - $maxTemp°C",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                );
              }),
              // Next 7 days forecast
              SizedBox(height: 20),
              Text(
                "Previous 7 Days Forecast",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 10),
              ...widget.pastweek.map((day) {
                final forecastDay = day['forecast']?['forecastday'];
                if (forecastDay == null || forecastDay.isEmpty) {
                  return SizedBox.shrink(); // Skip if no data
                }
                final forecast = forecastDay[0];
                final data = forecast['date'] ?? "";
                final condition = forecast['day']?['condition']?['text'] ?? "";
                final icon = forecast['day']?['condition']?['icon'] ?? "";
                final maxTemp = forecast['day']?['maxtemp_c'] ?? "";
                final minTemp = forecast['day']?['mintemp_c'] ?? "";
                return ListTile(
                  leading: Image.network("https:$icon", width: 50),
                  title: Text(
                    formatApiData(data),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  subtitle: Text(
                    "$condition $minTemp°C - $maxTemp°C",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
