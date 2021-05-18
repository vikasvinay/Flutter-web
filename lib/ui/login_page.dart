import 'package:ecommerce_admin/services/login_service.dart';
import 'package:ecommerce_admin/services/routing/page_names.dart';
import 'package:ecommerce_admin/services/routing/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Auth _auth = Auth();
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Observer(
      builder: (_) {
        if (_auth.error) {
          return SnackBar(content: Text("Invalid Email"));
          // ScaffoldMessenger.of(context)
          // .showSnackBar(SnackBar(content: Text("Invalid Email")));
        } else {
          return SnackBar(content: Text("Enter details.."));
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.grey,
      // appBar: AppBar(
      //   title: Text("Login Page"),
      // ),
      body: SafeArea(
          child: ListView(
        children: [
          SizedBox(
            height: 0.2.sh,
          ),
          Center(
            child: Material(
              elevation: 8,
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20.r),
              child: Container(
                width: 0.4.sw,
                height: 0.5.sh,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Text("Login",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.sp)),
                    ),
                    Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Observer(builder: (_) {
                              return Container(
                                  width: 80.w,
                                  child: TextFormField(
                                    controller: _email,
                                    onChanged: _auth.setEmail,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "please enter valid email";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        // errorText: ,
                                        hintText: "email",
                                        prefixIcon: Icon(Icons.email)),
                                  ));
                            }),

                            SizedBox(
                              height: 40.h,
                            ),
                            Observer(builder: (_) {
                              return Container(
                                  width: 80.w,
                                  child: TextFormField(
                                    controller: _password,
                                    onChanged: _auth.setPassword,
                                    obscureText: _auth.passwordVisible,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "please enter valid password";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "password",
                                        suffixIcon: IconButton(
                                          icon: _auth.passwordVisible
                                              ? Icon(Icons.visibility)
                                              : Icon(Icons.visibility_off),
                                          onPressed: _auth.setPasswordVisible,
                                        ),
                                        prefixIcon: Icon(Icons.lock)),
                                  ));
                            }),
                            // SizedBox(
                            //   height: 80.h,
                            // ),
                          ],
                        )),
                    // Spacer(),
                    Observer(builder: (_) {
                      return MaterialButton(
                        onPressed: _auth.loginPressed,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 20.h),
                        color: Colors.grey[300],
                        hoverColor: Colors.cyanAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)),
                        child: _auth.loading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20.sp),
                                textAlign: TextAlign.justify,
                              ),
                      );
                    }),
                    Observer(builder: (_) {
                      if (_auth.error) {
                        return Text(
                          "Invalid credentials",
                          style: TextStyle(color: Colors.red, fontSize: 16.sp),
                        );
                      } else {
                        return Container();
                      }
                    })
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  // void validate() async {
  //   if (_formKey.currentState.validate()) {

  //     // await FirebaseAuth.instance
  //     //     .signInWithEmailAndPassword(
  //     //         email: _email.text.trim(), password: _password.text.trim());

  //     await _auth.loginWithEmail(email: _email.text.trim(), password: _password.text.trim()).then((value) {
  //       // Navigator.pushNamedAndRemoveUntil(context, RouteNames.route, (route) => false);
  //     });
  //     print(_password.text.trim());
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Invalid Email")));
  //   }
  // }

  ReactionDisposer disposer;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _auth = Provider.of<Auth>(context);
    disposer = reaction((_) => _auth.loggedIn, (loggedIn) {
      if (loggedIn)
        FluroRoute.router.navigateTo(context, RouteNames.home,
            clearStack: true, replace: true);
    });
  }
}
