import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../open_meteo_api.dart';

/// Exception thrown when lcoationSearch fails.
class LocationRequestFailure implements Exception {}

/// Exception thrown when lcoationSearch fails.
class LocationNotFoundFailure implements Exception {}

/// Exception thrown when lcoationSearch fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when lcoationSearch fails.
class WeatherNotFoundFailure implements Exception {}

/// {@template open_meteo_api_client}
/// Dart API Client which wraps the [Open Meteo API](https://open-meteo.com)
/// {@endtemplate}
class OpenMeteoApiClient {
  final http.Client _httpClient;

  static const _baseUrlWeather = 'api.open-meteo.com';
  static const _baseUrlGeocoding = 'geocoding-api.open-meteo.com';

  /// {@macro open_meteo_api_client}
  OpenMeteoApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

// `locationSearch` returns `Future<Location>`
// `getWeather` returns `Future<Weather>`

// Finds a [Location]
// v1/search/?name=(query)

  Future<Location> locationSearch(String query) async {
    final locationRequest = Uri.https(
      _baseUrlGeocoding,
      '/v1/search',
      {'name': query, 'count': '1'},
    );

    final locationResponse = await _httpClient.get(locationRequest);

    if (locationResponse.statusCode != 200) {
      throw LocationRequestFailure();
    }

    final json = jsonDecode(locationResponse.body) as Map;

    if (!json.containsKey('results')) throw LocationNotFoundFailure();

    final results = json['results'] as List;

    if (results.isEmpty) throw LocationNotFoundFailure();

    return Location.fromJson(results.first as Map<String, dynamic>);
  }

  /// Fetch [Weather] for a given [latitude] and [longitude]
  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    final request = Uri.https(_baseUrlWeather, '/v1/forest', {
      'latitude': '$latitude',
      'longitude': '$longitude',
      'current_weather': 'true',
    });

    final response = await _httpClient.get(request);

    if (response.statusCode != 200) throw WeatherRequestFailure();

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (!json.containsKey('current_weather')) throw WeatherNotFoundFailure();

    final weatherJson = json['current_weather'] as Map<String, dynamic>;

    return Weather.fromJson(weatherJson);
  }
}
