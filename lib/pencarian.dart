import 'package:flutter/material.dart';

class BerandaPenjualan extends StatefulWidget {
  @override
  _BerandaPenjualanState createState() => _BerandaPenjualanState();
}

class _BerandaPenjualanState extends State<BerandaPenjualan> {
  int _selectedIndex = 0;
  TextEditingController _searchController = TextEditingController();
  List<String> _items = ['Produk A', 'Produk B', 'Produk C', 'Pelanggan X', 'Pelanggan Y'];
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(_items);
  }

  void _onSearchChanged() {
    setState(() {
      _filteredItems = _items
          .where((item) => item.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda Penjualan'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text('Admin', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text('maslan@gmail.com', style: TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
            ),
            ListTile(leading: Icon(Icons.home), title: Text('Beranda'), onTap: () => Navigator.pop(context)),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Stok Barang'),
              onTap: () {
                setState(() {
                  _selectedIndex = 4;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(leading: Icon(Icons.shopping_cart), title: Text('Penjualan'), onTap: () => Navigator.pop(context)),
            ListTile(leading: Icon(Icons.settings), title: Text('Pengaturan'), onTap: () => Navigator.pop(context)),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari produk atau pelanggan...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (value) => _onSearchChanged(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(_filteredItems[index]), onTap: () {});
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Produk', backgroundColor: Color(0xFF1B5E20)),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Transaksi', backgroundColor: Color(0xFF1B5E20)),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Pelanggan', backgroundColor: Color(0xFF1B5E20)),
          BottomNavigationBarItem(icon: Icon(Icons.storage), label: 'Stok Barang'),
        ],
      ),
    );
  }
}
