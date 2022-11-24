import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AboutUs extends StatefulWidget {
  static final routename = 'AboutUs';

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  var response = [];
  @override
  void didChangeDependencies() {
    getAbout();
  }

  Future<void> getAbout() async {
    EasyLoading.show(status: "Loading");
    var url = "http://awardluxery.somee.com/api/GetAbouts";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      setState(() {
        response = json.decode(res.body);
      });
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
          'About Us',
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
            Center(
              child: Image(
                image: AssetImage('assets/Images/Lottery-Logo.png'),
                height: 150,
                width: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Award Luxury',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            response.length > 0
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                        child: Html(
                      data: response[0]['description'],
                      style: {
                        "p": Style(
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.6))
                      },
                    )),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  '©2022 INNOVATION.TECH',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.6)),
                ),
              ),
            ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width / 1.1,
            //   child: Container(
            //     margin: EdgeInsets.only(top: 50, bottom: 20),
            //     child: TextButton(
            //       child: Text('LICENSES',
            //           style: TextStyle(
            //               decoration: TextDecoration.underline,
            //               fontSize: 14,
            //               fontWeight: FontWeight.w600,
            //               color: Colors.white)),
            //       onPressed: () {},
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
