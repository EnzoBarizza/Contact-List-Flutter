import 'package:flutter/material.dart';

Widget commonLoading(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Loading', style: TextStyle(fontSize: 24)),
        ),
      ],
    ),
  );
}
