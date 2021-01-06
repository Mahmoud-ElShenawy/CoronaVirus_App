import 'package:coronavirus_app/models/global_summary_model.dart';
import 'package:coronavirus_app/view_models/global_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as TimeAgo;
import 'package:coronavirus_app/style/theme.dart' as Theme;

RegExp _reg = new RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))");
Function _mathFunc = (Match match) => '${match[1]}.';

class GlobalStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalSummaryModel _summaryList =
        Provider.of<GlobalViewModel>(context, listen: false).globalSummaryList;
    return Column(
      children: <Widget>[
        _buildCard(
          'CONFIRMED',
          _summaryList.totalConfirmed,
          _summaryList.newConfirmed,
          Theme.Colors.kConfirmedColor,
        ),
        _buildCard(
          'ACTIVE',
          _summaryList.totalConfirmed - _summaryList.totalRecovered - _summaryList.totalDeaths,
          _summaryList.newConfirmed - _summaryList.newRecovered - _summaryList.newDeaths,
          Theme.Colors.kActiveColor,
        ),
        _buildCard(
          'RECOVERED',
          _summaryList.totalRecovered,
          _summaryList.newRecovered,
          Theme.Colors.kRecoveredColor,
        ),
        _buildCard(
          'DEATH',
          _summaryList.totalDeaths,
          _summaryList.newDeaths,
          Theme.Colors.kDeathColor,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 4,
          ),
          child: Text(
            'Statistics updated ' + TimeAgo.format(_summaryList.dateTime),
            style: TextStyle(
              color: Theme.Colors.kAmberAccent,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildCard(String title, int totalCount, int todayCount, Color color) {
  return Card(
    elevation: 1,
    child: Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Theme.Colors.kGreyPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    totalCount.toString().replaceAllMapped(_reg, _mathFunc),
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Today',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    todayCount.toString().replaceAllMapped(_reg, _mathFunc),
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}
