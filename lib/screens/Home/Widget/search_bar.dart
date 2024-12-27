// lib/screens/Home/Widget/search_bar.dart

import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onToggleSortOrder;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onToggleSortOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55, // for the height of the search bar
      width: double.infinity, // for the width of the search bar which is the width of the screen size
      decoration: BoxDecoration(
        color: Colors.grey[200], // for the background color of the search bar
        borderRadius: BorderRadius.circular(30), // for the border radius of the search bar to make it round
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5), // to make space between the search bar and the text field
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.grey,
            size: 30,
          ),
          const SizedBox(width: 10),
          Flexible(
            flex: 4,
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 25,
            width: 1.5,
            color: Colors.grey,
          ), // for the vertical line between the search bar and the sort icon
          IconButton(
            onPressed: onToggleSortOrder,
            icon: const Icon(
              Icons.sort,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}