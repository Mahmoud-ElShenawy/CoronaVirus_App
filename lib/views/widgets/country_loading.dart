import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:coronavirus_app/style/theme.dart' as Theme;

// Created By Mahmoud El Shenawy (Email : Mr.Mahmoud.El.Shenawy@Gmail.com)

class CountryLoading extends StatelessWidget {
  final bool inputTextLoading;

  const CountryLoading({@required this.inputTextLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        inputTextLoading ? _buildLoadingInputCard() : Container(),
        _buildLoadingChardCard(),
        _buildLoadingChardCard(),
        _buildLoadingInputCard(),
      ],
    );
  }
}

Widget _buildLoadingInputCard() {
  return Card(
    elevation: 1,
    child: Container(
      padding: const EdgeInsets.all(24),
      height: 105,
      child: Shimmer.fromColors(
          baseColor: Theme.Colors.kGrey300,
          highlightColor: Theme.Colors.kGrey100,
        child: Container(
          color: Theme.Colors.kWhite,
          width: double.infinity,
          height: 57,
        ),
      ),
    ),
  );
}

Widget _buildLoadingChardCard() {
  return Card(
    elevation: 1,
    child: Container(
      height: 180,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Shimmer.fromColors(
        baseColor: Theme.Colors.kGrey300,
        highlightColor: Theme.Colors.kGrey100,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Theme.Colors.kWhite,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
