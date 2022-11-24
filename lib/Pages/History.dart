import 'dart:convert';
import 'package:flutter/material.dart';


// import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  static final routename = 'History';

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var response = {};
  var TicketLength = 0;

  @override
  void initState() {
    getTickets();
    super.initState();
  }

  Future<void> getTickets() async {
    EasyLoading.show(status: "Loading");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int id = preferences.get('Id') as int;
    print(id);
    var url = "http://awardluxery.somee.com/api/Getoldticket?id=${id}";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      setState(() {
        response = json.decode(res.body);
        TicketLength = response['responses'].length;
      });

      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
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
          'History',
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
        decoration: BoxDecoration(
          color: Color(0xff07459c),
          image: DecorationImage(
            image: AssetImage("assets/Images/Background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 40),
          child: TicketLength > 0
              ? ListView.builder(
                  itemCount: TicketLength,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xffFFEA74),
                              Color(0xffDB830F),
                              Color(0xffF3CC29)
                            ],
                          ),
                        ),
                        child: Card(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 8.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(0xff0EA930),
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 3, 10, 3),
                                        child: Text(
                                            response['responses'][index]
                                                ['ticketname'],
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        response['responses'][index]
                                            ['ticketnumber'],
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white)),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color:
                                              Color.fromARGB(255, 192, 19, 13),
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 3, 10, 3),
                                        child: Text('Expired',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: LinearPercentIndicator(
                              //     lineHeight: 8.0,
                              //     percent: 0.5,
                              //     backgroundColor: Colors.white,
                              //     progressColor: Colors.white,
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, bottom: 8.0),
                                child: Text(
                                    'Purchased on ${response['responses'][index]['orderdate']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.5),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Center(
                  child: Text(
                    'No data found.',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
        ),
      ),
    );
  }
}
