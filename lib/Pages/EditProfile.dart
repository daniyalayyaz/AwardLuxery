import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
// import 'package:lotteryapp/Pages/ProfilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  static final routename = 'EditProfile';
  EditProfile({this.editnamevalue, this.editemailvalue, this.editphonevalue});
  var editnamevalue;
  var editemailvalue;
  var editphonevalue;
  final _formstate = GlobalKey<FormState>();

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController namevalue = new TextEditingController();
  TextEditingController emailvalue = new TextEditingController();
  TextEditingController phonevalue = new TextEditingController();
  Future<void> _updateUser() async {
    EasyLoading.show(status: "Loading");
    Map<String, String> headers = {"Content-type": "application/json"};
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int id = preferences.get('Id') as int;
    var url = "http://awardluxery.somee.com/api/updateuser";
    var result = {
      "name": namevalue.text,
      "email": emailvalue.text,
      "phone": phonevalue.text,
      "id": 19.toString(),
    };

    print(result);
    var res = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(result));
    var response = json.decode(res.body);
    if (res.statusCode == 200) {
      preferences.setString('email', emailvalue.text);
      preferences.setString('fullname', namevalue.text);
      preferences.setString('phone', phonevalue.text);
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Profile successfully updated.');
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('Something went wrong');
    }
  }

  @override
  void initState() {
    setState(() {
      namevalue.text = this.widget.editnamevalue;
      emailvalue.text = this.widget.editemailvalue;
      phonevalue.text = this.widget.editphonevalue;
    }); // TODO: implement initState
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
        child: SingleChildScrollView(
          child: Form(
            key: this.widget._formstate,
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 20),
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Stack(
                                  clipBehavior: Clip.none,
                                  fit: StackFit.expand,
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(
                                          'https://image.shutterstock.com/image-vector/diver-head-helmet-logo-gaming-260nw-1930222916.jpg'),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: -25,
                                        child: RawMaterialButton(
                                          onPressed: () {},
                                          elevation: 2.0,
                                          fillColor: Colors.white,
                                          child: Icon(
                                            Icons.edit,
                                            color: Color(0xff35B551),
                                          ),
                                          padding: EdgeInsets.all(2.0),
                                          shape: CircleBorder(
                                            side: BorderSide(
                                                color: Color(0xff35B551),
                                                width: 3),
                                          ),
                                        )),
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: TextFormField(
                              controller: namevalue,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                label: Text('Edit Name'),
                                labelStyle:
                                    TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xff35B551)),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Name is required.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: TextFormField(
                              controller: emailvalue,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                label: Text('Edit Email'),
                                labelStyle:
                                    TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xff35B551)),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required.';
                                } else if (!RegExp(
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                    .hasMatch(value)) {
                                  return 'Email Format is incorrect.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: TextFormField(
                              controller: phonevalue,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                label: Text('Edit Phone'),
                                labelStyle:
                                    TextStyle(color: Colors.white),
                                hintText: '+55 676 67676',
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xff35B551)),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone Number is required.';
                                } else if (value.length != 11) {
                                  return 'Mobile Number must be of 11 digit';
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
                                    ._formstate
                                    .currentState!
                                    .validate()) {
                                  _updateUser();
                                }
                              },
                              child: Text('Save Changes',
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
