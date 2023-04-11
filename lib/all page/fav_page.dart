import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallpapersapp/all%20page/details_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:wallpapersapp/widget/navi_bar.dart';

class FavoritePage extends StatefulWidget {
  static List<DetailsPage> favorites = [];

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  _save({required String imageUrl}) async {
    var response = await Dio()
        .get(imageUrl, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "image");
    print(result);
    Fluttertoast.showToast(msg: '$result');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.amber,
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              '.....Favorites.....',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Shojumaru-Regular',
                color: Colors.indigo,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 12, right: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 2,
                  vertical: 2,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: FavoritePage.favorites.isEmpty
                    ? const Center(
                        child: Text(
                          'No favorites added yet',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: FavoritePage.favorites.length,
                        itemBuilder: (context, index) {
                          var item = FavoritePage.favorites[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                    appBar: AppBar(
                                      title: Text(
                                        item.title,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      backgroundColor: Colors.amber,
                                      automaticallyImplyLeading: false,
                                    ),
                                    body: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 300,
                                          child: Hero(
                                            tag: item.imageUrl,
                                            child: Image.network(
                                              item.imageUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Title: ${item.title}', // add 'Title: ' before item.title
                                                        style: const TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'Category: ${item.category}', // add 'Title: ' before item.title
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'Description: ${item.description}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(height: 200),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    ElevatedButton.icon(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors
                                                            .amber, // background color
                                                        onPrimary: Colors
                                                            .black, // text color
                                                      ),
                                                      icon: const Icon(Icons
                                                          .arrow_back_ios_rounded),
                                                      label: const Text(
                                                        'Back',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    ElevatedButton.icon(
                                                      onPressed: () {
                                                        _save(
                                                            imageUrl:
                                                                item.imageUrl);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors
                                                            .amber, // background color
                                                        onPrimary: Colors
                                                            .black, // text color
                                                      ),
                                                      icon: const Icon(Icons
                                                          .download_rounded),
                                                      label: const Text(
                                                        'Download',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Image.network(item.imageUrl),
                              title: Text(
                                'Title: ${item.title}', // add 'Title: ' before item.title
                              ),
                              subtitle: Text('Category: ${item.category}'),
                              trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    // remove the item from the favorites list
                                    FavoritePage.favorites.remove(item);
                                  });
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: FavoritePage.favorites.contains(item)
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NaviBar(selectedIndex: 2),
    );
  }
}
