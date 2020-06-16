import 'package:flutter/material.dart';

class Uploaded extends StatelessWidget {
  const Uploaded({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC41A3B),
      body: Center(
        child: Text(
          'Thank You!',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFBE0E6),
          ),
        ),
      ),
    );
  }
}
