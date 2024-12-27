import 'package:ecommerce_mobile_app/Provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../Detail/detail_screen.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final finalList = provider.favorites;
    return Scaffold(
      backgroundColor: kcontentColor, // background color of the screen
      appBar: AppBar( // appbar of the screen
        backgroundColor: kcontentColor,
        title: const Text(
          "Favorite",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
            children: [
              Expanded(
              child: ListView.builder(
                itemCount: finalList.length, // length of the list
                itemBuilder: (context, index) { // listview builder to show the list of favorite items
                final favoriteItems = finalList[index];
                return GestureDetector( // to click on the item to navigate to the detail screen
                  onTap: () {
                  Navigator.push(
                  context,
                    MaterialPageRoute(
                    builder: (context) => DetailScreen(product: finalList[index]),
                    ),
                  );
                },
      child: Stack( // stack to show the delete button on the right top of the container
        children: [
        Padding(
        padding: const EdgeInsets.all(15), // padding of the container from all sides
        child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        ),
      child: Row(
      children: [
      Container( // container to show the image of the favorite item
      padding: const EdgeInsets.all(10),
      width: 85,
      height: 85,
      decoration: BoxDecoration(
      color: kcontentColor,
      borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset(favoriteItems.image),
      ),
      const SizedBox(width: 10),
      Column( // column to show the title, category and price of the favorite item
      crossAxisAlignment: CrossAxisAlignment.start, // to align the text to the left
      children: [ // to show the title, category and price of the favorite item
      Text(
      favoriteItems.title,
      style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      ),
      ),
      const SizedBox(height: 5),
      Text(
      favoriteItems.category,
      style: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.grey.shade400,
      fontSize: 16,
      ),
      ),
      const SizedBox(height: 10),
      Text(
      "\$${favoriteItems.price}",
      style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      ),
      ),
      ],
      )
      ],
      ),
      ),
      ),
      // for delete button
      Positioned(
        top: 50,right: 35,
        child: GestureDetector(
        onTap: () {
        finalList.removeAt(index);
        setState(() {

        });
        },
        child: const Icon(
        Icons.delete,
        color: kprimaryColor,
        size: 25,
      ),
      ),
      ),
      ],
      ),
      );
    }
        )
        )
        ],
        ),
      );
    }
}