import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  late String _email;
  late String _password;
  final formkey= GlobalKey<FormState>();
  // create a reusable instance
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Enter a valid email address')
  ]);

    final requiredValidator = RequiredValidator(errorText: 'This field is required');
    final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'Passwords must have at least one special character i.e /*&%%(')
  ]);

  checkFields() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form?.save();
      return true;
    }
    return false;
  }

  loginUser(){
if(checkFields()){
FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)
    .then((uid) {
      Fluttertoast.showToast(msg: "Login successfull ${_email}");
      Navigator.of(context).pop();
       Navigator.of(context).pushNamed('/dashboard');
}
).catchError((e){
  Fluttertoast.showToast(msg: e!.message);
});
}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed:  () {},
            icon: Icon(Icons.home_filled)),
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: EdgeInsets.all(25.0),
            child: Form(
             key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 80.0,
                      backgroundImage: new AssetImage('assets/logo.png'),
                    ),
                    SizedBox(height: 15.0),

                    TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Enter your Email Address',
                        contentPadding: EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)
                        )
                      ),
                        onChanged: (val) => _email = val,
                        validator: emailValidator,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 15.0,),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter Your Password',
                          contentPadding: EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                      ),
                      obscureText: true,
                        onChanged: (val) => _password = val,
                        validator: requiredValidator
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(30.0),
                      shadowColor: Colors.blue,
                      elevation: 7.0,
                      child: MaterialButton(
                        minWidth: 500.0,
                        height: 30.0,
                        onPressed: () {
                          loginUser();
                        },
                        child: Text(
                          'Login',
                          style:   TextStyle(color: Colors.blue, fontSize: 22),

                        ),
                      ),
                    ),
                    ),
                    Text('Don\'t have an account? '),
                    Padding(padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.blue,
                        elevation: 7.0,
                        child: MaterialButton(
                          minWidth: 500.0,
                          height: 50.0,
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/register');
                          },
                          color: Colors.blue,
                          child: Text(
                            'Register Now',
                            style:  TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
      ),
    );
  }
}
