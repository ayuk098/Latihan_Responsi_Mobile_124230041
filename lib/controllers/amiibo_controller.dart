import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:latihan_responsi_124230041/models/amiibo_model.dart';
import 'package:latihan_responsi_124230041/services/api_service.dart';

class AmiiboController with ChangeNotifier {
  List<AmiiboModel> amiiboList = [];
  bool isLoading = false;

  late Box<AmiiboModel> favoriteBox;

  AmiiboController() {
    initHive();
  }

  // hive untuk favorit
  Future<void> initHive() async {
    favoriteBox = await Hive.openBox<AmiiboModel>('favorite_box');
    notifyListeners();
  }

  Future<void> fetchAmiibos() async {
    isLoading = true;
    notifyListeners();
    try {
      amiiboList = await AmiiboService.fetchAmiiboData();
    } catch (e) {
      print("Error fetch: $e");
    }
    isLoading = false;
    notifyListeners();
  }

  //cek item favorit
  bool isFavorite(String id) {
    return favoriteBox.containsKey(id);
  }

  //add
  void addFavorite(AmiiboModel item) {
    favoriteBox.put(item.tail, item);
    notifyListeners();
  }

  //remove
  void removeFavorite(String id) {
    favoriteBox.delete(id);
    notifyListeners();
  }

  //get all 
  List<AmiiboModel> getFavorites() {
    return favoriteBox.values.toList();
  }
}
