import 'package:flutter/material.dart';
import 'package:coronavirus_app/style/theme.dart' as Theme;

// Created By Mahmoud El Shenawy (Email : Mr.Mahmoud.El.Shenawy@Gmail.com)

class NavigationBar extends StatelessWidget {
  final String title;
  final bool selected;
  final Function() onSelected;

  const NavigationBar({
    @required this.title,
    @required this.selected,
    @required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color:
                  selected ? Theme.Colors.kPrimaryColor : Theme.Colors.kGrey400,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          selected
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Theme.Colors.kPrimaryColor,
                          shape: BoxShape.circle),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
