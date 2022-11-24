import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ContactUs extends StatefulWidget {
  static final routename = 'ContactUs';

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  var response = [];
  final _formstate = GlobalKey<FormState>();
  TextEditingController message = new TextEditingController();

  @override
  void didChangeDependencies() {
    getContact();
  }

  Future<void> getContact() async {
    EasyLoading.show(status: "Loading");
    var url = "http://awardluxery.somee.com/api/Getcontact";
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
          'Contact Us',
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
      body: SingleChildScrollView(
        child: Container(
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
              response.length > 0
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                          child: Html(
                        data: response[0]['Contact1'],
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
                child: Text(
                  'Tell us how we can help',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              Form(
                key: _formstate,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      controller: message,
                      maxLines: 14,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Type some message.......',
                        hintStyle:
                            TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Message cannot be empty.';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.1,
                height: 80,
                child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: ElevatedButton(
                    child: Text('Send',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    onPressed: () {
                      if (_formstate.currentState!.validate()) {
                        setState(() {
                          message.text = '';
                        });
                        EasyLoading.showSuccess('Message Sent!');
                      }
                    },
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff35B551)),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
