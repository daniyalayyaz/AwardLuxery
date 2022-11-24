import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gametest/Pages/MyTickets.dart';

import 'package:flutter/services.dart';
// import 'package:lotteryapp/Pages/History.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
// import 'package:lotteryapp/Pages/MyTickets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCard extends StatefulWidget {
  static final routename = 'AddCard';
  AddCard({@required this.id, @required this.ticketNumber});
  var id;
  var ticketNumber;

  final cardform = GlobalKey<FormState>();

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  Future<void> _ticketpurchased() async {
    EasyLoading.show(status: "Loading");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int id = preferences.getInt('Id') as int;
    Map<String, String> headers = {"Content-type": "application/json"};
    var url = "http://awardluxery.somee.com/api/Users1/addtocart?id=${id}";
    var result = {
      "userid": id,
      "Ticketid": this.widget.id,
      "Ticketnumber": this.widget.ticketNumber,
      "paymentstatus": 2,
    };
    print(result);
    var res = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(result));
    var response = json.decode(res.body);
    if (res.statusCode == 200) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Good Luck! Ticket successfully purchased.');
      Navigator.of(context).popAndPushNamed(MyTickets.routename);
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
          'Pay Via Card',
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
                            child: Text('Add Card',
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
                                label: Text('Card Number'),
                                labelStyle:
                                    TextStyle(color: Colors.white),
                                hintText: '0000 0000 0000 0000',
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
                                  return 'Card number is required.';
                                } else if (value.length > 19) {
                                  return 'Card Number must be less than 19 digit';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                label: Text('Expiry date'),
                                labelStyle:
                                    TextStyle(color: Colors.white),
                                hintText: 'MM/YY',
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
                                  return 'Expiry Date is required.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                label: Text('CVC/CVV'),
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
                                  return 'CVC/CVV is required.';
                                } else if (value.length > 3) {
                                  return 'CVC/CVV must be of 3 digit maximum';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                label: Text('Cardholder Name'),
                                labelStyle:
                                    TextStyle(color: Colors.white),
                                hintText: 'Enter Cardholder Full Name',
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
                                  return 'Cardholder Name is required.';
                                }
                                return null;
                              },
                            ),
                          ),
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
                              child: Text('Add Card',
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
