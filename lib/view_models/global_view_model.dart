import 'package:coronavirus_app/models/global_summary_model.dart';
import 'package:coronavirus_app/services/coronavirus_api.dart';
import 'package:flutter/foundation.dart';

// Created By Mahmoud El Shenawy (Email : Mr.Mahmoud.El.Shenawy@Gmail.com)

class GlobalViewModel extends ChangeNotifier {
  GlobalSummaryModel _globalSummaryList;

  Future<GlobalSummaryModel> fetchGlobalSummary() async {
    return _globalSummaryList = await CoronaVirusApi().getGlobalSummary();
  }

  GlobalSummaryModel get globalSummaryList => _globalSummaryList;
}
