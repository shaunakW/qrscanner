import 'package:flutter/material.dart';

import 'screens/scan.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scanner',
      theme: ThemeData(
        primaryColor: Colors.blue[800],
      ),
      home: ScanScreen(),
    );
  }
}
