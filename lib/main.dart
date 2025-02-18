import 'package:flutter/material.dart';  // Mengimpor pustaka Flutter untuk membangun UI
import 'package:supabase_flutter/supabase_flutter.dart';  // Mengimpor Supabase untuk koneksi backend


void main() async { // Pastikan Flutter terinisialisasi

 
  await Supabase.initialize(
    url: 'https://sguoserskuucjpsecxhb.supabase.co',  
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZjemx2b2Rla29wY2ZocG1wY3NhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk1Mzg2MTcsImV4cCI6MjA1NTExNDYxN30.vCCT3vw504nWHllGkvNYKTIWrnOTFOKRTWnomd50M1U',  // Kunci akses Supabase
  );

  // Menjalankan aplikasi Flutter
  runApp(LoginApp());
}

// Kelas utama aplikasi login.
class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Menyembunyikan label "Debug" di pojok kanan atas
      home: LoginScreen(),  // Menetapkan halaman login sebagai halaman utama aplikasi
    );
  }
}

// Kelas halaman login
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();  // Membuat state untuk halaman login
}


class _LoginScreenState extends State<LoginScreen> {
  // Controller untuk menangani input email dan password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Variabel untuk menyimpan status visibilitas password
  bool _isPasswordVisible = false;

  // Fungsi untuk menangani login berdasarkan email dan password yang diinputkan
  void handleLogin(BuildContext context) {
    if (emailController.text == 'maslan' && passwordController.text == '123') {
      // Jika login sebagai admin, navigasi ke halaman AdminHomeScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminHomeScreen()),
      );
    } else if (emailController.text == 'petugas' &&
        passwordController.text == '123') {
      // Jika login sebagai petugas, navigasi ke halaman PetugasHomeScreen
      
    } else {
      // Jika login gagal, tampilkan pesan error menggunakan SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email atau password salah!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue[50], // Memberikan warna latar belakang halaman login
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0), // Memberikan padding agar tampilan lebih rapi
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menampilkan judul "Selamat Datang!"
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Selamat Datang!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // Menampilkan teks deskripsi
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Silakan login untuk melanjutkan',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Input field untuk email
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // Input field untuk password
                TextField(
                  controller: passwordController,
                  obscureText: !_isPasswordVisible, // Mengatur visibilitas password
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // Tombol untuk menampilkan atau menyembunyikan password
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Teks "Lupa Password?" dengan fungsi yang belum diimplementasikan
               Align(
  alignment: Alignment.centerRight,
  child: TextButton(
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) {
          TextEditingController emailController = TextEditingController();
          return AlertDialog(
            title: Text("Reset Password"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Masukkan email Anda untuk reset password."),
                SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup dialog
                },
                child: Text("Batal"),
              ),
              ElevatedButton(
                onPressed: () {
                  String email = emailController.text;
                  if (email.isNotEmpty) {
                    Navigator.pop(context); // Tutup dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Tautan reset dikirim ke $email")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Masukkan email terlebih dahulu")),
                    );
                  }
                },
                child: Text("Kirim"),
              ),
            ],
          );
        },
      );
    },
    child: Text(
      'Lupa Password?',
      style: TextStyle(
        color: Colors.blue,
      ),
    ),
  ),
),
SizedBox(height: 30),


                // Tombol Login
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => handleLogin(context), // Memanggil fungsi handleLogin saat tombol ditekan
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Warna tombol login
                      padding: EdgeInsets.symmetric(vertical: 15), // Menyesuaikan tinggi tombol
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Membuat sudut tombol melengkung
                      ),
                    ),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Teks "Belum punya akun?" dengan tombol navigasi ke halaman Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Belum punya akun?'),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        // Navigasi ke halaman RegisterScreen saat teks "Daftar" ditekan
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()),
                        );
                      },
                      child: Text(
                        'Daftar',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Halaman Admin


class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _selectedIndex = 0;
  String _searchQuery = '';

  final List<String> pageTitles = [
    'Produk',
    'Transaksi',
    'Pelanggan',
    'Stok Barang',
  ];

  final List<Widget> _pages = [
    DetailPenjualanPage(), // Halaman Detail Penjualan
    Center(child: Text('Transaksi')), // Halaman Transaksi
    Center(child: Text('Pelanggan')), // Halaman Pelanggan
    StockPage(), // Halaman Stok Barang
  ];

  List<Widget> getFilteredPages() {
    if (_searchQuery.isEmpty) {
      return _pages;
    }
    return _pages
        .where((page) =>
            pageTitles[_pages.indexOf(page)]
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _onAddButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddItemPage(onItemAdded: _onItemAdded)),
    );
  }

  void _onItemAdded(Map<String, dynamic> newItem) {
    setState(() {
      DetailPenjualanPage.addItem(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> filteredPages = getFilteredPages();

      return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      title: Text(
        "Beranda",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: SearchPageDelegate(pageTitles, _onItemTapped),
            );
          },
        ),
      ],
    ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'maslan@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Stok Barang'),
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Penjualan'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: filteredPages.isNotEmpty
          ? filteredPages[_selectedIndex]
          : Center(child: Text('Tidak ditemukan')),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddButtonPressed, // Tetap ada tombol tambah
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Produk',
            backgroundColor: Color(0xFF1B5E20),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Transaksi',
            backgroundColor: Color(0xFF1B5E20),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Pelanggan',
            backgroundColor: Color(0xFF1B5E20),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'Stok Barang',
          ),
        ],
      ),
    );
  }
}

class SearchPageDelegate extends SearchDelegate<String> {
  final List<String> items;
  final Function(int) onItemSelected;

  SearchPageDelegate(this.items, this.onItemSelected);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = items
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            int selectedIndex = items.indexOf(results[index]);
            onItemSelected(selectedIndex);
            close(context, results[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = items
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}


// Halaman Detail Produk
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

class _DetailPenjualanPageState extends State<DetailPenjualanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

// Halaman untuk menambah barang
class AddItemPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onItemAdded; // Callback untuk menambahkan barang

  AddItemPage({required this.onItemAdded});

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _addItem() {
    final String name = _nameController.text;
    final int quantity = int.tryParse(_quantityController.text) ?? 0;
    final int price = int.tryParse(_priceController.text) ?? 0;

    if (name.isNotEmpty && quantity > 0 && price > 0) {
      final Map<String, dynamic> newItem = {
        'name': name,
        'quantity': quantity,
        'price': price,
      };

      widget.onItemAdded(newItem); // Tambahkan barang ke daftar
      Navigator.pop(context); // Kembali setelah barang ditambahkan
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
        title: Text('Tambah Barang Produk'),
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
              onPressed: _addItem,
              child: Text('Tambah Barang'),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}


// Halaman untuk menambah barang ke stok
class AddStockPage extends StatefulWidget {
  @override
  _AddStockPageState createState() => _AddStockPageState();
}

class _AddStockPageState extends State<AddStockPage> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productQuantityController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();

  void _addStockItem() {
    final String name = _productNameController.text;
    final String quantity = _productQuantityController.text;
    final String price = _productPriceController.text;

    if (name.isEmpty || quantity.isEmpty || price.isEmpty) {
      // Show a Snackbar if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mohon lengkapi semua data!')),
      );
    } else {
      // Add the item to the stock
      // You can store this in a list or a database, for now, we'll use a simple list
      print('Added Stock: $name, Quantity: $quantity, Price: $price');
      
      // Pop the screen to go back
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Barang'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(labelText: 'Nama Barang'),
            ),
            TextField(
              controller: _productQuantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Jumlah Barang'),
            ),
            TextField(
              controller: _productPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Harga Barang'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addStockItem,
              child: Text('Tambah Barang'),
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



// Halaman untuk Stok Barang
class StockPage extends StatefulWidget {
  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  // Controller untuk input nama barang
  final TextEditingController _productNameController = TextEditingController();
  // Controller untuk input jumlah barang
  final TextEditingController _productQuantityController = TextEditingController();
  // Controller untuk input harga barang
  final TextEditingController _productPriceController = TextEditingController();

  // List untuk menyimpan stok barang
  List<Map<String, dynamic>> _stockItems = [];

  // Fungsi untuk menambahkan barang ke stok
  void _addStockItem() {
    setState(() {
      _stockItems.add({
        'name': _productNameController.text, // Nama barang
        'quantity': _productQuantityController.text, // Jumlah barang
        'price': _productPriceController.text, // Harga barang
      });
    });

    // Mengosongkan input setelah barang ditambahkan
    _productNameController.clear();
    _productQuantityController.clear();
    _productPriceController.clear();

    // Menampilkan notifikasi konfirmasi
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Barang berhasil ditambahkan'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Memberikan jarak padding di sekitar halaman
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Input untuk Nama Barang
          TextField(
            controller: _productNameController,
            decoration: InputDecoration(
              labelText: 'Nama Barang',
            ),
          ),
          // Input untuk Jumlah Barang (menggunakan keyboard angka)
          TextField(
            controller: _productQuantityController,
            keyboardType: TextInputType.number, // Fixed: Menggunakan keyboard angka
            decoration: InputDecoration(
              labelText: 'Jumlah Barang',
            ),
          ),
          // Input untuk Harga Barang (menggunakan keyboard angka)
          TextField(
            controller: _productPriceController,
            keyboardType: TextInputType.number, // Fixed: Menggunakan keyboard angka
            decoration: InputDecoration(
              labelText: 'Harga Barang',
            ),
          ),
          SizedBox(height: 20),
          // Tombol untuk menambahkan barang ke stok
          ElevatedButton(
            onPressed: _addStockItem,
            child: Text('Tambah Barang'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Fixed: Properti untuk warna tombol
            ),
          ),
          SizedBox(height: 20),
          // Judul daftar stok barang
          Text(
            'Stok Barang:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // Daftar stok barang yang ditampilkan dalam ListView
          Expanded(
            child: ListView.builder(
              itemCount: _stockItems.length, // Jumlah barang dalam stok
              itemBuilder: (context, index) {
                final item = _stockItems[index]; // Mengambil data barang berdasarkan indeks
                return ListTile(
                  title: Text(item['name']), // Nama barang
                  subtitle: Text('Jumlah: ${item['quantity']} | Harga: ${item['price']}'), // Informasi stok
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Halaman Petugas


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tambah Button Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tambah Button Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // Aksi yang dilakukan saat tombol ditekan
              print('Tombol Tambah ditekan!');
            },
            child: Text('Tambah'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Warna latar belakang tombol
              foregroundColor: Colors.white, // Warna teks
            ),
          ),
        ),
      ),
    );
  }
}

// Halaman Register
class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrasi'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Buat Akun Baru',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    } else if (!RegExp(
                            r'^[^@]+@[^@]+\.[^@]+') // Validasi format email
                        .hasMatch(value)) {
                      return 'Format email tidak valid';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    } else if (value.length < 6) {
                      return 'Password minimal 6 karakter';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Konfirmasi Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value != passwordController.text) {
                      return 'Konfirmasi password tidak cocok';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Registrasi berhasil!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'DAFTAR',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


