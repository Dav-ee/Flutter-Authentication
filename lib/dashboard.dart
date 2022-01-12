import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class dashboardPage extends StatefulWidget {
  const dashboardPage({Key? key}) : super(key: key);

  @override
  _dashboardPageState createState() => _dashboardPageState();
}

class _dashboardPageState extends State<dashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed:  () {},
            icon: Icon(Icons.menu_outlined)),
        title: Text('Dashboard'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
Text('You are now logged in'),
            SizedBox(height: 15.0,),
              Text('Email: '),
              SizedBox(height: 15.0,),
              Text('Password: '),
            OutlinedButton(
                onPressed: () {
    FirebaseAuth.instance.signOut().then((action) {
      Fluttertoast.showToast(msg: "Logged out successfully");
      Navigator.of(context).pop();
    Navigator.of(context).pushNamed('/landingpage');
    }).catchError((e){
      Fluttertoast.showToast(msg: e!.message);
    });
                },
                child: Text('Log out')
               ),
            ],
          ),
        ),
      ),
    );
  }
}
