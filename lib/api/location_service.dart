import 'package:dio/dio.dart';
import 'dart:developer';

const String country = "/countries";
const String state = "/states";
const String city = "/cities";
const String API_KEY = "bWxLejVmcWtRSTg1ekRyaXlKZ3l1YjN2MHI1OFBwUWVDYkVCbWNNVw==";

//ignore_for_file: empty_catches


class Pair {
  String key;
  String value;

  Pair({required this.key, required this.value});
}

final Dio dio = Dio(BaseOptions(
  baseUrl: "https://api.countrystatecity.in/v1",
  receiveTimeout: const Duration(minutes: 2),
  connectTimeout: const Duration(minutes: 2),
  sendTimeout: const Duration(minutes: 2),
));

Future<List<Pair>> getCountriesMap() async {
  List<Pair> countries = [];

  try {
    Response response = await dio.get(country,
        options: Options(headers: {'X-CSCAPI-KEY': API_KEY}));

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      List<dynamic> data = response.data as List<dynamic>;
      for (var c in data) {
        String name = c["name"];
        String code = c["iso2"];
        countries.add(Pair(key: name, value: code));
      }
    }
  } catch (e) {
    log(e.toString());
  }
  return countries;
}

Future<List<Pair>> getStatesMap(String countryID) async {
  List<Pair> states = [];

  try {
    Response response = await dio.get("$country/$countryID$state",
        options: Options(headers: {"X-CSCAPI-KEY": API_KEY}));

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      List<dynamic> data = response.data as List<dynamic>;
      for (var c in data) {
        String name = c["name"];
        String code = c["iso2"];
        states.add(Pair(key: name, value: code));
      }
    }
  } catch (e) {}
  return states;
}

Future<List<Pair>> getCitiesMap(String countryID, String stateID) async {
  List<Pair> cities = [];
  try {
    Response response = await dio.get("$country/$countryID$state/$stateID$city",
        options: Options(headers: {"X-CSCAPI-KEY": API_KEY}));

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      List<dynamic> data = response.data as List<dynamic>;
      for (var c in data) {
        String name = c["name"];
        String code = (c["id"] as num).toString();
        cities.add(Pair(key: name, value: code));
      }
    }
  } catch (e) {}

  return cities;
}
