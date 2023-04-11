import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallpapersapp/all%20page/details_page.dart';
import 'package:wallpapersapp/widget/navi_bar.dart';

class Animal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Row(
          children: const [
            Text('Universal',style: TextStyle(color: Colors.indigo,fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'Shojumaru-Regular',decoration: TextDecoration.underline,decorationThickness: 2,decorationStyle: TextDecorationStyle.double)),
            SizedBox(
              width: 5,
            ),
            Text('Wallpapers',style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold,fontFamily: 'Shojumaru-Regular'),),
          ],
        ),
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
                height: 15,
              ),
              const Text(
                '.....Animals.....',
                style: TextStyle(
                  fontSize: 20,
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
                    .where('category', isEqualTo: 'Animals')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
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
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 7,
                          mainAxisSpacing: 7,
                        ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot document = snapshot.data!.docs[index];
                          final item =
                              snapshot.data!.docs[index].data() as Map<String, dynamic>;
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
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                image: DecorationImage(
                                  image: NetworkImage(document['image_url']),
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
      bottomNavigationBar:  NaviBar(selectedIndex: 1),
    );
  }
}
