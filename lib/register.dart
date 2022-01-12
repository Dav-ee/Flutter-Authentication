import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String _email;
  late String _password;
  late String _fname;
  late String _lname;
  late int _phone;
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

  CreateUser(){
    if(checkFields()){
//  do this
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)
          .then((uid) => { postValuesToFirestore()}
      ).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
  postValuesToFirestore(){
    CollectionReference _firebaseFirestore = FirebaseFirestore.instance.collection('users');
    _firebaseFirestore.add({'email': _email , 'password': _password  ,
      'fname': _fname  , 'lname': _lname, 'phone': _phone  }).whenComplete(() {
    }).catchError((e){
      Fluttertoast.showToast(msg: e!.message);
    });
    Fluttertoast.showToast(msg: "Registration successfull ${_email}");
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed('/dashboard');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed:  () {},
            icon: Icon(Icons.app_registration)),
        title: Text('Register Account'),
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
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                          obscureText: false,
                          onChanged: (val) => _fname = val,
                          validator: requiredValidator,
                        textInputAction: TextInputAction.next,
                      ),

                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                          obscureText: false,
                          onChanged: (val) => _lname = val,
                          validator: requiredValidator,
                        textInputAction: TextInputAction.next,
                      ),

                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                              hintText: 'Enter your Email Address',
                              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
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
                          autofocus: false,
                          decoration: InputDecoration(
                              hintText: 'Enter your Mobile Number',
                              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)
                              )
                          ),
                          onChanged: (val) => _phone = double.parse(val).round(),
                          validator: requiredValidator,
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
                          validator: passwordValidator
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
                              CreateUser();
                            },
                            child: Text(
                              'Register',
                              style:   TextStyle(color: Colors.blue, fontSize: 22),

                            ),
                          ),
                        ),
                      ),
                      Text('Already have an account? '),
                      Padding(padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.blue,
                          elevation: 7.0,
                          child: MaterialButton(
                            minWidth: 500.0,
                            height: 50.0,
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed('/login');
                            },
                            color: Colors.blue,
                            child: Text(
                              'Login',
                              style:  TextStyle(color: Colors.white, fontSize: 15),
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

