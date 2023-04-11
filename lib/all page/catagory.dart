import 'package:flutter/material.dart';
import 'package:wallpapersapp/catagories/abstract_page.dart';
import 'package:wallpapersapp/catagories/animals_page.dart';
import 'package:wallpapersapp/catagories/car&bikes_page.dart';
import 'package:wallpapersapp/catagories/foods_page.dart';
import 'package:wallpapersapp/catagories/games_page.dart';
import 'package:wallpapersapp/catagories/movies_page.dart';
import 'package:wallpapersapp/catagories/nature_page.dart';
import 'package:wallpapersapp/catagories/space_page.dart';
import 'package:wallpapersapp/catagories/sports_page.dart';
import 'package:wallpapersapp/catagories/travels_page.dart';
import 'package:wallpapersapp/widget/navi_bar.dart';

class CatagoryPage extends StatefulWidget {

  @override
  State<CatagoryPage> createState() => _CatagoryPageState();
}

class _CatagoryPageState extends State<CatagoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black), 
        backgroundColor: Colors.amber,
        
        title:Row(
          children: const [
            Text('Universal',style: TextStyle(color: Colors.indigo,fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'Shojumaru-Regular',decoration: TextDecoration.underline,decorationThickness: 2,decorationStyle: TextDecorationStyle.double)),
            SizedBox(
              width: 5,
            ),
            Text('Wallpapers',style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold,fontFamily: 'Shojumaru-Regular'),),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             const Padding(padding: EdgeInsets.only(top: 10)),
          const Text(
            'Catagories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Shojumaru-Regular',
              color: Colors.indigo,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            '......Select Your Catagory......',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              fontFamily: 'Shojumaru-Regular',
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Abstract()),
                );
              },
              child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
                  height: 140,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      image: DecorationImage(
                          image: AssetImage('assets/images/abstract/5.jpg'),
                          fit: BoxFit.cover),
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      'ABSTRACT',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Animal()),
                );
              },
              child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
                  height: 140,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      image: const DecorationImage(
                        image: AssetImage('assets/animals/21.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      'ANIMALS',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Car()),
                );
              },
              child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
                  height: 140,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      image: const DecorationImage(
                        image: AssetImage('assets/car/58.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      'CARS & BIKES',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Food() ),
                );
              },
              child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
                  height: 140,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      image: const DecorationImage(
                        image: AssetImage('assets/food/61.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      'FOODS',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Games()),
                );
              },
              child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
                  height: 140,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      image: const DecorationImage(
                        image: AssetImage('assets/games/71.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      'GAMES',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Movies()),
                );
              },
              child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
                  height: 140,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      image: const DecorationImage(
                        image: AssetImage('assets/movies/81.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      'MOVIES',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Nature()),
                );
              },
              child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
                  height: 140,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      image: const DecorationImage(
                        image: AssetImage('assets/nature/91.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      'NATURE',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sports()),
                );
              },
              child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
                  height: 140,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      image: const DecorationImage(
                        image: AssetImage('assets/sports/111.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      'SPORTS',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Space()),
                );
              },
              child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
                  height: 140,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      image: const DecorationImage(
                        image: AssetImage('assets/space/103.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      'SPACE',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Travel()),
                );
              },
              child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
                  height: 140,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      image: const DecorationImage(
                        image: AssetImage('assets/travel/121.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      'TRAVELS',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
          ],
        ),
      ),
      bottomNavigationBar:  NaviBar(selectedIndex: 1),
    );
  }
}
