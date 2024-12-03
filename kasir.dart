import 'keranjang.dart';
import 'transaksi.dart';

class Kasir {
  String nama;
  List<Transaksi> daftarTransaksi;

  Kasir(this.nama, this.daftarTransaksi);

  Transaksi cetakStruk(Keranjang keranjang) {
    var transaksi = Transaksi(DateTime.now(), Map.from(keranjang.daftarProduk),
        keranjang.hitungTotal());
    daftarTransaksi.add(transaksi);
    return transaksi;
  }
}
