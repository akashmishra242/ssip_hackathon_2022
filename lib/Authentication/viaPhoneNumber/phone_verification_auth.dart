import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../home_page.dart';
import '../../models/UserModel.dart';

class SignInWithPhone extends StatefulWidget {
  const SignInWithPhone({Key? key}) : super(key: key);

  @override
  State<SignInWithPhone> createState() => _SignInWithPhoneState();
}

class _SignInWithPhoneState extends State<SignInWithPhone> {
  bool haspressed = false;
  var isloading = false;
  String verificationid = '';
  String errorMessage = '';
  //form key
  final _formkey = GlobalKey<FormState>();

// editing controller
  final TextEditingController phonenoController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

//Send OTP Function
  void sendOTP() async {
    String phoneno = phonenoController.text.trim().substring(0, 3) == '+91'
        ? phonenoController.text.trim()
        : "+91${phonenoController.text.trim()}";
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneno,
        codeSent: (verificationId, forceResendingToken) {
          if (_formkey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("OTP Sent Successfully"),
              ),
            );
            setState(() {
              haspressed = true;
              verificationid = verificationId;
            });
          }
        },
        verificationCompleted: (Credential) {},
        verificationFailed: (error) {
          log(error.code.toString());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.code.toString()),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: const Duration(seconds: 45));
  }

  //verify OTP

  void verifyOTP() async {
    String otp = otpController.text.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationid, smsCode: otp);

    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((uid) => {
                setState(() {
                  isloading = false;
                }),
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Login Successfull"),
                )),
                postphonenologinDetailsToFirestore(),
                Navigator.of(context).popUntil((route) => route.isFirst),
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                ),
              });
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
      log(error.code);
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    //phone number field
    final phonenoField = TextFormField(
      autofocus: false,
      controller: phonenoController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Phone number");
        }
        // reg expression for email validation
        if (!RegExp(
                r"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$")
            .hasMatch(value)) {
          return ("Please Enter a valid Phone number");
        }
        return null;
      },
      onSaved: (value) {
        phonenoController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.phone),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Enter Phone Number",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //Otp field
    final otpField = TextFormField(
      autofocus: false,
      controller: otpController,
      keyboardType: TextInputType.number,
      obscureText: false,
      maxLength: 6,
      validator: (value) {
        RegExp regex = RegExp(r'/^[0-9]+$/');
        if (value!.isEmpty) {
          return ("Enter OTP");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid OTP");
        }
      },
      onSaved: (value) {
        otpController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Enter OTP",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (FirebaseAuth.instance.currentUser == null) {
            setState(() {
              isloading = true;
            });
          }
          verifyOTP();
        },
        child: const Text(
          "Verify OTP",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final sendOtpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          sendOTP();
        },
        child: const Text(
          "Send OTP",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Visibility(
            visible: !isloading,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(36),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: Image.network(
                              "https://previews.123rf.com/images/3xy/3xy2001/3xy200100002/139226140-lady-justice-themis-with-sword-and-scales-fair-trial-law-femida-blindfolded-lady-logo-or-label-for-l.jpg"),
                        ),
                        const SizedBox(height: 45),
                        !haspressed ? phonenoField : otpField,
                        const SizedBox(height: 35),
                        !haspressed ? sendOtpButton : loginButton,
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  postphonenologinDetailsToFirestore() async {
    UserModel userModel = UserModel();
    userModel.email = 'N/A';
    userModel.uid = FirebaseAuth.instance.currentUser?.uid;
    userModel.firstName = 'N/A';
    userModel.secondName = 'N/A';
    userModel.phoneno = FirebaseAuth.instance.currentUser?.phoneNumber;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(userModel.toMap());
  }
}
