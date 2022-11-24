import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gametest/Pages/AddCard.dart';
import 'package:gametest/Pages/MyTickets.dart';

// import 'package:lotteryapp/Pages/AddCard.dart';
// import 'package:lotteryapp/Pages/MyTickets.dart';
// import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Tickets extends StatefulWidget {
  static final routename = 'Tickets';
  Tickets({this.name, this.price, @required this.id});
  var name;
  var price;
  var id;

  @override
  State<Tickets> createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  var intValue = Random().nextInt(10000) + 250;
  Future<void> _ticketpurchased() async {
    EasyLoading.show(status: "Loading");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int id = preferences.getInt('Id') as int;
    Map<String, String> headers = {"Content-type": "application/json"};
    var url = "http://awardluxery.somee.com/api/Users1/addtocart?id=${id}";
    var result = {
      "userid": id,
      "Ticketid": this.widget.id,
      "Ticketnumber": 'KHW${intValue}',
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

  Future<void> buyusingcard() async {
    EasyLoading.show(status: "Loading");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int id = preferences.getInt('Id') as int;
    Map<String, String> headers = {"Content-type": "application/json"};
    var url = "http://awardluxery.somee.com/api/buyusingwallet";
    var result = {
      "userid": id,
      "Ticketid": this.widget.id,
      "Ticketnumber": 'KHW${intValue}',
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
          'Payment',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Your Ticket Number',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      Text(
                        'KHW${intValue}',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                      Card(
                        color: Color(0xffEBEBEB),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Ticket Name',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                  Text(
                                    '${this.widget.name}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Ticket Amount',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                  Text(
                                    'Rs ${this.widget.price}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tax',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                  Text(
                                    'Rs 0',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Amount Payable',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                  Text(
                                    'Rs ${this.widget.price}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Once the Transaction is successful the amount will be automatically deducted from your bonus',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddCard(
                            ticketNumber: "KHW${intValue}",
                            id: this.widget.id)));
              },
              child: Text('Pay with Card',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600)),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
                backgroundColor: MaterialStateProperty.all(Color(0xff35B551)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                buyusingcard();
              },
              child: Text('Pay with Wallet',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600)),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
                backgroundColor: MaterialStateProperty.all(Color(0xff35B551)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
