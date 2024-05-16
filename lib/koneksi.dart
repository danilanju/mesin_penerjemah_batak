import 'dart:convert';
import 'package:http/http.dart' as http;

class PostKata {
  late String arti;

  PostKata({required this.arti});

  factory PostKata.createTransResult(List<dynamic> list) {
    return PostKata(
      arti: list[0]['kata'],
    );
  }

  static Future<PostKata> connectKeAPI(String kunci) async {
    String apiURL = "http://technologysupport.id/api/get_kamus";
    try {
      var apiResult = await http.post(Uri.parse(apiURL), body: {
        "kunci": kunci,
      });

      if (apiResult.statusCode == 200) {
        var jsonObject = json.decode(apiResult.body);
        return PostKata.createTransResult(jsonObject);
      } else {
        // Handle kesalahan status code jika diperlukan
        throw Exception(
            'Failed to connect to API. Status code: ${apiResult.statusCode}');
      }
    } catch (e) {
      // Handle kesalahan koneksi atau dekode JSON
      print("Error connecting to API: $e");
      rethrow; // Re-throw agar error dapat ditangkap di lapisan yang lebih tinggi jika perlu
    }
  }
}

//get list
class ListKata {
  late String kata;
  late String arti;

  ListKata({required this.kata, required this.arti});

// Konstruktor untuk membuat objek ListKata dari JSON
  factory ListKata.createListKata(Map<String, dynamic> json) {
    return ListKata(
      kata: json['translate'] ?? '',
      arti: json['kata'] ?? '',
    );
  }

  // Metode untuk mengambil data dari URL dan mengurutkannya berdasarkan kata
  static Future<List<ListKata>> getListKataSorted() async {
    String apiURL = "http://technologysupport.id/api/get_kamus_all";

    var apiResult = await http.get(Uri.parse(apiURL));

    if (apiResult.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(apiResult.body);

      // Membuat objek ListKata dari JSON
      List<ListKata> listKata = jsonList
          .map((jsonItem) => ListKata.createListKata(jsonItem))
          .toList();

      // Sorting data berdasarkan kata (dari A ke Z)
      listKata.sort((a, b) => a.kata.compareTo(b.kata));

      return listKata;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
