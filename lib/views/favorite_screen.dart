import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/amiibo_controller.dart';
import 'detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites"), centerTitle: true),

      body: Consumer<AmiiboController>(
        builder: (context, controller, child) {
          final favorites = controller.getFavorites();

          if (favorites.isEmpty) {
            return const Center(
              child: Text("Belum ada favorite", style: TextStyle(fontSize: 16)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final amiibo = favorites[index];

              return Dismissible(
                key: Key(amiibo.tail),
                direction: DismissDirection.horizontal,

                onDismissed: (_) {
                  controller.removeFavorite(amiibo.tail);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${amiibo.name} dihapus dari favorite"),
                    ),
                  );
                },

                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),

                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),

                child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        amiibo.image,
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(amiibo.name),
                    subtitle: Text("ID: ${amiibo.head}"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(amiibo: amiibo),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
