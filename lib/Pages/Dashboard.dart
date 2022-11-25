import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gametest/Pages/AboutUs.dart';
import 'package:gametest/Pages/Add-Balance.dart';
import 'package:gametest/Pages/ContactUs.dart';
import 'package:gametest/Pages/History.dart';
import 'package:gametest/Pages/Login.dart';
import 'package:gametest/Pages/Lottery.dart';
import 'package:gametest/Pages/MyTickets.dart';
import 'package:gametest/Pages/PrivacyPolicy.dart';
import 'package:gametest/Pages/ProfilePage.dart';

// import 'package:lotteryapp/Pages/AboutUs.dart';
// import 'package:lotteryapp/Pages/Add-Balance.dart';
// import 'package:lotteryapp/Pages/ContactUs.dart';
// import 'package:lotteryapp/Pages/History.dart';
// import 'package:lotteryapp/Pages/Login.dart';
// import 'package:lotteryapp/Pages/Lottery.dart';
// import 'package:lotteryapp/Pages/MyTickets.dart';
// import 'package:lotteryapp/Pages/PrivacyPolicy.dart';
// import 'package:lotteryapp/Pages/ProfilePage.dart';
// import 'package:lotteryapp/Pages/Terms&Conditions.dart';
// import 'package:lotteryapp/Pages/Winners.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  static final routename = 'Dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var useremail;
  var username;
  var totalget = "loading";
  var response;
  getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      useremail = preferences.getString('email');
      username = preferences.getString('fullname');
    //   FirebaseMessaging _messaging = FirebaseMessaging.instance;
    //   _messaging.subscribeToTopic("global").then((value) {});
    });
  }

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
    getdata();
    getAmount();
    // TODO: implement initState
    super.initState();
  }

  var menuitems = [
    'Profile',
    'My Ticket',
    'History',
    'Privacy Policy',
    // 'Term & Condition',
    'Contact Us',
    'About Us',
    'Logout',
  ];
  var routes = [
    ProfilePage.routename,
    MyTickets.routename,
    History.routename,
    PrivacyPolicy.routename,
    // TermsAndConditions.routename,
    ContactUs.routename,
    AboutUs.routename,
    Login.routename
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(
       
        child: Container(
color:Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: ListTile(
                  title: Text(
                    username,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  subtitle: Text(
                    useremail,
                    style: TextStyle(fontSize: 8, color: Colors.white),
                  ),
                  trailing: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://image.shutterstock.com/image-vector/diver-head-helmet-logo-gaming-260nw-1930222916.jpg'),
                    radius: 40.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(AddBalance.routename);
                  },
                  child: Text(
                    'Available Balance: ' + totalget + ' Rs',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: menuitems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          onTap: () {
                            Navigator.of(context).popAndPushNamed(routes[index]);
                          },
                          leading: const Icon(
                            Icons.circle_outlined,
                            color: Colors.white,
                          ),
                          title: Text(
                            menuitems[index],
                            style: TextStyle(
                                fontSize: 16, color: Colors.white),
                          ));
                    }),
              ),
            ],
          ),
        ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/Images/Lottery-Logo.png'),
              height: 300,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
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
                child: ElevatedButton(
                  onPressed: () {

                    call();
                  },
                  child: Stack(
                    children: <Widget>[
                      Text(
                        'PLAY GAME',
                        style: TextStyle(
                          fontSize: 34,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 6
                            ..color = Colors.white,
                        ),
                      ),
                      Text(
                        'PLAY GAME',
                        style: TextStyle(
                          fontSize: 34,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
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
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Lottery.routename);
                  },
                  child: Stack(
                    children: <Widget>[
                      Text(
                        'LOTTERY',
                        style: TextStyle(
                          fontSize: 34,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 6
                            ..color = Colors.white,
                        ),
                      ),
                      Text(
                        'LOTTERY',
                        style: TextStyle(
                          fontSize: 34,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  call(){
    print("ddd");
    try {
     const MethodChannel("CreativeParkingSolution.example.com/map").invokeMethod("umair"); 

    } catch (e) {
      print(e); 
    }
  }
}
