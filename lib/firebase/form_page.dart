import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadForm extends StatefulWidget {
  @override
  _ImageUploadFormState createState() => _ImageUploadFormState();
}

class _ImageUploadFormState extends State<ImageUploadForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String _category = 'Select a category';
  late File? _imageFile = null;
  late String? _imageUrl = null;

  final List<String> _categories = [
    "Select a category",
    "Abstract",
    "Animal",
    "Car",
    "Food",
    "Games",
    "Movies",
    "Nature",
    "Space",
    "Sports",
    "Travel",
  ];

  void _uploadImage() async {
    // Upload image to Firebase Storage
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('images/${DateTime.now()}.jpg');
    UploadTask uploadTask = storageReference.putFile(_imageFile!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      _imageUrl = downloadUrl;
    });

    // Add image to Firestore collection
    FirebaseFirestore.instance.collection('images').add({
      'title': titleController.text,
      'description': descriptionController.text,
      'category': _category,
      'image_url': _imageUrl,
    });

    // Add image to category collection
    FirebaseFirestore.instance
        .collection('categories')
        .doc(_category.toLowerCase())
        .collection('images')
        .add({
      'title': titleController.text,
      'description': descriptionController.text,
      'category': _category,
      'image_url': _imageUrl,
    });

    // Clear text fields and image file
    titleController.clear();
    descriptionController.clear();
    setState(() {
      _category = 'Select a category';
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image',style: TextStyle(color: Colors.black),),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Column(
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
              height: 40,
            ),
            const Text(
              'Upload Image Form',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
            const SizedBox(
              height: 20,
            ),
            
            if (_imageFile != null)
              Image.file(
                _imageFile!,
                height: 200,
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final pickedFile =
                    await ImagePicker().getImage(source: ImageSource.gallery);
                setState(() {
                  _imageFile = File(pickedFile!.path);
                });
              },
              child: Text(
                'Select Image',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber, // sets background color
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left:16,right: 16),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.purple, // set border color here
                      width: 2, // set border width here
                    ),
                    borderRadius:
                        BorderRadius.circular(6), // set border radius here
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left:16,right: 16),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.purple, // set border color here
                      width: 2, // set border width here
                    ),
                    borderRadius:
                        BorderRadius.circular(6), // set border radius here
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left:16,right: 16),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple, // set border color here
                        width: 2, // set border width here
                      ),
                      borderRadius:
                          BorderRadius.circular(6), // set border radius here
                    ),
                ),
                value: _category,
                onChanged: (newValue) {
                  setState(() {
                    _category = newValue!;
                  });
                },
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _imageFile == null ? null : _uploadImage,
              child: Text(
                'Upload',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber, // sets background color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
