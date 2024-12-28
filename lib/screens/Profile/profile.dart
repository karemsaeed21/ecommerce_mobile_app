import 'package:flutter/material.dart';
import 'package:ecommerce_mobile_app/screens/Favorite/favorite.dart';

import '../../constants.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // This gets the size of the screen
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile' , style: TextStyle(color: Colors.black , fontSize: 25)), // Text widget to hold the title of the app bar
        backgroundColor: kprimaryColor,
        centerTitle: true, // This centers the title of the app bar
        // automaticallyImplyLeading: true, // This ensures the back button is shown
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container( // container to hold the profile image and name
              height: size.height * 0.3,
              width: double.infinity, // This makes the container take the full width of the screen
              decoration: const BoxDecoration(
                color: kprimaryColor, // This gives the container a color
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30), // This gives the container rounded corners
                  bottomRight: Radius.circular(30), // This gives the container rounded corners
                ),
              ),
              child: const Column( // Column to hold the profile image and name
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar( // CircleAvatar to hold the profile image
                    radius: 50,
                    backgroundImage: AssetImage("images/profile.webp"),
                  ),
                  SizedBox(height: 10),
                  Text( // Text widget to hold the profile name
                    "John Doe",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // SizedBox to add space between the profile image and the list items
            Padding( // Padding to add padding to the list items
              padding: const EdgeInsets.symmetric(horizontal: 20), // This adds padding to the left and right of the list items
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.favorite, color: kprimaryColor), // Icon widget to hold the icon in the first list item
                      title: const Text("Wishlist"), // Text widget to hold the text in the first list item
                      trailing: const Icon(Icons.arrow_forward_ios), // Icon widget to hold the icon in the first list item
                      onTap: () { // This function is called when the list item is tapped
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Favorite(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.settings, color: kprimaryColor),
                      title: const Text("Settings"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to Settings screen
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.logout, color: kprimaryColor),
                      title: const Text("Logout"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Handle logout
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}