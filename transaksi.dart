import 'produk.dart';
import 'dart:core';

class Transaksi {
  DateTime tanggal;
  Map<Produk, int> items;
  int total;

  Transaksi(this.tanggal, this.items, this.total);
}
