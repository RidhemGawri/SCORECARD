import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resultproject/utils/utils.dart';
import 'package:resultproject/widgets/round_button.dart';

import '../../config/config.dart';
import '../../provider/auth_provider.dart';
import '../../widgets/large_button.dart';
import '../../widgets/text_field_button.dart';
import 'login_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  // bool loading = false;

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authprovider=ref.watch(authProvider);
    final wsize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: emailcontroller,
                style: GoogleFonts.inter(
                  fontSize: 16.0,
                  color: const Color(0xFF15224F),
                ),
                maxLines: 1,
                cursorColor: const Color(0xFF15224F),
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    labelText: "Enter your Email",
                    labelStyle: GoogleFonts.inter(
                      fontSize: 12.0,
                      color: const Color(0xFF969AA8),
                    ),
                    border: const OutlineInputBorder()),
                validator: validateEmail,
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: passwordcontroller,
                style: GoogleFonts.inter(
                  fontSize: 16.0,
                  color: const Color(0xFF15224F),
                ),
                maxLines: 1,
                cursorColor: const Color(0xFF15224F),
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    labelText: "Enter your Password",
                    labelStyle: GoogleFonts.inter(
                      fontSize: 12.0,
                      color: const Color(0xFF969AA8),
                    ),
                    border: const OutlineInputBorder()),
                validator: (value) {
                  if(value!.isEmpty){
                    return "Enter a Password";
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              authprovider.signloading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : Button(
                  titlecolor: Colors.white,
                  buttoncolor: AppConfig.primaryColor,
                  title: 'Login',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      authprovider.signIn(emailcontroller.text, passwordcontroller.text, context);
                      print("valid");
                    } else {
                      print("not valid");
                    }
                  }),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);
  if (value!.isEmpty) {
    return "Enter a Email Address";
  } else {
    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }
}
