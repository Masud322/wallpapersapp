import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:wallpapersapp/all%20page/about_page.dart';
import 'package:wallpapersapp/all%20page/catagory.dart';
import 'package:wallpapersapp/all%20page/fav_page.dart';
import 'package:wallpapersapp/firebase/login_page.dart';
import 'package:wallpapersapp/firebase/form_page.dart';
import 'package:wallpapersapp/all%20page/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HomePage());
}

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String Password;

  final auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          AppBar(
            backgroundColor: Colors.amber,
            title: Row(
              children: const [
                Text('Univarsal',
                    style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Shojumaru-Regular',
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        decorationStyle: TextDecorationStyle.double)),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Wallpapers',
                  style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Shojumaru-Regular'),
                ),
              ],
            ),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.category,
            ),
            title: const Text('Categories'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CatagoryPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.favorite,
            ),
            title: const Text('Favorite'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritePage()),
              );
            },
          ),
          ListTile(
              leading: const Icon(
                Icons.add_a_photo,
              ),
              title: const Text('Add Your Photos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImageUploadForm()),
                );
              }),
          ListTile(
            leading: const Icon(
              Icons.info,
            ),
            title: const Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
          if (user == null)
            ListTile(
              leading: const Icon(
                Icons.login,
              ),
              title: const Text('Login / Sign In'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const Signin()),
                // );
              },
            )
          else
            ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: const Text('Logout'),
              onTap: () async {
                try {
                  await _auth.signOut().then(
                        (value) => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        ),
                      );
                  print('logout');
                } catch (e) {
                  print('Failed $e');
                }
              },
            )
        ],
      ),
    );
  }
}
