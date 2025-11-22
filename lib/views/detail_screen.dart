import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/amiibo_model.dart';
import '../controllers/amiibo_controller.dart';

class DetailScreen extends StatelessWidget {
  final AmiiboModel amiibo;

  const DetailScreen({super.key, required this.amiibo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Amiibo Details"),
        actions: [
          Consumer<AmiiboController>(
            builder: (context, controller, child) {
              final isFav = controller.isFavorite(amiibo.tail);

              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  if (isFav) {
                    controller.removeFavorite(amiibo.tail);
                  } else {
                    controller.addFavorite(amiibo);
                  }
                },
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  amiibo.image,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              amiibo.name,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            infoItem("Amiibo Series", amiibo.amiiboSeries),
            infoItem("Character", amiibo.character),
            infoItem("Game Series", amiibo.gameSeries),
            infoItem("Type", amiibo.type),
            infoItem("Head", amiibo.head),
            infoItem("Tail", amiibo.tail),

            const SizedBox(height: 20),
            const Text(
              "Release Dates",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            infoItem("Australia", amiibo.release.au ?? "-"),
            infoItem("Europe", amiibo.release.eu ?? "-"),
            infoItem("Japan", amiibo.release.jp ?? "-"),
            infoItem("North America", amiibo.release.na ?? "-"),
          ],
        ),
      ),
    );
  }

  Widget infoItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
