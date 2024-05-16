import 'package:bloc/bloc.dart';

import '../koneksi.dart';

//class cubit list kata
// Enum untuk mendefinisikan state aplikasi
enum KamusState { loading, loaded, error }

class KamusCubit extends Cubit<KamusState> {
  KamusCubit() : super(KamusState.loading);

  // Buat properti untuk menyimpan data
  List<ListKata> _data = [];

  // Metode untuk memuat data dan mengubah state
  Future<void> fetchData() async {
    try {
      emit(KamusState.loading);

      // Simpan hasil sorting ke dalam properti _data
      _data = await ListKata.getListKataSorted();

      emit(KamusState.loaded);
    } catch (e) {
      emit(KamusState.error);
    }
  }

  // Getter untuk mendapatkan data yang sudah diurutkan
  List<ListKata> get sortedData => _data;
}
