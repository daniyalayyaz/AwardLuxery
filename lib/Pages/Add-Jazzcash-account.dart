import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
// import 'package:lotteryapp/Pages/History.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
// import 'package:lotteryapp/Pages/MyTickets.dart';
// import 'package:lotteryapp/Pages/OTP.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dashboard.dart';

class AddJazzCash extends StatefulWidget {
  static final routename = 'AddJazzCash';
  var id;
  var ticketNumber;

  final cardform = GlobalKey<FormState>();

  @override
  State<AddJazzCash> createState() => _AddCardState();
}

class _AddCardState extends State<AddJazzCash> {
  var totalamount;
  Future<void> _ticketpurchased() async {
    EasyLoading.show(status: "Loading");

    SharedPreferences preferences = await SharedPreferences.getInstance();
    int id = preferences.getInt('Id') as int;
    Map<String, String> headers = {"Content-type": "application/json"};
    var url = "http://awardluxery.somee.com/api/updateamount";
    var result = {
      "userid": id,
      "totalamount": totalamount,
    };
    print(result);
    var res = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(result));
    var response = json.decode(res.body);
    if (res.statusCode == 200) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Amount Successfully Added.');
      Navigator.of(context).pushReplacementNamed(Dashboard.routename);
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        toolbarHeight: 100,
        backgroundColor: Colors.black.withOpacity(0.5),
        elevation: 0,
        title: Text(
          'Pay Via JazzCash',
          style: TextStyle(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 18,
                  width: 18,
                  color: Colors.white,
                  child: Text(''),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  height: 18,
                  width: 18,
                  color: Colors.white,
                  child: Text(''),
                )
              ],
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xff07459c),
          image: DecorationImage(
            image: AssetImage("assets/Images/Background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: this.widget.cardform,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: EdgeInsets.only(top: 150),
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      color: Colors.black.withOpacity(0.5),
                      elevation: 12,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(14.0, 20, 14.0, 14.0),
                            child: Text('Add Amount',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.white),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                label: Text('Mobile Number'),
                                labelStyle:
                                    TextStyle(color: Colors.white),
                                hintText: '00000000000',
                                hintStyle:
                                    TextStyle(color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xff35B551)),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Mobile number is required.';
                                } else if (value.length > 12) {
                                  return 'Mobile Number must be less than 12 digit';
                                }
                                return null;
                              },
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(14.0),
                          //   child: TextFormField(
                          //     style: TextStyle(color: Colors.white),
                          //     decoration: InputDecoration(
                          //       label: Text('Expiry date'),
                          //       labelStyle:
                          //           TextStyle(color: Colors.white),
                          //       hintText: 'MM/YY',
                          //       hintStyle:
                          //           TextStyle(color: Colors.white70),
                          //       border: OutlineInputBorder(
                          //         borderSide: const BorderSide(
                          //             color: Color(0xff35B551)),
                          //         borderRadius: BorderRadius.circular(10.0),
                          //       ),
                          //     ),
                          //     validator: (value) {
                          //       if (value == null || value.isEmpty) {
                          //         return 'Expiry Date is required.';
                          //       }
                          //       return null;
                          //     },
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  totalamount = val;
                                });
                              },
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                label: Text('Enter Amount'),
                                labelStyle:
                                    TextStyle(color: Colors.white),
                                hintText: '...',
                                hintStyle:
                                    TextStyle(color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xff35B551)),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Amount is required.';
                                }
                                return null;
                              },
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(14.0),
                          //   child: TextFormField(
                          //     style: TextStyle(color: Colors.white),
                          //     decoration: InputDecoration(
                          //       label: Text('Cardholder Name'),
                          //       labelStyle:
                          //           TextStyle(color: Colors.white),
                          //       hintText: 'Enter Cardholder Full Name',
                          //       hintStyle:
                          //           TextStyle(color: Colors.white70),
                          //       border: OutlineInputBorder(
                          //         borderSide: const BorderSide(
                          //             color: Color(0xff35B551)),
                          //         borderRadius: BorderRadius.circular(10.0),
                          //       ),
                          //     ),
                          //     validator: (value) {
                          //       if (value == null || value.isEmpty) {
                          //         return 'Cardholder Name is required.';
                          //       }
                          //       return null;
                          //     },
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (this
                                    .widget
                                    .cardform
                                    .currentState!
                                    .validate()) {
                                  _ticketpurchased();
                                } else
                                  return null;
                              },
                              child: Text('Add Amount',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff35B551)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
