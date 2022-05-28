import 'package:flutter/material.dart';

import 'package:ditonton/common/constants.dart';

// ignore: must_be_immutable
class WatchListCard extends StatelessWidget {
  IconData icon;
  String title;

  WatchListCard({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 32,
                ),
                SizedBox(
                  width: 14,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
