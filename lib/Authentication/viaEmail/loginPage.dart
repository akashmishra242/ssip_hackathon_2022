import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../home_page.dart';
import '../../models/UserModel.dart';
import '../viaPhoneNumber/phone_verification_auth.dart';
import 'SignupPage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static final auth = FirebaseAuth.instance;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//loading indicator
  var isloading = false;

  //form key
  final _formkey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //firebase

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
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
          signIn(emailController.text, passwordController.text);
        },
        child: const Text(
          "LOGIN",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
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
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 200,
                        child: Image.network(
                            "https://previews.123rf.com/images/3xy/3xy2001/3xy200100002/139226140-lady-justice-themis-with-sword-and-scales-fair-trial-law-femida-blindfolded-lady-logo-or-label-for-l.jpg"),
                      ),
                      const SizedBox(height: 45),
                      emailField,
                      const SizedBox(height: 25),
                      passwordField,
                      const SizedBox(height: 35),
                      loginButton,
                      const SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text("Don't have an account? "),
                            "SignUp"
                                .text
                                .color(Colors.red)
                                .bold
                                .make()
                                .onTap(() {
                              Navigator.pushReplacementNamed(
                                  context, "/signup");
                            }),
                          ]),
                      SizedBox(
                        height: 60,
                        child: Divider(
                          color: Colors.black,
                          height: 20,
                          thickness: 2,
                          indent: MediaQuery.of(context).size.width * 0.10,
                          endIndent: MediaQuery.of(context).size.width * 0.10,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65 > 275
                            ? 275
                            : MediaQuery.of(context).size.width * 0.65,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            googleSignIn();
                          },
                          elevation: 5,
                          label: const Text(
                            "Signin with Google",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          icon: Image.network(
                            "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-suite-everything-you-need-know-about-google-newest-0.png",
                            height: 32,
                            width: 32,
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65 > 275
                            ? 275
                            : MediaQuery.of(context).size.width * 0.65,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SignInWithPhone()),
                            );
                          },
                          elevation: 5,
                          label: const Text(
                            "Signin with Phone Number",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          icon: const Icon(
                            Icons.phone,
                            color: Colors.redAccent,
                            size: 35,
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Email Password login function
  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        await LoginScreen.auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  setState(() {
                    isloading = false;
                  }),
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Login Successfull"),
                  )),
                  Navigator.of(context).popUntil((route) => route.isFirst),
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  ),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage!),
        ));
        print(error.code);
      }
    }
  }

//Google Sign in Function
  void googleSignIn() async {
    setState(() {
      isloading = true;
    });

    GoogleSignIn googleSignin = GoogleSignIn(scopes: ['email']);

    try {
      final GoogleSignInAccount? googlesigninaccount =
          await googleSignin.signIn();
      if (googlesigninaccount == null) {
        setState(() {
          isloading = false;
        });
      }
      final GoogleSignInAuthentication =
          await googlesigninaccount?.authentication;

      final credential = GoogleAuthProvider.credential(
          idToken: GoogleSignInAuthentication?.idToken,
          accessToken: GoogleSignInAuthentication?.accessToken);
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {});
      postGloginDetailsToFirestore(googlesigninaccount!);
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage!),
      ));
      log(error.code);
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

//posting google logedin user's details to firebase's firestore
  postGloginDetailsToFirestore(GoogleSignInAccount account) async {
    UserModel userModel = UserModel();
    userModel.email = account.email;
    userModel.uid = FirebaseAuth.instance.currentUser?.uid;
    userModel.firstName = account.displayName?.split(' ')[0];
    userModel.secondName = account.displayName?.split(' ')[1] ?? 'N/A';

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(userModel.toMap());

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("login Successfull"),
      ),
    );
    Navigator.of(context).popUntil((route) => route.isFirst);
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MyHomePage()),
    );
  }
}
