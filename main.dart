import 'dart:io';
import 'data/produk.dart';
import 'data/keranjang.dart';
import 'data/transaksi.dart';
import 'data/kasir.dart';

void main() {
  // Data awal
  List<Produk> daftarProduk = [
    Produk('Mie instant', 3000, 10),
    Produk('bronie', 5000, 20),
    Produk('telur', 3000, 15),
  ];
  List<Transaksi> daftarTransaksi = [];
  var kasir = Kasir('Wasis', daftarTransaksi);

  // Keranjang belanja
  var keranjang = Keranjang();

  while (true) {
    print('\n======= Sistem POS Toko =======');
    print('1. Tambah Produk ke Keranjang');
    print('2. Hapus Produk dari Keranjang');
    print('3. Hitung Total Belanja');
    print('4. Cetak Struk');
    print('5. Laporan Penjualan');
    print('6. Keluar');
    print('+++++++++++++++++++++++++++++++');
    stdout.write('Pilih menu: ');
    var pilihan = stdin.readLineSync();

    switch (pilihan) {
      case '1': // Tambah Produk ke Keranjang
        print('\nDaftar Produk:');
        for (var i = 0; i < daftarProduk.length; i++) {
          print(
              '${i + 1}. ${daftarProduk[i].nama} - Rp${daftarProduk[i].harga} (Stok: ${daftarProduk[i].stok})');
        }
        stdout.write('Pilih produk (nomor): ');
        int index = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
        if (index < 1 || index > daftarProduk.length) {
          print('Pilihan tidak valid.');
          break;
        }
        var produk = daftarProduk[index - 1];
        stdout.write('Jumlah yang ingin ditambahkan: ');
        int jumlah = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
        if (jumlah <= 0 || jumlah > produk.stok) {
          print('Jumlah tidak valid atau stok tidak mencukupi.');
          break;
        }
        keranjang.tambahProduk(produk, jumlah);
        produk.kurangiStok(jumlah);
        print('Produk berhasil ditambahkan ke keranjang.');
        break;

      case '2': // Hapus Produk dari Keranjang
        if (keranjang.daftarProduk.isEmpty) {
          print('Keranjang kosong.');
          break;
        }
        print('\nKeranjang Belanja:');
        keranjang.tampilkanKeranjang();
        stdout.write('Pilih produk untuk dihapus (nomor): ');
        int index = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
        if (index < 1 || index > keranjang.daftarProduk.length) {
          print('Pilihan tidak valid.');
          break;
        }
        var produkDihapus = keranjang.daftarProduk.keys.toList()[index - 1];
        int jumlahDihapus = keranjang.daftarProduk[produkDihapus] ?? 0;
        keranjang.hapusProduk(produkDihapus);
        produkDihapus.tambahStok(jumlahDihapus);
        print('Produk berhasil dihapus dari keranjang.');
        break;

      case '3': // Hitung Total Belanja
        print('\nTotal Belanja: Rp${keranjang.hitungTotal()}');
        break;

      case '4': // Cetak Struk
        if (keranjang.daftarProduk.isEmpty) {
          print('Keranjang kosong. Tidak ada struk yang dicetak.');
          break;
        }
        var transaksi = kasir.cetakStruk(keranjang);
        print('\n=== Struk Belanja ===');
        print('Tanggal: ${transaksi.tanggal}');
        for (var entry in transaksi.items.entries) {
          var produk = entry.key;
          var jumlah = entry.value;
          print('${produk.nama} x $jumlah = Rp${produk.harga * jumlah}');
        }

        print('Total: Rp${transaksi.total}');
        keranjang.kosongkanKeranjang();
        break;

      case '5': // Laporan Penjualan
        if (kasir.daftarTransaksi.isEmpty) {
          print('Belum ada transaksi.');
          break;
        }
        print('\n=== Laporan Penjualan ===');
        for (var transaksi in kasir.daftarTransaksi) {
          print('Tanggal: ${transaksi.tanggal}, Total: Rp${transaksi.total}');
        }
        break;

      case '6': // Keluar
        print('Keluar dari program...');
        return;

      default:
        print('Pilihan tidak valid.');
    }
  }
}
