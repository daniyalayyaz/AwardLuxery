import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gametest/Pages/EditProfile.dart';

// import 'package:lotteryapp/Pages/EditProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  static final routename = 'ProfilePage';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var useremail;
  var username;
  var userphone;
  getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      EasyLoading.show(status: "loading");
      useremail = preferences.getString('email');
      username = preferences.getString('fullname');
      userphone = preferences.getString('phone');

      EasyLoading.dismiss();
    });
  }

  @override
  void initState() {
    getdata();
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
          'Profile',
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
              child: Container(
                margin: EdgeInsets.only(top: 150),
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.black.withOpacity(0.5),
                  elevation: 12,
                  child: Column(
                    children: [
                      FractionalTranslation(
                        translation: Offset(0.0, -0.4),
                        child: Align(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                'https://image.shutterstock.com/image-vector/diver-head-helmet-logo-gaming-260nw-1930222916.jpg'),
                          ),
                          alignment: FractionalOffset(0.5, 0.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14.0, 0, 14.0, 14.0),
                        child: Text(username,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        trailing: Text(
                          useremail,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Phone',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        trailing: Text(
                          userphone,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      //   child: Divider(
                      //     thickness: 2,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      // ListTile(
                      //   title: Text(
                      //     'Password',
                      //     style: TextStyle(
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w600,
                      //         color: Colors.white),
                      //   ),
                      //   trailing: Text(
                      //     '********',
                      //     style: TextStyle(
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w600,
                      //         color: Colors.white),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile(
                                          editnamevalue: username,
                                          editemailvalue: useremail,
                                          editphonevalue: userphone,
                                        )));
                          },
                          child: Text('Edit Profile',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xff35B551)),
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
    );
  }
}
