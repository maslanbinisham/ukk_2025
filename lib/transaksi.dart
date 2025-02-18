import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';  // Mengimpor Firestore
import 'package:firebase_core/firebase_core.dart';
  // Mengimpor halaman untuk menambah transaksi

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Pastikan Firebase diinisialisasi terlebih dahulu
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Utama'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tombol untuk menambah pelanggan
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCustomerPage()),
                );
              },
              child: Text('Tambah Pelanggan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            // Tombol untuk menambah transaksi
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddTransactionPage()),
                );
              },
              child: Text('Tambah Transaksi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class AddCustomerPage extends StatefulWidget {
  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerPhoneController = TextEditingController();

  // Fungsi untuk menambah pelanggan ke Firestore
  void _addCustomer() async {
    final String name = _customerNameController.text;
    final String phone = _customerPhoneController.text;

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mohon lengkapi semua data!')),
      );
      return;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nomor telepon harus angka')),
      );
      return;
    }

    try {
      // Menambahkan pelanggan ke Firestore
      await FirebaseFirestore.instance.collection('customers').add({
        'name': name,
        'phone': phone,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pelanggan berhasil ditambahkan')),
      );

      // Clear input fields
      _customerNameController.clear();
      _customerPhoneController.clear();

      // Kembali ke halaman sebelumnya setelah menambahkan pelanggan
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pelanggan'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _customerNameController,
              decoration: InputDecoration(labelText: 'Nama Pelanggan'),
            ),
            TextField(
              controller: _customerPhoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Nomor Telepon'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addCustomer,
              child: Text('Tambah Pelanggan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class AddTransactionPage extends StatefulWidget {
  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final TextEditingController _customerIdController = TextEditingController();
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // Fungsi untuk menambah transaksi ke Firestore
  void _addTransaction() async {
    final String customerId = _customerIdController.text;
    final String product = _productController.text;
    final String quantity = _quantityController.text;
    final String price = _priceController.text;

    if (customerId.isEmpty || product.isEmpty || quantity.isEmpty || price.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mohon lengkapi semua data!')),
      );
      return;
    }

    try {
      // Validasi apakah customerId ada dalam Firestore
      final customerDoc = await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .get();

      if (!customerDoc.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pelanggan tidak ditemukan')),
        );
        return;
      }

      // Menambahkan transaksi ke Firestore
      await FirebaseFirestore.instance.collection('transactions').add({
        'customerId': customerId,
        'product': product,
        'quantity': quantity,
        'price': price,
        'total': int.parse(quantity) * int.parse(price), // Total transaksi
        'date': Timestamp.now(),  // Menyimpan waktu transaksi
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Transaksi berhasil ditambahkan')),
      );

      // Clear input fields
      _customerIdController.clear();
      _productController.clear();
      _quantityController.clear();
      _priceController.clear();

      // Kembali ke halaman sebelumnya setelah menambahkan transaksi
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Transaksi'),
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
              decoration: InputDecoration(labelText: 'Nama Barang'),
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
              onPressed: _addTransaction,
              child: Text('Tambah Transaksi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}