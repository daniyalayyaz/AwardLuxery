import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:gametest/Pages/Tickets.dart';

// import 'package:lotteryapp/Pages/Tickets.dart';
// import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Lottery extends StatefulWidget {
  static final routename = 'Lottery';

  @override
  State<Lottery> createState() => _LotteryState();
}

class _LotteryState extends State<Lottery> {
  var controller;
  var response = [];
  var Imgresponse = [];
  var Timeresponse = [];

  @override
  void didChangeDependencies() {
    getNewsFeeds();
    getTickets();
    gettime();
  }

  Future<void> getTickets() async {
    EasyLoading.show(status: "Loading");
    var url = "http://awardluxery.somee.com/api/getticket";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      setState(() {
        response = json.decode(res.body);
      });
      EasyLoading.dismiss();
    }
  }

  Future<void> getNewsFeeds() async {
    var url = "http://awardluxery.somee.com/api/GetNewsandFeeds";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      setState(() {
        Imgresponse = json.decode(res.body);
      });
    }
  }

  int? endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 3000;

  Future<void> gettime() async {
    var url = "http://awardluxery.somee.com/api/GetContest";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      setState(() {
        Timeresponse = json.decode(res.body);
      });
    }
    DateTime dateTimeCreatedAt = DateTime.parse(Timeresponse[0]['startdate']);
    DateTime dateTimeEndingAt = DateTime.parse(Timeresponse[0]['enddate']);
    print(endTime);

    setState(() {
      final difference = dateTimeEndingAt.difference(dateTimeCreatedAt) * 24;
      print(difference.inMilliseconds);
      // endTime = new DateTime(difference).millisecondsSinceEpoch;
    });
    print(endTime);
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
          'Lottery',
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CountdownTimer(
              controller: controller,
              textStyle: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = Colors.white,
              ),
              endTime: endTime,
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 200),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color(0xff07459c),
          image: DecorationImage(
            image: AssetImage("assets/Images/Background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  height: MediaQuery.of(context).size.height / 4),
              items: Imgresponse.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(8),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                              "http://awardluxery.somee.com${i['Image']}",
                              fit: BoxFit.fill)),
                    );
                  },
                );
              }).toList(),
            ),
            response.length > 0
                ? Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 12),
                        itemCount: response.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                color: Colors.transparent,
                                elevation: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0, top: 8.0),
                                      child: Text(response[index]['name'],
                                          style: TextStyle(
                                              color: Color(0xff0EA930),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Rs ${response[index]['price']}",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white)),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Tickets(
                                                            name:
                                                                response[index]
                                                                    ['name'],
                                                            price:
                                                                response[index]
                                                                    ['price'],
                                                            id: response[index]
                                                                ['id'],
                                                          )));
                                            },
                                            child: Text('Buy Now',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              )),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color(0xff35B551)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: LinearPercentIndicator(
                                    //     lineHeight: 8.0,
                                    //     percent: 1,
                                    //     backgroundColor: Colors.white,
                                    //     progressColor: Color(0xff0EA930),
                                    //     animation: true,
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0, bottom: 8.0),
                                      child: Text(
                                          '${response[index]['left']} Spots Left',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
