import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Pelanggan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomerPage(),
    );
  }
}

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  Future<bool> _isDuplicate(String name) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('customers')
        .where('name', isEqualTo: name)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  void _addCustomer() async {
    final String name = _nameController.text.trim();
    final String phone = _phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nama dan Nomor Telepon tidak boleh kosong')),
      );
    } else if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nomor Telepon harus menggunakan angka')),
      );
    } else {
      bool isDuplicate = await _isDuplicate(name);
      if (isDuplicate) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pelanggan dengan nama ini sudah ada')),
        );
      } else {
        FirebaseFirestore.instance.collection('customers').add({
          'name': name,
          'phone': phone,
        });
        _nameController.clear();
        _phoneController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Pelanggan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama Pelanggan'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Nomor Telepon'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _addCustomer,
              child: Text('Tambah Pelanggan'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _searchController,
              onChanged: (query) {
                setState(() {
                  _searchQuery = query.toLowerCase();
                });
              },
              decoration: InputDecoration(
                labelText: 'Cari Pelanggan',
                border: OutlineInputBorder(),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('customers').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();

                  var filteredDocs = snapshot.data!.docs.where((doc) =>
                      doc['name'].toString().toLowerCase().contains(_searchQuery)).toList();

                  return ListView.builder(
                    itemCount: filteredDocs.length,
                    itemBuilder: (context, index) {
                      var doc = filteredDocs[index];
                      return ListTile(
                        title: Text(doc['name']),
                        subtitle: Text(doc['phone']),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('customers')
                                .doc(doc.id)
                                .delete();
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
