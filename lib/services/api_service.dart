import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latihan_responsi_124230041/models/amiibo_model.dart';

class AmiiboService {
  static final String baseUrl = "https://www.amiiboapi.com/api/amiibo";

  static Future<List<AmiiboModel>> fetchAmiiboData() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List amiibos = data['amiibo'];

      return amiibos.map((item) => AmiiboModel.fromJson(item)).toList();
    } else {
      throw Exception("Gagal Fetch API Amiibo");
    }
  }
}
