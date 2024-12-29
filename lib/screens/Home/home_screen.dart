import 'package:ecommerce_mobile_app/models/product_model.dart';
import 'package:ecommerce_mobile_app/screens/Home/Widget/product_cart.dart';
import 'package:ecommerce_mobile_app/screens/Home/Widget/search_bar.dart';
import 'package:flutter/material.dart';

import '../../models/category.dart';
import 'Widget/home_app_bar.dart';
import 'Widget/image_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSlider = 0; // for the current image slider index which is 0
  int selectedIndex = 0; // for the selected index of the category selection which is 0 for all categories
  final TextEditingController _searchController = TextEditingController(); // for the search controller
  List<Product> filteredProducts = all; // for the filtered products which is all products
  bool isAscending = true; // for the sorting order which is ascending order which is true

  List<List<Product>> selectCategories = [ // for category selection
    all, // all products model data from product_model.dart
    shoes, // shoes products model data from product_model.dart
    beauty, // beauty products model data from product_model.dart
    womenFashion, // womenFashion products model data from product_model.dart
    jewelry, // jewelry products model data from product_model.dart
    menFashion // menFashion products model data from product_model.dart
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterProducts);// adds a listener to the search controller for filtering the products
  }

  void _filterProducts() {
    setState(() {
      filteredProducts = selectCategories[selectedIndex].where((product) {
        return product.title.toLowerCase().contains(_searchController.text.toLowerCase());
      }).toList();
    }); // it check if there is any product that contains the search text in the title and add it to the filtered products list
  }

  void _onToggleSortOrder() { // for the sorting order
    setState(() {
      isAscending = !isAscending;
      filteredProducts.sort((a, b) => isAscending ? a.price.compareTo(b.price) : b.price.compareTo(a.price)); // for sorting the products based on the price in ascending or descending order
    });
  }

  @override
  void dispose() { // for disposing the search controller because if we don't dispose it will cause memory leak
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // for background color
      body: SingleChildScrollView( // for scrolling the screen vertically
        child: Padding( // for padding from all side
          padding: const EdgeInsets.all(20), // for padding from all side
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // for start the column from start
            children: [
              const SizedBox(height: 10), // for space between the widgets in column
              // for custom appbar
              const CustomAppBar(), // CustomAppBar from home_app_bar.dart
              const SizedBox(height: 20), // for space between the first and search bar
              // for search bar
              CustomSearchBar( // CustomSearchBar from search_bar.dart
                controller: _searchController,
                onToggleSortOrder: _onToggleSortOrder,
              ),
              const SizedBox(height: 20), // for space between the search bar and category selection
              ImageSlider(
                currentSlide: currentSlider, // ImageSlider from image_slider.dart
                onChange: (value) { // for changing the image slider
                  setState(
                    () {
                      currentSlider = value; // for changing the image slider
                    },
                  );
                },
              ),
              const SizedBox(height: 20), // for space between the image slider and category selection
              // for category selection
              categoryItems(selectCategories), // for category selection from category.dart

              const SizedBox(height: 20), // for space between the category selection and shopping items
              if (selectedIndex == 0)
                const Row( // for the row of the text and see all text "Special For You" and "See all"
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // for space between first and second text
                  children: [
                    Text(
                      "Special For You",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              // for shopping items
              const SizedBox(height: 10), // for space between the text and shopping items
              GridView.builder( // for grid view of shopping items
                // padding: EdgeInsets.zero,
                // physics: const NeverScrollableScrollPhysics(), // for not scrolling the grid view
                shrinkWrap: true, // for not scrolling the grid view which means the grid view will take up only the space required by its content and no more.
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // for how many items in a one row
                    childAspectRatio: 0.75, // for the aspect ratio of the items
                    crossAxisSpacing: 20, // for the space between the items in a row
                    mainAxisSpacing: 20 // for the space between the rows
                ),
                itemCount: filteredProducts.length, // for the number of items in the grid view now it take the number from the all products
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: filteredProducts[index], // index used to get the product from the filtered products list form 0 to the length of the filtered products list
                  ); // for the product card from product_cart.dart it takes the product from the filtered products
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox categoryItems(List<List<Product>> selectCategories) { // for category selection
    return SizedBox( // for the size of the category selection
      height: 130, // for the height of the category selection
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // for the horizontal scrolling of the category selection
        itemCount: categoriesList.length, // for the number of items in the category selection
        physics: const BouncingScrollPhysics(), // for the physics of the scrolling
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index; // for the selected index of the category selection
                filteredProducts = selectCategories[selectedIndex]; // for the filtered products of the category selection
              });
            },
            child: Container(
              padding: const EdgeInsets.all(5), // for the padding of the category selection
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), // for the border radius of the category selection
                color: selectedIndex == index // for the color of the selected category
                    ? Colors.blue[200]  // for the color of the selected category be blue
                    : Colors.transparent, // for the color of the selected ca5tegory be blue and others be transparent
              ),
              child: Column( // for the column of the category selection items to hold the image and the title of the category
                children: [
                  Container(
                    height: 65, // for the height of the image
                    width: 65, // for the width of the image
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // for the shape of the image
                      image: DecorationImage(
                          image: AssetImage(categoriesList[index].image), // for the image of the category
                          fit: BoxFit.cover // for the image fit
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    categoriesList[index].title, // for the title of the category
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}