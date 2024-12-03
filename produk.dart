class Produk {
  String nama;
  int harga;
  int stok;

  Produk(this.nama, this.harga, this.stok);

  void kurangiStok(int jumlah) {
    stok -= jumlah;
  }

  void tambahStok(int jumlah) {
    stok += jumlah;
  }
}
