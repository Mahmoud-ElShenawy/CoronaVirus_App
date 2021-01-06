import 'package:coronavirus_app/models/country_model.dart';
import 'package:coronavirus_app/models/country_summary_model.dart';
import 'package:coronavirus_app/services/coronavirus_api.dart';
import 'package:flutter/foundation.dart';

// Created By Mahmoud El Shenawy (Email : Mr.Mahmoud.El.Shenawy@Gmail.com)

class CountryViewModel extends ChangeNotifier {
  List<CountryModel> _countryList = [];
  List<CountrySummaryModel> _countrySummaryList = [];

  Future<List<CountryModel>> fetchCountryList() async {
    return _countryList = await CoronaVirusApi().fetchCountryList();
  }

  Future<List<CountrySummaryModel>> fetchCountrySummaryList(String slug) async {
    return _countrySummaryList = await CoronaVirusApi().fetchCountrySummary(slug);
  }

  List<String> fetchSuggestions(List<CountryModel> list, String query){
    List<String> _matches = List();
    for(var item in list){
      _matches.add(item.country);
    }
    _matches.retainWhere((element) => element.toLowerCase().contains(query.toLowerCase()));
    return _matches;
  }

  List<CountrySummaryModel> get countrySummaryList => _countrySummaryList;

  List<CountryModel> get countryList => _countryList;
}
