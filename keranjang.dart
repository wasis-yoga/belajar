import 'produk.dart';

class Keranjang {
  Map<Produk, int> daftarProduk = {};

  void tambahProduk(Produk produk, int jumlah) {
    if (daftarProduk.containsKey(produk)) {
      daftarProduk[produk] = daftarProduk[produk]! + jumlah;
    } else {
      daftarProduk[produk] = jumlah;
    }
  }

  void hapusProduk(Produk produk) {
    daftarProduk.remove(produk);
  }

  int hitungTotal() {
    int total = 0;
    daftarProduk.forEach((produk, jumlah) {
      total += produk.harga * jumlah;
    });
    return total;
  }

  void tampilkanKeranjang() {
    int index = 1;
    for (var entry in daftarProduk.entries) {
      var produk = entry.key;
      var jumlah = entry.value;
      print(
          '${index++}. ${produk.nama} x $jumlah = Rp${produk.harga * jumlah}');
    }
  }

  void kosongkanKeranjang() {
    daftarProduk.clear();
  }
}
