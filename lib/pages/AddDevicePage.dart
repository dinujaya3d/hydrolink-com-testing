import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({Key? key}) : super(key: key);

  @override
  AddDevicePageState createState() => AddDevicePageState();
}

class AddDevicePageState extends State<AddDevicePage> {
  String _scanResult = '';
  TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the text controller value to the scanned result when available
    _codeController.text = _scanResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Device'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: _buildBarcodeScanner(),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                maxLength: 9,
                decoration: const InputDecoration(
                  labelText: 'Type 9-digit code',
                  counterText: '',
                ),
                onChanged: (text) {
                  // Handle changes in the text field if needed
                  _scanResult = text;
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Check if a valid code is available
              if (_scanResult.length == 10) {
                // Return the obtained code and exit the page
                Navigator.pop(context, _scanResult);
              } else {
                // Navigate back with an empty string for demonstration
                Navigator.pop(context, "");
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildBarcodeScanner() {
    return FutureBuilder<void>(
      future: FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Add Code Manually', // Change cancel text to "Add Code Manually"
        true,
        ScanMode.QR,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Handle the completion of the Future
          _scanResult = snapshot.data as String;
          //_codeController.text = _scanResult;
          return Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  _scanResult,
                  style: const TextStyle(fontSize: 30),
                ),
                Text('Code scanned successfully. Submit the Code.')
              ],
            ),
          ); // You can return an empty container or any other widget
        } else {
          // Future is still in progress, you can return a loading indicator
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    // Dispose of the text controller
    _codeController.dispose();
    super.dispose();
  }
}
