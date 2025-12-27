import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

const String apiKey = "366cb077178c47c88db182907252512";

class WeatherApiService {
  final String _baseUrl = "https://api.weatherapi.com/v1";

  Future<Map<String, dynamic>> getHourlyForecast(String location) async {
    final url = Uri.parse(
      "$_baseUrl/forecast.json?key=$apiKey&q=$location&days=7",
    );

    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception("Failed to fetch data: ${res.body}");
    }

    final data = jsonDecode(res.body);

    if (data.containsKey('error')) {
      throw Exception(data['error']['message']);
    }

    return data;
  }

  Future<List<Map<String, dynamic>>> getpastSevenDaysWerther(
    String location,
  ) async {
    final List<Map<String, dynamic>> pastWeather = [];
    final today = DateTime.now();

    for (int i = 1; i <= 7; i++) {
      final date = today.subtract(Duration(days: i));
      final formattedDate =
          "${date.year}-${date.month.toString().padLeft(2, "0")}-${date.day.toString().padLeft(2, "0")}";

      final url = Uri.parse(
        "$_baseUrl/history.json?key=$apiKey&q=$location&dt=$formattedDate",
      );

      final res = await http.get(url);

      if (res.statusCode != 200) continue;

      final Map<String, dynamic> data = jsonDecode(res.body);

      if (data.containsKey('error')) continue;

      pastWeather.add(data);
    }
    return pastWeather;
  }
}
