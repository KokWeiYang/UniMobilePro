import 'package:countmee/model/user.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() => runApp(PaymentScreen());

class PaymentScreen extends StatefulWidget {
  final User user;

  const PaymentScreen({Key key, this.user}) : super(key: key);
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Wallet'),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: QrImage(
                data: "This is a example of wallet code.",
                version: QrVersions.auto,
                size: 200.0,
                gapless: true,
                errorStateBuilder: (cxt, err) {
                  return Container(
                    child: Center(
                      child: Text(
                        "Uh oh! Something went wrong...",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
                child: Text(
                    "Step 1: Tap 'Scan' in your Touch 'n Go eWallet app.\nStep 2: Scan QR code above.\nStep 3: Enter payment amount.\nStep 4: Key in your 6-digit PIN.\nStep 5: Payment complete!")),
          ],
        ),
      ),
    );
  }
}
