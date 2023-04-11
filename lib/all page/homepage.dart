import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallpapersapp/catagories/abstract_page.dart';
import 'package:wallpapersapp/catagories/animals_page.dart';
import 'package:wallpapersapp/all%20page/details_page.dart';
import 'package:wallpapersapp/catagories/car&bikes_page.dart';
import 'package:wallpapersapp/catagories/foods_page.dart';
import 'package:wallpapersapp/catagories/games_page.dart';
import 'package:wallpapersapp/catagories/movies_page.dart';
import 'package:wallpapersapp/catagories/nature_page.dart';
import 'package:wallpapersapp/catagories/space_page.dart';
import 'package:wallpapersapp/catagories/sports_page.dart';
import 'package:wallpapersapp/catagories/travels_page.dart';
import 'package:wallpapersapp/widget/drawer.dart';
import 'package:wallpapersapp/widget/navi_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'All';

  Future<void> _deleteImage(DocumentSnapshot snapshot) async {
    try {
      await snapshot.reference.delete();
    } catch (e) {
      print('Error deleting image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool someCondition = false;

    return WillPopScope(
      onWillPop: () async {
        if (someCondition) {
          return true;
        } else {
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.purple,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(
            children: const [
              Text('Universal',
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
          backgroundColor: Colors.amber,
          actions: [
            IconButton(
                color: Colors.black,
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                      context: context, delegate: CustomSearchDelegate());
                })
          ],
        ),
        drawer: AppDrawer(),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                '.....All Photos Here.....',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Shojumaru-Regular',
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('images')
                      .where('category',
                          isEqualTo: _selectedCategory != 'All'
                              ? _selectedCategory
                              : null)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.only(left: 12, right: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 2,
                          vertical: 2,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(

                              //topLeft: Radius.circular(30),
                              //topRight: Radius.circular(30),
                              ),
                        ),
                        child: GridView.builder(
                          padding: EdgeInsets.all(2),
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 7,
                            mainAxisSpacing: 7,
                          ),
                          itemBuilder: (context, index) {
                            final item = snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsPage(
                                      imageUrl: item['image_url'],
                                      title: item['title'],
                                      description: item['description'],
                                      category: item['category'],
                                    ),
                                  ),
                                );
                              },
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Delete Image?'),
                                      content: Text(
                                          'Are you sure you want to delete this image?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Delete'),
                                          onPressed: () {
                                            _deleteImage(
                                                snapshot.data!.docs[index]);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(0),
                                  image: DecorationImage(
                                    image: NetworkImage(item['image_url']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NaviBar(selectedIndex: 0),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchResult = [
    'Abstract',
    'Animal',
    "Car",
    "Food",
    "Games",
    "Movies",
    "Nature",
    "Space",
    "Sports",
    "Travel",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
          style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResult.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Abstract()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Animal()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Car()),
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Food()),
                );
                break;
              case 4:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Games()),
                );
                break;
              case 5:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Movies()),
                );
                break;
              case 6:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Nature()),
                );
                break;
              case 7:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Space()),
                );
                break;
              case 8:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Sports()),
                );
                break;
              case 9:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Travel()),
                );
                break;
              
            }
          },
        );
      },
    );
  }
}
