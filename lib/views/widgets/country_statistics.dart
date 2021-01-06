import 'package:coronavirus_app/models/country_summary_model.dart';
import 'package:coronavirus_app/models/time_cases_model.dart';
import 'package:coronavirus_app/views/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as Charts;
import 'package:coronavirus_app/style/theme.dart' as Theme;

// Created By Mahmoud El Shenawy (Email : Mr.Mahmoud.El.Shenawy@Gmail.com)

RegExp _reg = new RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))");
Function _mathFunc = (Match match) => '${match[1]}.';

class CountryStatistics extends StatelessWidget {
  final List<CountrySummaryModel> summaryList;

  CountryStatistics({@required this.summaryList});

  @override
  Widget build(BuildContext context) {
    var summary = summaryList[summaryList.length - 1];
    return Column(
      children: [
        _buildCard(
          'ACTIVE',
          'CONFIRMED',
          summary.active,
          summary.confirmed,
          Theme.Colors.kActiveColor,
          Theme.Colors.kConfirmedColor,
        ),
        _buildCard(
          'DEATH',
          'RECOVERED',
          summary.deaths,
          summary.recovered,
          Theme.Colors.kDeathColor,
          Theme.Colors.kRecoveredColor,
        ),
        _buildCardChart(summaryList),
      ],
    );
  }
}

Widget _buildCard(String rightTitle, String leftTitle, int rightValue,
    int leftValue, Color rightColor, Color leftColor) {
  return Card(
    elevation: 1,
    child: Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                leftTitle,
                style: TextStyle(
                  color: Theme.Colors.kGreyPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                'Total',
                style: TextStyle(
                  color: leftColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                leftValue.toString().replaceAllMapped(_reg, _mathFunc),
                style: TextStyle(
                  color: leftColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                rightTitle,
                style: TextStyle(
                  color: Theme.Colors.kGreyPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                'Total',
                style: TextStyle(
                  color: rightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                rightValue.toString().replaceAllMapped(_reg, _mathFunc),
                style: TextStyle(
                  color: rightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildCardChart(List<CountrySummaryModel> summaryList) {
  return Card(
    elevation: 1,
    child: Container(
      height: 190,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Chart(
        getCreateData(summaryList),
        animate: false,
      ),
    ),
  );
}

List<Charts.Series<TimeCasesModel, DateTime>> getCreateData(
    List<CountrySummaryModel> summaryList) {
  List<TimeCasesModel> confirmedData = [];
  List<TimeCasesModel> activeData = [];
  List<TimeCasesModel> recoveredData = [];
  List<TimeCasesModel> deathData = [];
  for (var item in summaryList) {
    confirmedData
        .add(TimeCasesModel(dateTime: item.dateTime, cases: item.confirmed));
    activeData.add(TimeCasesModel(dateTime: item.dateTime, cases: item.active));
    recoveredData
        .add(TimeCasesModel(dateTime: item.dateTime, cases: item.recovered));
    deathData.add(TimeCasesModel(dateTime: item.dateTime, cases: item.deaths));
  }
  return [
    Charts.Series<TimeCasesModel, DateTime>(
      id: 'Confirmed',
      data: confirmedData,
      domainFn: (TimeCasesModel cases, _) => cases.dateTime,
      measureFn: (TimeCasesModel cases, _) => cases.cases,
    ),
    Charts.Series<TimeCasesModel, DateTime>(
      id: 'Active',
      data: activeData,
      domainFn: (TimeCasesModel cases, _) => cases.dateTime,
      measureFn: (TimeCasesModel cases, _) => cases.cases,
      colorFn: (_, __) =>
          Charts.ColorUtil.fromDartColor(Theme.Colors.kConfirmedColor),
    ),
    Charts.Series<TimeCasesModel, DateTime>(
      id: 'Recovered',
      data: recoveredData,
      domainFn: (TimeCasesModel cases, _) => cases.dateTime,
      measureFn: (TimeCasesModel cases, _) => cases.cases,
      colorFn: (_, __) =>
          Charts.ColorUtil.fromDartColor(Theme.Colors.kRecoveredColor),
    ),
    Charts.Series<TimeCasesModel, DateTime>(
      id: 'Death',
      data: deathData,
      domainFn: (TimeCasesModel cases, _) => cases.dateTime,
      measureFn: (TimeCasesModel cases, _) => cases.cases,
      colorFn: (_, __) =>
          Charts.ColorUtil.fromDartColor(Theme.Colors.kDeathColor),
    ),
  ];
}
