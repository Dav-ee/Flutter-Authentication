import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register.dart';
import 'dashboard.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Loginpage(),
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => new Loginpage(),
          '/landingpage': (BuildContext context) => new MyApp(),
          '/register': (BuildContext context) => new RegisterPage(),
          '/dashboard': (BuildContext context) => new dashboardPage()
        },
    );
  }
}

