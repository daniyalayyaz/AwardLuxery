// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/services.dart';
import 'package:gametest/Pages/AboutUs.dart';
import 'package:gametest/Pages/Add-Balance.dart';
import 'package:gametest/Pages/Add-Jazzcash-account.dart';
import 'package:gametest/Pages/AddCard.dart';
import 'package:gametest/Pages/ContactUs.dart';
import 'package:gametest/Pages/Dashboard.dart';
import 'package:gametest/Pages/EditProfile.dart';
import 'package:gametest/Pages/Forgetpassword.dart';

import 'package:gametest/Pages/History.dart';
import 'package:gametest/Pages/Login.dart';
import 'package:gametest/Pages/Lottery.dart';
import 'package:gametest/Pages/MyTickets.dart';
import 'package:gametest/Pages/OTP.dart';
import 'package:gametest/Pages/PrivacyPolicy.dart';
import 'package:gametest/Pages/ProfilePage.dart';
import 'package:gametest/Pages/Register.dart';
import 'package:gametest/Pages/Splash.dart';
import 'package:gametest/Pages/Terms&Conditions.dart';
import 'package:gametest/Pages/Winners.dart';

import 'Pages/Tickets.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Award Luxury',
      home: Splash(),
      builder: EasyLoading.init(),
      routes: {
        Register.routename: (ctx) => Register(),
        Login.routename: (ctx) => Login(),
        Dashboard.routename: (ctx) => Dashboard(),
        Lottery.routename: (ctx) => Lottery(),
        Winners.routename: (ctx) => Winners(),
        Tickets.routename: (ctx) => Tickets(),
        ProfilePage.routename: (ctx) => ProfilePage(),
        MyTickets.routename: (ctx) => MyTickets(),
        History.routename: (ctx) => History(),
        AboutUs.routename: (ctx) => AboutUs(),
        ContactUs.routename: (ctx) => ContactUs(),
        TermsAndConditions.routename: (ctx) => TermsAndConditions(),
        PrivacyPolicy.routename: (ctx) => PrivacyPolicy(),
        EditProfile.routename: (ctx) => EditProfile(),
        AddCard.routename: (ctx) => AddCard(),
        AddBalance.routename: (ctx) => AddBalance(),
        AddJazzCash.routename: (ctx) => AddJazzCash(),
        Otp.routename: (ctx) => Otp(),
       ForgotPassword.routename: (ctx) => ForgotPassword()
      },
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           call();
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
      
      
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }

//   call(){
//     print("ddd");
//     try {
//      const MethodChannel("CreativeParkingSolution.example.com/map").invokeMethod("umair"); 

//     } catch (e) {
//       print(e); 
//     }
//   }
  
// }
