import 'package:flutter/material.dart';
import 'package:wallpapersapp/all%20page/catagory.dart';
import 'package:wallpapersapp/all%20page/fav_page.dart';
import 'package:wallpapersapp/all%20page/homepage.dart';

class NaviBar extends StatefulWidget {
  final int selectedIndex;

  const NaviBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _NaviBarState createState() => _NaviBarState();
}

class _NaviBarState extends State<NaviBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              _onItemTapped(0);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
            ),
            child: Icon(
              Icons.photo_library,
              color: _selectedIndex == 0 ? Colors.purple : Colors.black,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _onItemTapped(1);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CatagoryPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
            ),
            child: Icon(
              Icons.category_sharp,
              color: _selectedIndex == 1 ? Colors.purple : Colors.black,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _onItemTapped(2);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritePage()),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            child: Icon(
              Icons.favorite,
              color: _selectedIndex == 2 ? Colors.purple : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
