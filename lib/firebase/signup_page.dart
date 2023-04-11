
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wallpapersapp/firebase/login_page.dart';
import 'package:wallpapersapp/all%20page/homepage.dart';
import 'package:wallpapersapp/widget/widget.dart';


class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  final _auth = FirebaseAuth.instance;
  late String email;
  late String Password;
  late String Name;
  bool _obsecureText = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  HomePage()),
            );
          },
        ),
      ),
      body:SingleChildScrollView(
         child: Center(
        child: Padding(padding: 
        const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(padding: EdgeInsets.only(right: 185),
            child:Text('Universal',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.indigo,fontFamily: 'Shojumaru-Regular',decoration: TextDecoration.underline,decorationThickness: 2,decorationStyle: TextDecorationStyle.double),),),
            
            const Text('WALLPAPERS',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.purpleAccent,fontFamily: 'Shojumaru-Regular'),),
            const SizedBox(
              height: 50,
            ),
            const Text('Registration',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),),
            const Padding(padding: EdgeInsets.all(15)),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                onChanged: (value) {
                  Name = value;
                },
                decoration: const InputDecoration(
                  
                  border: OutlineInputBorder(),
                  hintText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
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
            ),
            
            const SizedBox(height: 10,),
            Container(
              width: 335,
              child: ElevatedButton(
                onPressed: () async{

                  try{
                    await _auth.createUserWithEmailAndPassword(email: email, password: Password).then((value) => 
                     showDialog(context: context, builder: (context) => Widget_Page(context: context)
                     ),
                    );
                    const Text('success');
                  }catch(e){
                    print('Failed $e');
                    const Text("Failed");
                  }

              },
              style: ElevatedButton.styleFrom(
                        primary: Colors.indigo, // Change background color here
                      ),
               child: const Text(
                      'SIGNUP',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),),
            ),

             Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 const SizedBox(
                  width: 10,
                ),

                const Text('Already have an account?',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),

                TextButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
              },
             child: const Text('Log In',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.indigo),)),

               ],
             ),  
          ],
        ),
        ),
      ),
    ),
    );
  }
}