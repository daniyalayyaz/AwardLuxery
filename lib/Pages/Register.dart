import 'dart:convert';
//  import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gametest/Pages/Login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:lotteryapp/Pages/Dashboard.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/services.dart';
// import 'package:lotteryapp/Pages/Login.dart';

class Register extends StatefulWidget {
  static final routename = 'Register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formstate = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isConfirmPassObscure = true;
  // final _auth = FirebaseAuth.instance;
  

  TextEditingController fullname = new TextEditingController();
  TextEditingController cnic = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phonenumber = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController Password = new TextEditingController();

  Future<void> _registerUser() async {
    EasyLoading.show(status: "Loading");
    Map<String, String> headers = {"Content-type": "application/json"};
    var url = "http://awardluxery.somee.com/api/adduser";
    var result = {
      "fullname": fullname.text,
      "cnic": cnic.text,
      "email": email.text,
      "phonenumber": phonenumber.text,
      "address": address.text,
      "Password": Password.text,
      "type ": 1
    };
    var res = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(result));
    var response = json.decode(res.body);
    if (res.statusCode == 200) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Hurray! You are successfully registered.');
  
  //     try {
  //     final newUser = await _auth
  //         .createUserWithEmailAndPassword(email:email.text, password:Password.text)
  //         .then((value) async {
            
  //       if (value.email != null) {
  //         // saveuser(value.user!.email,value.user!.uid);
  //         // _formKey.currentState!.reset();
  //       await  value.sendEmailVerification();
  //       }
  //     });
  //     // if (newUser != null) {
        
  //     //   EasyLoading.dismiss();
  //     //   Navigator.pushNamed(context, LoginSuccessScreen.routeName); 
  //     // }
  //   } 
  // catch (e) {
  //     EasyLoading.showError(e.toString());
  //     print(e);
  //   }

      Navigator.of(context).pushReplacementNamed(Login.routename);
    }
  }

  @override
  void initState() {
    // FirebaseMessaging _messaging = FirebaseMessaging.instance;
    // _messaging.subscribeToTopic("global").then((value) {
    //   print("done");
    // });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formstate,
          child: Container(
            padding: EdgeInsets.only(top: 50, bottom: 50),
            decoration: BoxDecoration(
              color: Color(0xff07459c),
              image: DecorationImage(
                image: AssetImage("assets/Images/Background.png"),
                fit: BoxFit.fitHeight,
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
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFormField(
                      controller: fullname,
                      decoration: InputDecoration(
                        hintText: 'Full Name',
                        hintStyle: TextStyle(),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFormField(
                      controller: cnic,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: 'CNIC Number',
                        hintStyle: TextStyle(),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'CNIC Number is required.';
                        } else if (value.length != 13) {
                          return 'CNIC Number must be of 13 digit';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFormField(
                      controller: phonenumber,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFormField(
                      controller: address,
                      decoration: InputDecoration(
                        hintText: 'Address',
                        hintStyle: TextStyle(),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Address is required.';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFormField(
                      obscureText: _isObscure,
                      controller: Password,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            icon: Icon(Icons.remove_red_eye_rounded)),
                        hintStyle: TextStyle(),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required.';
                        } else if (value.length < 8) {
                          return 'Password should be atleast 8 character long';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFormField(
                      obscureText: _isConfirmPassObscure,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isConfirmPassObscure = !_isConfirmPassObscure;
                              });
                            },
                            icon: Icon(Icons.remove_red_eye_rounded)),
                        hintStyle: TextStyle(),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm Password is required.';
                        } else if (value != Password.text) {
                          return 'Password does not match.';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formstate.currentState!.validate()) {
                          _registerUser();
                        }
                      },
                      child: Text(
                        'CREATE',
                        style: TextStyle(),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff35B551)),
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
