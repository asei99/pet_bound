import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;

  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

void login(BuildContext ctx) {
  Navigator.of(ctx).pushNamed('/login');
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var isLogin = true;
  var userEmail = '';
  var userName = '';
  var userPassword = '';
  TextEditingController passwordText = TextEditingController();

  void trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(userEmail.trim(), userPassword.trim(), userName.trim(),
          isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color.fromRGBO(235, 171, 171, 1),
      backgroundColor: Color.fromRGBO(255, 239, 226, 1),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 1 / 9,
                child: Center(
                  child: Text(
                    'Pet Bound',
                    style: TextStyle(fontFamily: 'acme', fontSize: 50),
                  ),
                ),
              ),
              Container(
                  child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      // height: MediaQuery.of(context).size.height * 1 / 1.4,
                      // color: Colors.blue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 25),
                            height: MediaQuery.of(context).size.height * 1 / 5,
                            // color: Colors.grey,
                            child: !isLogin
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Create New',
                                        style: TextStyle(
                                            fontFamily: 'lato', fontSize: 28),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('Account.',
                                          style: TextStyle(
                                              fontFamily: 'lato',
                                              fontSize: 28)),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Sign in',
                                        style: TextStyle(
                                            fontFamily: 'lato', fontSize: 28),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('to continue',
                                          style: TextStyle(
                                              fontFamily: 'lato',
                                              fontSize: 28)),
                                    ],
                                  ),
                          ),
                          //list text field

                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                if (!isLogin)
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'username is empty';
                                      } else if (value.length < 5) {
                                        return 'username must more than 5 word';
                                      }
                                      return null;
                                    },
                                    autofocus: false,
                                    // style: TextStyle(color: Colors.pink),
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey[300],

                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),

                                      prefixIcon: Icon(
                                        FontAwesome.user,
                                      ),
                                      labelText: 'User Name',

                                      // labelStyle: TextStyle(
                                      //   color: Colors.pink,
                                      // ),
                                    ),
                                    onSaved: (value) {
                                      userName = value;
                                    },
                                  ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Email is empty';
                                    } else if (value.length < 5) {
                                      return 'Email must more than 5 word';
                                    } else if (!value.contains('@')) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  // style: TextStyle(color: Colors.pink),
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey[300],
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),

                                    prefixIcon: Icon(
                                      FontAwesome.envelope,
                                    ),
                                    labelText: 'Email',

                                    // labelStyle: TextStyle(
                                    //   color: Colors.pink,
                                    // ),
                                  ),
                                  onSaved: (value) {
                                    userEmail = value;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Password is empty';
                                    } else if (value.length < 6) {
                                      return 'Password must more than 5 word';
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  obscureText: true,
                                  // style: TextStyle(color: Colors.pink),
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey[300],
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    prefixIcon: Icon(
                                      FontAwesome.lock,
                                    ),
                                    labelText: 'Password',
                                  ),
                                  controller: passwordText,
                                  onSaved: (value) {
                                    userPassword = value;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (!isLogin)
                                  TextFormField(
                                    obscureText: true,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'password is empty';
                                      } else if (value != passwordText.text) {
                                        return 'password didnt match';
                                      } else if (value.length < 6) {
                                        return 'Password must more than 5 word';
                                      }
                                      return null;
                                    },

                                    autofocus: false,
                                    // style: TextStyle(color: Colors.pink),
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey[300],
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                      prefixIcon: Icon(
                                        FontAwesome.lock,
                                      ),
                                      labelText: 'Re-Enter Password',

                                      // labelStyle: TextStyle(
                                      //   color: Colors.pink,
                                      // ),
                                    ),
                                  ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          if (widget.isLoading)
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          if (!widget.isLoading)
                            InkWell(
                              onTap: () => trySubmit(),
                              child: Container(
                                width: 280,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(237, 171, 172, 80),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Text(
                                  !isLogin ? 'Sign Up' : 'Login',
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!widget.isLoading)
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4,
                      child: Container(
                        height: size.height * 1 / 15,
                        child: !isLogin
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'I already have an account? ',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLogin = !isLogin;
                                        passwordText.clear();
                                      });
                                    },
                                    child: Text(
                                      'Sign in',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      'Dont’t have account? ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'lato',
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLogin = !isLogin;
                                        passwordText.clear();
                                      });
                                    },
                                    child: Container(
                                      child: Text(
                                        'Create new account',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue,
                                          fontFamily: 'lato',
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                      ),
                    ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
