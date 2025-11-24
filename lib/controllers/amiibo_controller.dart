import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:latihan_responsi_124230041/models/amiibo_model.dart';
import 'package:latihan_responsi_124230041/services/api_service.dart';

class AmiiboController with ChangeNotifier {
  List<AmiiboModel> amiiboList = [];
  bool isLoading = false;

  late Box<AmiiboModel> favoriteBox;
  bool _isHiveReady = false; // flag untuk memastikan Hive sudah siap

  AmiiboController() {
    initHive(); // panggil initHive di constructor
  }

  // Inisialisasi Hive untuk favorit
  Future<void> initHive() async {
    favoriteBox = await Hive.openBox<AmiiboModel>('favorite_box');
    _isHiveReady = true; // sudah siap
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

  // Cek item favorit, pastikan Hive sudah siap
  bool isFavorite(String id) {
    if (!_isHiveReady) return false;
    return favoriteBox.containsKey(id);
  }

  // Tambah favorit
  void addFavorite(AmiiboModel item) {
    if (!_isHiveReady) return;
    favoriteBox.put(item.tail, item);
    notifyListeners();
  }

  // Hapus favorit
  void removeFavorite(String id) {
    if (!_isHiveReady) return;
    favoriteBox.delete(id);
    notifyListeners();
  }

  // Ambil semua favorit
  List<AmiiboModel> getFavorites() {
    if (!_isHiveReady) return [];
    return favoriteBox.values.toList();
  }
}
