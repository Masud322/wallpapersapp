import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:wallpapersapp/firebase/signup_page.dart';
import 'package:wallpapersapp/all%20page/homepage.dart';
import 'package:wallpapersapp/widget/widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HomePage());
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String Password;
  bool _obsecureText = true;

  // AlertDialog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 185),
                  child: Text(
                    'Universal',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                        fontFamily: 'Shojumaru-Regular',
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        decorationStyle: TextDecorationStyle.double),
                  ),
                ),
                const Text(
                  'WALLPAPERS',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.purpleAccent,
                      fontFamily: 'Shojumaru-Regular'),
                ),
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  'LogIn',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                SizedBox(
                  width: 335,
                  child: TextField(
                    obscureText: _obsecureText,
                    onChanged: (value) {
                      Password = value;
                    },
                    decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.key),
                        suffixIcon: GestureDetector(
                          onTap: (() {
                            setState(() {
                              _obsecureText = !_obsecureText;
                            });
                          }),
                          child: Icon(_obsecureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 225),
                  child: TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                Forget_Page(context: context));
                      },
                      child: const Text(
                        'Forget Password',
                        style: TextStyle(color: Colors.blue),
                      )),
                ),
                Container(
                  width: 335,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await _auth
                            .signInWithEmailAndPassword(
                                email: email, password: Password)
                            .then(
                              (value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              ),
                            );
                      } catch (e) {
                        print('Failed $e');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo, // Change background color here
                    ),
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have account?",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signin()),
                          );
                        },
                        child: const Text(
                          'create new account',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
