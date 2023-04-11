import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:wallpapersapp/all%20page/fav_page.dart';

class DetailsPage extends StatefulWidget {
  final String imageUrl;
  final String category;
  final String description;
  final String title;

  DetailsPage({
    required this.imageUrl,
    required this.category,
    required this.description,
    required this.title,
  });

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isFavorite = false;

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
  void initState() {
    super.initState();

    // check if this item is in the favorites list
    if (FavoritePage.favorites
        .any((item) => item.imageUrl == widget.imageUrl)) {
      isFavorite = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        iconTheme: const IconThemeData(color: Colors.black),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16,
              bottom: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Row(
                    children: [
                      Container(
                        width: 320,
                        child: Text(
                          'Title: ${widget.title}', // add 'Title: ' before item.title
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              // toggle the isFavorite variable
                              isFavorite = !isFavorite;

                              if (isFavorite) {
                                // add this item to the favorites list
                                FavoritePage.favorites.add(widget);
                              } else {
                                // remove this item from the favorites list
                                FavoritePage.favorites.removeWhere(
                                    (item) => item.imageUrl == widget.imageUrl);
                              }
                            });
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: isFavorite ? Colors.red : Colors.grey,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Category: ${widget.category}', // add 'Title: ' before item.title
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Description: ${widget.description}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: () {
                          _save(imageUrl: widget.imageUrl);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber, // background color
                          onPrimary: Colors.black, // text color
                        ),
                        child: const Text('Download Now',style: TextStyle(fontSize: 25),)))
              ],
            ),
          )),
        ],
      ),
    );
  }
}
