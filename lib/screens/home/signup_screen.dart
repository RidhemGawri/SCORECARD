import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resultproject/utils/utils.dart';
import 'package:resultproject/widgets/round_button.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  bool _isHiddenPassword = true;
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth
      .instance; // _auth is the object,we are initializing here and getting instance of of firebase
// _auth gives the exposure of api's from the package we have initialized
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

 void Signup(){
   setState(() {
                    loading = true;
                  });
                  _auth.createUserWithEmailAndPassword(
                          email: emailcontroller.text.toString(),
                          password: passwordcontroller.text.toString()).then((value) {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                          loading = false;
                       });
                    }
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString()); // Utils class
                    if (_formKey.currentState!.validate()) {
                  setState(() {
                    loading = false;
                  });}
                  });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sign up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          helperText: 'enter email e.g. john@gmail.com',
                          prefixIcon: Icon(Icons.alternate_email)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter email';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordcontroller,
                      obscureText: _isHiddenPassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        helperText: 'Password must be at least six characters',
                        prefixIcon: Icon(Icons.lock_open),
                        suffixIcon: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            _isHiddenPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      }),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            RoundButton(
              title: 'Sign up',
              loading: loading,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  Signup();
                //   setState(() {
                //     loading = true;
                //   });
                //   _auth.createUserWithEmailAndPassword(
                //           email: emailcontroller.text.toString(),
                //           password: passwordcontroller.text.toString()).then((value) {
                //         if (_formKey.currentState!.validate()) {
                //           setState(() {
                //           loading = false;
                //        });
                //     }
                //   }).onError((error, stackTrace) {
                //     Utils().toastMessage(error.toString()); // Utils class
                //     if (_formKey.currentState!.validate()) {
                //   setState(() {
                //     loading = false;
                //   });}
                //   });
                 }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    },
                    child: Text("Login")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _togglePasswordView() {
    // if (_isHiddenPassword == true) {
    //   _isHiddenPassword == false;
    // } else {
    //   _isHiddenPassword = true;
    // }
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }
}
