import 'package:coronavirus_app/models/country_model.dart';
import 'package:coronavirus_app/models/country_summary_model.dart';
import 'package:http/http.dart' as http;
import 'package:coronavirus_app/services/constants.dart' as Constants;
import 'dart:convert';
import 'package:coronavirus_app/models/global_summary_model.dart';

// Created By Mahmoud El Shenawy (Email : Mr.Mahmoud.El.Shenawy@Gmail.com)

class CoronaVirusApi {
  Future<GlobalSummaryModel> getGlobalSummary() async {
    try {
      http.Response response =
          await http.get(Constants.Constants.globalSummaryCases);
      if (response.statusCode == 200) {
        var data = response.body;
        var jsonData = jsonDecode(data);
        GlobalSummaryModel summary = GlobalSummaryModel.fromJson(jsonData);
        return summary;
      } else {
        print('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<CountrySummaryModel>> fetchCountrySummary(String slug) async {
    try {
      http.Response response = await http
          .get(Constants.Constants.countrySummaryCases + slug);
      if (response.statusCode == 200) {
        var data = response.body;
        var jsonData = jsonDecode(data);
        List<CountrySummaryModel> summaryList = (jsonData as List)
            .map((item) => CountrySummaryModel.fromJson(item))
            .toList();
        return summaryList;
      } else {
        print('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<CountryModel>> fetchCountryList() async {
    try {
      http.Response response =
          await http.get(Constants.Constants.countryCases);
      if (response.statusCode == 200) {
        var data = response.body;
        var jsonData = jsonDecode(data);
        List<CountryModel> countries = (jsonData as List)
            .map((item) => CountryModel.fromJson(item))
            .toList();
        return countries;
      } else {
        print('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}
