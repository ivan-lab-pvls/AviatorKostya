import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/travel_model.dart';

class SharedPrefsService {
  static const String _travelModelListKey = 'travelModelList';

  Future<void> saveTravelModelList(List<TravelModel> travelModelList) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonModelList =
        travelModelList.map((model) => model.toJson()).toList();
    await prefs.setString(_travelModelListKey, jsonEncode(jsonModelList));
  }

  Future<List<TravelModel>> getTravelModelList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonModelList = prefs.getString(_travelModelListKey);
    if (jsonModelList == null) {
      return [];
    }
    final decodedList = jsonDecode(jsonModelList) as List<dynamic>;
    return decodedList.map((model) => TravelModel.fromJson(model)).toList();
  }

  Future<void> clearTravelModelList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_travelModelListKey);
  }
}
