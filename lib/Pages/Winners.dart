import 'package:flutter/material.dart';

// import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class Winners extends StatefulWidget {
  static final routename = 'Winners';

  @override
  State<Winners> createState() => _WinnersState();
}

class _WinnersState extends State<Winners> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 9000 * 30;
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
          'Winners',
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
              child: Text('Lottery Winner',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold))),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(children: <Widget>[
                Container(
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
                              Text('Price Pool',
                                  style: TextStyle(
                                      color: Color(0xff0EA930),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xff0EA930),
                                  ),
                                  padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                                  child: Text('Rs 525',
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('James Anderson',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white)),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Winner',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  )),
                                  backgroundColor: MaterialStateProperty.all(
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
                        //     percent: 0.5,
                        //     backgroundColor: Colors.white,
                        //     progressColor: Colors.white,
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 8.0),
                          child: Text('5-12-2022',
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
                FractionalTranslation(
                  translation: Offset(0.0, -0.4),
                  child: Align(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://i.pinimg.com/originals/b1/92/4d/b1924dce177345b5485bb5490ab3441f.jpg'),
                      radius: 30.0,
                    ),
                    alignment: FractionalOffset(0.9, 0.0),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
