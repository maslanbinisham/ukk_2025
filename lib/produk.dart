import 'package:flutter/material.dart';


// Halaman untuk mengelola Produk
class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // List untuk menyimpan data produk (nama dan stok)
  final List<Map<String, dynamic>> _products = [];
  
  // Controller untuk input nama produk
  final TextEditingController _nameController = TextEditingController();
  
  // Controller untuk input jumlah stok
  final TextEditingController _stockController = TextEditingController();

  // Fungsi untuk menambahkan produk ke daftar
  void _addProduct() {
    // Validasi: pastikan input tidak kosong
    if (_nameController.text.isNotEmpty && _stockController.text.isNotEmpty) {
      setState(() {
        _products.add({
          'name': _nameController.text, // Nama produk
          'stock': int.parse(_stockController.text), // Stok produk (diubah ke integer)
        });
      });

      // Bersihkan input setelah ditambahkan
      _nameController.clear();
      _stockController.clear();
    }
  }

  // Fungsi untuk memperbarui stok produk berdasarkan indeks
  void _updateStock(int index, int newStock) {
    setState(() {
      _products[index]['stock'] = newStock;
    });
  }

  // Fungsi untuk menampilkan dialog update stok
  void _showUpdateStockDialog(int index) {
    // Controller untuk input stok baru (mengambil nilai stok saat ini)
    final TextEditingController _updateStockController =
        TextEditingController(text: _products[index]['stock'].toString());

    // Menampilkan dialog input stok baru
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Perbarui Stok'),
          content: TextField(
            controller: _updateStockController,
            keyboardType: TextInputType.number, // Hanya menerima angka
            decoration: InputDecoration(
              labelText: 'Stok Baru',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            // Tombol untuk membatalkan perubahan
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            // Tombol untuk menyimpan perubahan stok
            ElevatedButton(
              onPressed: () {
                final newStock = int.tryParse(_updateStockController.text);
                if (newStock != null) {
                  _updateStock(index, newStock); // Memperbarui stok jika input valid
                }
                Navigator.pop(context);
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produk'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Input untuk menambahkan produk baru
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Input nama produk
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nama Produk',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                // Input stok produk
                Expanded(
                  child: TextField(
                    controller: _stockController,
                    decoration: InputDecoration(
                      labelText: 'Stok',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number, // Hanya menerima angka
                  ),
                ),
                SizedBox(width: 8),
                // Tombol untuk menambahkan produk
                ElevatedButton(
                  onPressed: _addProduct,
                  child: Text('Tambah'),
                ),
              ],
            ),
          ),
          // Daftar produk yang telah ditambahkan
          Expanded(
            child: _products.isEmpty
                ? Center(
                    child: Text('Belum ada produk yang ditambahkan'), // Menampilkan teks jika tidak ada produk
                  )
                : ListView.builder(
                    itemCount: _products.length, // Jumlah produk dalam daftar
                    itemBuilder: (context, index) {
                      final product = _products[index]; // Mengambil produk berdasarkan indeks
                      return ListTile(
                        title: Text(product['name']), // Menampilkan nama produk
                        subtitle: Text('Stok: ${product['stock']}'), // Menampilkan jumlah stok
                        trailing: IconButton(
                          icon: Icon(Icons.edit), // Ikon edit stok
                          onPressed: () {
                            _showUpdateStockDialog(index); // Memanggil dialog untuk edit stok
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}


// Halaman Detail Penjualan
class DetailPenjualanPage extends StatefulWidget {
  // Daftar item yang telah terjual (bersifat static agar bisa diakses dari luar kelas)
  static List<Map<String, dynamic>> soldItems = []; 

  @override
  _DetailPenjualanPageState createState() => _DetailPenjualanPageState();

  // Fungsi untuk menambahkan item ke daftar penjualan
  static void addItem(Map<String, dynamic> newItem) {
    soldItems.add(newItem);
  }

  // Fungsi untuk memperbarui item dalam daftar penjualan berdasarkan indeks
  static void updateItem(int index, Map<String, dynamic> updatedItem) {
    soldItems[index] = updatedItem;
  }

  // Fungsi untuk menghapus item dari daftar penjualan berdasarkan indeks
  static void removeItem(int index) {
    soldItems.removeAt(index);
  }
}
// Halaman untuk mengedit barang
class EditItemPage extends StatefulWidget {
  final Map<String, dynamic> item; // Data barang yang akan diedit
  final int index; // Indeks barang dalam daftar
  final Function(Map<String, dynamic>) onItemUpdated; // Callback setelah barang diperbarui

  EditItemPage({required this.item, required this.index, required this.onItemUpdated});

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    // Mengisi controller dengan data barang yang akan diedit
    _nameController = TextEditingController(text: widget.item['name']);
    _quantityController = TextEditingController(text: widget.item['quantity'].toString());
    _priceController = TextEditingController(text: widget.item['price'].toString());
  }

  void _updateItem() {
    final String name = _nameController.text;
    final int quantity = int.tryParse(_quantityController.text) ?? 0;
    final int price = int.tryParse(_priceController.text) ?? 0;

    if (name.isNotEmpty && quantity > 0 && price > 0) {
      final updatedItem = {
        'name': name,
        'quantity': quantity,
        'price': price,
      };

      widget.onItemUpdated(updatedItem); // Memperbarui item di daftar penjualan
      Navigator.pop(context); // Kembali ke halaman sebelumnya setelah diperbarui
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap isi semua kolom dengan benar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Barang'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama Barang'),
            ),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Jumlah'),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Harga'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateItem,
              child: Text('Perbarui Barang'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailPenjualanPageState extends State<DetailPenjualanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Penjualan'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: DetailPenjualanPage.soldItems.length, // Jumlah item dalam daftar penjualan
        itemBuilder: (context, index) {
          final item = DetailPenjualanPage.soldItems[index]; // Mengambil item berdasarkan indeks
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              title: Text(item['name']),
              subtitle: Text('Jumlah: ${item['quantity']} - Harga: Rp ${item['price']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tombol Edit
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Navigasi ke halaman edit barang
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditItemPage(
                            item: item,
                            index: index,
                            onItemUpdated: (updatedItem) {
                              DetailPenjualanPage.updateItem(index, updatedItem);
                              setState(() {}); // Update tampilan setelah item diperbarui
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  // Tombol Hapus
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Dialog konfirmasi sebelum menghapus item
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Hapus Barang'),
                            content: Text('Apakah Anda yakin ingin menghapus barang ini?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Tutup dialog
                                },
                                child: Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    DetailPenjualanPage.removeItem(index); // Hapus item
                                  });
                                  Navigator.pop(context); // Tutup dialog
                                },
                                child: Text('Hapus'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}