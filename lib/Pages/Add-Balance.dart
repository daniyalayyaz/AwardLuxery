  import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gametest/Pages/Add-Jazzcash-account.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddBalance extends StatefulWidget {
  static final routename = 'AddBalance';

  @override
  State<AddBalance> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<AddBalance> {
  var response = [];
  var totalget = '---';
  getAmount() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int id = preferences.getInt('Id') as int;

    var url = "http://awardluxery.somee.com/api/getamount?userid=${id}";
    var res = await http.get(Uri.parse(url));
    var res1 = json.decode(res.body);

    setState(() {
      totalget = res1['totalamount'].toString();
    });
  }

  @override
  void initState() {
    getAmount();
    // TODO: implement initState
    super.initState();
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
          'Add Balance',
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
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                margin: EdgeInsets.only(top: 150),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 5,
                        child: Card(
                          elevation: 10,
                          color: Colors.black.withOpacity(0.5),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Available Balance\n${totalget} Rs',
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                    //   child: ListTile(
                    //     leading: Image.asset(
                    //       'assets/Images/Bank-removebg-preview.png',
                    //       height: 80,
                    //       width: 80,
                    //     ),
                    //     title: Text('Add Funds Via Bank',
                    //         style: TextStyle(
                    //             fontSize: 14, color: Colors.white)),
                    //     subtitle: Text('Add credit from your credit card.',
                    //         style: TextStyle(
                    //             fontSize: 14,
                    //             color: Colors.white.withOpacity(0.5))),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    //   child: Divider(
                    //     thickness: 2,
                    //     color: Colors.white.withOpacity(0.5),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AddJazzCash.routename);
                        },
                        leading: Image.asset(
                          'assets/Images/JazzCash_logo.png',
                          height: 80,
                          width: 80,
                        ),
                        title: Text('Add Funds Via JazzCash',
                            style: TextStyle(
                                fontSize: 14, color: Colors.white)),
                        subtitle: Text('Add credit from your JazzCash account.',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.5))),
                      ),
                    )
                  ],
                ))),
      ),
    );
  }
}
