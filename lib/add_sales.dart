import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddSalesPage extends StatefulWidget {
  @override
  _AddSalesPageState createState() => _AddSalesPageState();
}

class _AddSalesPageState extends State<AddSalesPage> {
  final TextEditingController _customerIdController = TextEditingController();
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // Fungsi untuk menambah transaksi penjualan ke Firestore
  void _addSale() {
    final String customerId = _customerIdController.text;
    final String product = _productController.text;
    final String quantity = _quantityController.text;
    final String price = _priceController.text;

    if (customerId.isEmpty || product.isEmpty || quantity.isEmpty || price.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mohon lengkapi semua data!')),
      );
    } else {
      // Hitung total harga
      int total = int.parse(quantity) * int.parse(price);

      // Menambahkan penjualan ke Firestore
      FirebaseFirestore.instance.collection('sales').add({
        'customerId': customerId,
        'product': product,
        'quantity': quantity,
        'price': price,
        'total': total,
        'date': Timestamp.now(),
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Penjualan berhasil ditambahkan')),
        );
        _customerIdController.clear();
        _productController.clear();
        _quantityController.clear();
        _priceController.clear();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: $error')),
        );
      });

      // Kembali ke halaman sebelumnya setelah menambahkan penjualan
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Penjualan'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _customerIdController,
              decoration: InputDecoration(labelText: 'ID Pelanggan'),
            ),
            TextField(
              controller: _productController,
              decoration: InputDecoration(labelText: 'Nama Produk'),
            ),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Jumlah Barang'),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Harga Barang'),
            ),
           SizedBox(height: 20),
ElevatedButton(
  onPressed: _addSale,
  child: Text('Tambah Penjualan'),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green, // Ganti primary dengan backgroundColor
  ),
),

          ],
        ),
      ),
    );
  }
}
