import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  final String data;

  InfoScreen(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(data)),
    );
  }
}
