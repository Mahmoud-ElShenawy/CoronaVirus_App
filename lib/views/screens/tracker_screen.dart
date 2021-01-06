import 'package:coronavirus_app/views/screens/country_screen.dart';
import 'package:coronavirus_app/views/screens/global_screen.dart';
import 'package:coronavirus_app/views/widgets/navigation_bar.dart';
import 'country_screen.dart';
import 'global_screen.dart';
import 'package:flutter/material.dart';
import 'package:coronavirus_app/style/theme.dart' as Theme;

enum NavigationStatus {
  GLOBAL,
  COUNTRY,
}

class TrackScreen extends StatefulWidget {
  @override
  _TrackScreenState createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  NavigationStatus navigationStatus = NavigationStatus.GLOBAL;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Theme.Colors.kPrimaryDark,
                borderRadius: const BorderRadius.only(
                  bottomLeft: const Radius.circular(80),
                  bottomRight: const Radius.circular(80),
                ),
              ),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                child: navigationStatus == NavigationStatus.GLOBAL
                    ? GlobalScreen()
                    : CountryScreen(),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.Colors.kGrey300,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(80),
                topRight: const Radius.circular(80),
              )
            ),
            height: size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                NavigationBar(
                    title: 'Global',
                    selected: navigationStatus == NavigationStatus.GLOBAL,
                    onSelected: () {
                      setState(() {
                        navigationStatus = NavigationStatus.GLOBAL;
                      });
                    }),
                NavigationBar(
                    title: 'Country',
                    selected: navigationStatus == NavigationStatus.COUNTRY,
                    onSelected: () {
                      setState(() {
                        navigationStatus = NavigationStatus.COUNTRY;
                      });
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
