import 'package:charts_flutter/flutter.dart' as Charts;
import 'package:coronavirus_app/models/time_cases_model.dart';
import 'package:flutter/material.dart';

// Created By Mahmoud El Shenawy (Email : Mr.Mahmoud.El.Shenawy@Gmail.com)

class Chart extends StatelessWidget {
  final List<Charts.Series<TimeCasesModel, DateTime>> seriesList;
  final bool animate;

  Chart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return Charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      domainAxis: Charts.EndPointsTimeAxisSpec(),
    );
  }
}
