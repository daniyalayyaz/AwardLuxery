import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gametest/Pages/Dashboard.dart';
import 'package:gametest/Pages/Forgetpassword.dart';
import 'package:gametest/Pages/Register.dart';

// import 'package:lotteryapp/Pages/Dashboard.dart';
// import 'package:lotteryapp/Pages/Register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Login extends StatefulWidget {
  static final routename = 'Login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  bool _isObscure = true;

  TextEditingController email = new TextEditingController();

  TextEditingController pass = new TextEditingController();

  _userSignIn() async {
    EasyLoading.show(status: "Loading");
    Map<String, String> headers = {"Content-type": "application/json"};

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var url =
        "http://awardluxery.somee.com/api/login?email=${email.text}&pass=${pass.text}";
    var data = {"email": email.text, "pass": pass.text};
    var res = await http.get(Uri.parse(url), headers: headers);
    var response = json.decode(res.body);
    print(response);

    print('Logged In');
    if (res.statusCode == 200) {
        preferences.setString('email', response["CustomerEmail"]);
      preferences.setString('fullname', response["fullname"]);
      preferences.setInt('Id', response["Id"]);
      preferences.setString('phone', response["phonenumber"]);
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Welcome! You are successfully logged in.');
      Navigator.of(context).pushReplacementNamed(Dashboard.routename);

//       final newUser = await _auth.signInWithEmailAndPassword(
//                       email: email.text, password: pass.text);

//                   if (newUser != null) {
//                     if (newUser.isEmailVerified) {
//                   }
//     
//       }
//       else
//       {
//  EasyLoading.showSuccess('User Not Verify.');

//       }
    } else {
      EasyLoading.dismiss();

      EasyLoading.showError('Login failed!');
    }
  }

  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  @override
  void initState() {
    logout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
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
                      controller: pass,
                      obscureText: _isObscure,
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
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(ForgotPassword.routename);
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.of(context)
                        //     .pushReplacementNamed(Dashboard.routename);
                        if (_formkey.currentState!.validate()) {
                          _userSignIn();
                        }
                      },
                      child: Text(
                        'LOG IN',
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Register.routename);
                      },
                      child: Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
