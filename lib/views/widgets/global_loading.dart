import 'package:flutter/material.dart';
import 'package:coronavirus_app/style/theme.dart' as Theme;
import 'package:shimmer/shimmer.dart';

class GlobalLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildLoadingCard(),
        _buildLoadingCard(),
        _buildLoadingCard(),
        _buildLoadingCard(),
        _buildLoadingLabel(),
      ],
    );
  }
}

Widget _buildLoadingCard() {
  return Card(
    elevation: 1,
    child: Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Shimmer.fromColors(
        baseColor: Theme.Colors.kGrey300,
        highlightColor: Theme.Colors.kGrey100,
        child: Column(
          children: <Widget>[
            Container(
              width: 100,
              height: 20,
              color: Theme.Colors.kWhite,
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              width: double.infinity,
              height: 15,
              color: Theme.Colors.kWhite,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              height: 30,
              color: Theme.Colors.kWhite,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildLoadingLabel() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Shimmer.fromColors(
      baseColor: Theme.Colors.kBlue300,
      highlightColor: Theme.Colors.kBlue600,
      child: Column(
        children: <Widget>[
          Container(
            width: 200,
            height: 16,
            color: Theme.Colors.kWhite,
          )
        ],
      ),
    ),
  );
}
