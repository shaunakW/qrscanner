import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'info.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final Key _qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController _controller;
  bool _flash = false;

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });
    controller.scannedDataStream.listen(_onScanned);
  }

  void _onScanned(String data) async {
    _controller.pauseCamera();
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => InfoScreen(data)),
    );
    _controller.resumeCamera();
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
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderWidth: 5.0,
              borderRadius: 5.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(_flash ? Icons.flash_on : Icons.flash_off, color: Colors.white),
                onPressed: _controller != null ? () {
                  _controller.toggleFlash();
                  setState(() {
                    _flash = !_flash;
                  });
                } : null,
              ),
              IconButton(
                icon: Icon(Icons.flip_camera_android, color: Colors.white),
                onPressed: _controller?.flipCamera,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
