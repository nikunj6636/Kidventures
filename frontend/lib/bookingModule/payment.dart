import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:App/profile/profile.dart' show Child;
import 'package:http/http.dart' as http;
import 'dart:convert';

List<String> activities = [
    // List of activities
    'Origami',
    'Painting',
    'Story telling',
    'Dancing',
    'Clay Modelling'
  ];

class PaymentGatewayPage extends StatefulWidget {
  final String email, bookingDate, dropTime;
  final int duration, mobileNumber;
  final List<String> selectedActivites, children;
  const PaymentGatewayPage(this.email, this.children, this.selectedActivites, this.bookingDate, this.dropTime, this.duration, this.mobileNumber, {Key? key}) : super(key: key);

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
  bool infoLoaded = false;
  int total = 0;
  getPrice(String activityName) async {
        // Write 
    final response = await http.post(
      Uri.parse('http://10.1.134.42:5000/activity/getPrice'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'activity_name':activityName,
      }),
    );
  
    if (response.statusCode == 200) {
      int cost = jsonDecode(response.body)['price'];
      total += cost * widget.duration;
      String tobeadded = "$activityName     $cost x${widget.duration}";
      prices.add(tobeadded);
      if(prices.length == widget.selectedActivites.length) {
        setState(() {
          infoLoaded = true;
        });
      }
    } else {
      
      // email does not exist
      return 0;
      
    }
  }

  @override
  void initState() {
    super.initState();
    for (var item in widget.selectedActivites) {
      getPrice(item);
    }
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
                  const Text(
                    'Children Selected',
                  ),
                  for(var item in widget.children) Text(item),
                  // Text(totalCount.toString()),
                  // Text(count.toString()),
                  // Text(errcount.toString()),
                  const Text(
                    'Activities Selected',
                  ),
                  for(var item in prices) Text(item),
                  Text("Total $total"),
                  Text("Date of Booking ${widget.bookingDate}"),
                  Text("Drop off time ${widget.dropTime}"),
                  Text("Duration ${widget.duration} hours"),
                  ElevatedButton(onPressed: (){
                        Razorpay razorpay = Razorpay();
                        var options = {
                          'key': 'rzp_test_X3Lp0ol12yjPmd',
                          'amount': total*100,
                          'name': 'Kidventures',
                          'description': 'Child Payment',
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
