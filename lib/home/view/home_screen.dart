import 'package:ahmed_mustafa_amazon/home/view/feed_page.dart';
import 'package:ahmed_mustafa_amazon/upload/view/upload_page.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:products_repository/products_repository.dart';

import 'profile_page.dart';
import '../bloc/products_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int selectedIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: selectedIndex == 0 ? FeedPage() : ProfilePage(),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: [
            Icons.feed,
            Icons.account_circle,
          ],
          activeColor: Colors.cyan,
          iconSize: 35,
          gapLocation: GapLocation.center,
          activeIndex: selectedIndex,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (e) {
            setState(() {
              selectedIndex = selectedIndex == 1 ? 0 : 1;
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => UploadPage()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
