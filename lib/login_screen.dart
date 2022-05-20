import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:navi_doc/registration_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Services/common.dart';
import 'home_screen.dart';
import 'registration_screen.dart';
import 'Services/api_call.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController loginIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late String  _loginVal, _passwordVal, emailValue;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _forgotPasswordKey = GlobalKey<FormState>();
  TextEditingController displayNameController = TextEditingController();


  Widget _buildLoginId() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Login Name',),
        controller: loginIdController,
        onChanged: (text) {
          _loginVal = text;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Login Name is Required';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPassword() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        obscureText: true,
        controller: passwordController,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Password'),
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is Required';
          }
          if (value.length < 8){
            return 'Password should be of minimum 8 characters';
          }

          return null;
        },
        onChanged: (value) {
          _passwordVal = value;
        },
      ),
    );
  }

  Widget _buildWelcome(){
    return const Text('Welcome', style: TextStyle(
        color: Colors.white, fontSize: 24,
    ),
    );
  }

  Widget _buildNaviDoc(){
    return const Text('NaviDoc', style: TextStyle(
        color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold
    ),
    );
  }

  Widget _buildTrack(){
    return const Text('Track your Business', style: TextStyle(
        color: Colors.white, fontSize: 20,
    ),
    );
  }

  Widget _buildLoginBtn(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(style: ElevatedButton.styleFrom(
        primary: Colors.green[900],
      ), onPressed: () async {
try {
  if (_formKey.currentState!.validate()) {
      Common.buildShowDialog(context);
      var result = await loginData(_loginVal, _passwordVal);
      if (result!.success == true) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("UserLogin", json.encode(result!.Result));
        //prefs.setString("UserDetails", _loginVal);

        _formKey.currentState!.reset();

        Fluttertoast.showToast(
            msg: "Welcome",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Future.delayed(Duration.zero, () {
          Common.isDialogOpen = false;
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
                (Route<dynamic> route) => false,
          );
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => HomeScreen()));
        });
      } else {
        Common.hideDialog(context);
        Fluttertoast.showToast(
            msg: result.error,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
  }
}catch(e){
  Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
  );
}
      },
        child: const Text('Login',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildRegisterBtn(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegistrationScreen()));
          _formKey.currentState!.reset();
          }, child: const Text(
          'New User Registration', style: TextStyle(
          color: Colors.white
          ),
        ),
        ),
      TextButton(
        onPressed: () {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return WillPopScope(
                  onWillPop: () async => false,
                  child: AlertDialog(
                    title: const Text('Enter Registered Email Id'),
                    content: Form(
                      key: _forgotPasswordKey,
                      child: TextFormField(
                        onChanged: (text){
                          emailValue = text;
                        },
                        controller: displayNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter email Address';
                          }
                          if (!RegExp(
                              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(value)) {
                            return 'Please enter a valid email Address';
                          }
                          return null;
                        },
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(onPressed: () {
                        Future.delayed(Duration.zero, () {
                          Navigator.pop(context);
                          _forgotPasswordKey.currentState!.reset();
                        });
                      }, child: const Text('Cancel')),
                      ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () async {
                          if (_forgotPasswordKey.currentState!.validate()) {
                            // verify otp api
                            var forgotPassword = await forgotPasswordData(emailValue);
                            if (forgotPassword!.success == true){
                              Future.delayed(Duration.zero, () {
                                Navigator.pop(context);
                              });
                              Fluttertoast.showToast(
                                  msg: forgotPassword.error,
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                            else{
                              Fluttertoast.showToast(
                                  msg: forgotPassword.error,
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                            _forgotPasswordKey.currentState!.reset();
                          }
                        },
                      ),
                    ],
                  ),
                );
              }
          );
        },
    child: const Text(
      'Forgot Password', style: TextStyle(
        color: Colors.white
        ),
      ),
    ),
      ],
    );
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () { // this is the block you need
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return WillPopScope(
                  onWillPop: () async => false,
                  child: AlertDialog(
                    title: const Text('Do You Wish to Exit'),
                    actions: <Widget>[
                      ElevatedButton(onPressed: () {
                        SystemNavigator.pop();
                      }, child: const Text('Yes')),
                      ElevatedButton(
                        child: const Text('No'),
                        onPressed: () async {
                          Navigator.pop(context);

                        },
                      ),
                    ],
                  ),
                );
              }
          );
          return Future.value(false);
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  color: Colors.white,
                  child: Image.asset('assets/images/navigo3.jpg', height: MediaQuery.of(context).size.height * 0.6, width: MediaQuery.of(context).size.width,),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  color: Colors.indigo[900],
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20,),
                        _buildWelcome(),
                        const SizedBox(height: 30),
                        //_buildNaviDoc(),
                        //const SizedBox(height: 10),
                        _buildTrack(),
                        const SizedBox(height: 40),
                        _buildLoginId(),
                        const SizedBox(height: 10),
                        _buildPassword(),
                        const SizedBox(height: 10),
                        _buildLoginBtn(),
                        _buildRegisterBtn(),
                        const Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text('Powered by: NavigoAnalytixLLP', style:
                              TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )

          ),
        )
      ),
    );
  }
}



