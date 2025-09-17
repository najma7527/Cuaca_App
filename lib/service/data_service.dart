import 'dart:convert';
import 'package:cuaca_app/model/weather.dart';
import 'package:http/http.dart' as http;

class DataService {
  Future<Weather> fetchData(String cityName) async {
    try {
      final queryParamaters = {
        'q': cityName,
        'appid': '2b888f2903b03f7acab3c7e3eea64988',
        'units': 'imperial',
      };
      final uri = Uri.https(
          'api.openweathermap.org', '/data/2.5/weather', queryParamaters);

      print('Fetching data for: $cityName');
      print('API URL: $uri');

      final response = await http.get(uri);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final weather = Weather.fromJson(jsonData);
        print('Parsed weather data: $weather');
        return weather;
      } else if (response.statusCode == 404) {
        throw Exception('Kota "$cityName" tidak ditemukan');
      } else if (response.statusCode == 401) {
        throw Exception('API Key tidak valid');
      } else {
        throw Exception('Gagal memuat data cuaca: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in fetchData: $e');
      rethrow;
    }
  }
}
