import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final Key _qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController _controller;
  bool _flash = false;

  void _onScanned(String data) {
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: Stack(
        children: [
          QRView(
            key: _qrKey,
            onQRViewCreated: (controller) {
              setState(() {
                _controller = controller;
              });
              controller.scannedDataStream.distinct().listen(_onScanned);
            },
            overlay: QrScannerOverlayShape(
              borderWidth: 5.0,
              borderRadius: 5.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(_flash ? Icons.flash_on : Icons.flash_off),
                onPressed: _controller != null ? () {
                  _controller.toggleFlash();
                  setState(() {
                    _flash = !_flash;
                  });
                } : null,
              ),
              IconButton(
                icon: Icon(Icons.flip_camera_android),
                onPressed: _controller?.flipCamera,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
