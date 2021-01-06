import 'package:coronavirus_app/models/global_summary_model.dart';
import 'package:coronavirus_app/view_models/global_view_model.dart';
import 'package:coronavirus_app/views/widgets/global_loading.dart';
import 'package:coronavirus_app/views/widgets/global_statistics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coronavirus_app/style/theme.dart' as Theme;

// Created By Mahmoud El Shenawy (Email : Mr.Mahmoud.El.Shenawy@Gmail.com)

class GlobalScreen extends StatefulWidget {
  @override
  _GlobalScreenState createState() => _GlobalScreenState();
}

class _GlobalScreenState extends State<GlobalScreen> {
  @override
  Widget build(BuildContext context) {
    Future<GlobalSummaryModel> _summaryList =
        Provider.of<GlobalViewModel>(context, listen: false).fetchGlobalSummary();
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: Container(
              color: Theme.Colors.kDeepOrange700,
              child: Text(
                'Stay Home - Stay Save',
                style: TextStyle(
                  color: Theme.Colors.kWhite,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Corona Virus Cases Around The World',
                    style: TextStyle(
                      color: Theme.Colors.kAmberAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _summaryList =
                          Provider.of<GlobalViewModel>(context, listen: false)
                              .fetchGlobalSummary();
                    });
                  },
                  child: Icon(
                    Icons.refresh,
                    color: Theme.Colors.kAmberAccent,
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: _summaryList,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Sorry, There is Error',
                  ),
                );
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return GlobalLoading();
                default:
                  return !snapshot.hasData
                      ? Center(
                          child: Text(
                            'Empty Data',
                          ),
                        )
                      : GlobalStatistics();
              }
            },
          ),
        ],
      ),
    );
  }
}
