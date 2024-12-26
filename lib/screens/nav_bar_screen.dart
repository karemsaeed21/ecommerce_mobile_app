import 'package:ecommerce_mobile_app/constants.dart';
import 'package:ecommerce_mobile_app/screens/Cart/cart_screen.dart';
import 'package:ecommerce_mobile_app/screens/Home/home_screen.dart';
import 'package:ecommerce_mobile_app/screens/Profile/profile.dart';

import 'package:flutter/material.dart';
import 'Favorite/favorite.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 2; // to set the current index of the bottom navigation bar to open the home screen by default
    List screens = const [ // to set the screens that will be displayed when the user clicks on the bottom navigation bar
      HomeScreen(),
      Favorite(),
      HomeScreen(),
      CartScreen(),
      Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton( // to set the floating action button the home button in the middle
        onPressed: () {
          setState(() {
            currentIndex = 2;
          });
        },
        shape: const CircleBorder(), // to set the shape of the floating action button
        backgroundColor: kprimaryColor, // to set the background color of the floating action button
        child: const Icon(
          Icons.home, // to set the icon of the floating action button to the home icon
          color: Colors.white, // to set the color of the icon
          size: 35, // to set the size of the icon
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // to set the location of the floating action button
      bottomNavigationBar: BottomAppBar(
        // elevation: 100,
        height: 60, // to set the height of the bottom navigation bar
        color: Colors.white,  // to set the color of the bottom navigation bar
        shape: const CircularNotchedRectangle(), // to set the shape of the bottom navigation bar to be circular
        notchMargin: 10, // to set the margin of the bottom navigation bar from the floating action button
        // clipBehavior: Clip.antiAliasWithSaveLayer,  // to set the clip behavior of the bottom navigation bar
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                });
              },
              icon: Icon(
                Icons.grid_view_outlined,
                size: 30,
                color: currentIndex == 0 ? kprimaryColor : Colors.grey.shade400, // to change the color of the icon when it is selected
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 1;
                });
              },
              icon: Icon(
                Icons.favorite_border,
                size: 30,
                color: currentIndex == 1 ? kprimaryColor : Colors.grey.shade400,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 3;
                });
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 30,
                color: currentIndex == 3 ? kprimaryColor : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 4;
                });
              },
              icon: Icon(
                Icons.person,
                size: 30,
                color: currentIndex == 4 ? kprimaryColor : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
      body: screens[currentIndex],
    );
  }
}
