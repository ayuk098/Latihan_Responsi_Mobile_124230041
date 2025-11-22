import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/amiibo_controller.dart';
import '../models/amiibo_model.dart';
import 'detail_screen.dart';
import 'favorite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<AmiiboController>(context, listen: false).fetchAmiibos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AmiiboController>(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() => selectedIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
        ],
      ),

      body: IndexedStack(
        index: selectedIndex,
        children: [
          _buildHomePage(controller), 
          const FavoriteScreen(), 
        ],
      ),
    );
  }

  Widget _buildHomePage(AmiiboController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nintendo Amiibo List"),
        centerTitle: true,
      ),
      body: _buildHomeBody(controller),
    );
  }

  Widget _buildHomeBody(AmiiboController controller) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.amiiboList.isEmpty) {
      return const Center(child: Text("Tidak ada data"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: controller.amiiboList.length,
      itemBuilder: (context, index) {
        final amiibo = controller.amiiboList[index];
        return _buildAmiiboItem(context, amiibo, controller);
      },
    );
  }

  Widget _buildAmiiboItem(
    BuildContext context,
    AmiiboModel amiibo,
    AmiiboController controller,
  ) {
    final isFav = controller.isFavorite(amiibo.tail);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            amiibo.image,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(amiibo.name),
        subtitle: Text(amiibo.gameSeries),
        trailing: IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            if (isFav) {
              controller.removeFavorite(amiibo.tail);
            } else {
              controller.addFavorite(amiibo);
            }
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DetailScreen(amiibo: amiibo)),
          );
        },
      ),
    );
  }
}
