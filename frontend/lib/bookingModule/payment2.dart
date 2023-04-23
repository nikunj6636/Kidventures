import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:App/profile/profile.dart' show Child;
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentGatewayPage extends StatefulWidget {
  final String email, bookingDate, startTime;
  final int duration, mobileNumber;
  final String adult, children;
  const PaymentGatewayPage(this.email, this.adult, this.children, this.bookingDate, this.startTime, this.duration, this.mobileNumber, {Key? key}) : super(key: key);

  @override
  State<PaymentGatewayPage> createState() => _PaymentGatewayPageState();
}

class _PaymentGatewayPageState extends State<PaymentGatewayPage> {

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  final List<String> prices = [];
  bool infoLoaded = true;
  int total = 0;

  @override
  void initState() {
    super.initState();
    total = 3000 * widget.duration;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text("Billing"),
      ),
      body: infoLoaded == true
          ?  Center(

              child: Column(
        
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Bill',
                  ),
                  Text("Number of Children ${widget.children}"),
                  Text("Number of Adults ${widget.adult}"),
                  Text("Total ${3000*widget.duration}"),
                  Text("Date of Booking ${widget.bookingDate}"),
                  Text("Start time ${widget.startTime}"),
                  Text("Duration ${widget.duration} hours"),
                  ElevatedButton(onPressed: (){
                        Razorpay razorpay = Razorpay();
                        var options = {
                          'key': 'rzp_test_X3Lp0ol12yjPmd',
                          'amount': total*100,
                          'name': 'Kidventures',
                          'description': 'Party Payment',
                          'retry': {'enabled': true, 'max_count': 1},
                          'send_sms_hash': true,
                          'prefill': {'contact': widget.mobileNumber, 'email': widget.email},
                        };
                        razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
                        razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
                        razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
                        razorpay.open(options);
                      },
                      child: const Text("Pay with Razorpay")),
                  ],
                ),
              )
          : Center(
                child: Column(
                children: const [
                  CircularProgressIndicator(),
                  Text('Generating your bill...'),
                ],
              )),
    );
  }
}
