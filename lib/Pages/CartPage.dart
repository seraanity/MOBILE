import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:njajanz/Widgets/AppBarWidget.dart';
import 'package:njajanz/Widgets/CartBottomNavBar.dart';
import 'package:njajanz/Widgets/DrawerWidget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];
  double totalHarga = 0;
  double biayaAntar = 10000; // Biaya antar tetap untuk contoh
  int totalPesanan = 0;

  @override
  void initState() {
    super.initState();
    _fetchCartData(); // Ambil data cart saat halaman dibuka
  }

  Future<void> _fetchCartData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://www.foodbooking.com/ordering/restaurant/menu/checkout?company_uid=eab6a4ee-e97e-48ba-8ce6-d5ffad4cf181&restaurant_uid=1f12c670-a7b9-4a8e-993d-99cc54981ca5&facebook=true'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data); // Periksa data yang diterima di console

        // Ambil data cart dari response
        setState(() {
          cartItems = List<Map<String, dynamic>>.from(data['cart_items']);
          totalHarga = data['total_price'].toDouble();
          totalPesanan = cartItems.length;
        });
      } else {
        // Jika request gagal, tampilkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat data keranjang')),
        );
      }
    } catch (e) {
      // Jika ada kesalahan saat melakukan request, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarWidget(),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 10, bottom: 10),
                    child: Text(
                      "List Pesanan",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Item Cart
                  if (cartItems.isNotEmpty)
                    ...cartItems.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        child: Container(
                          width: 380,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Image.network(
                                  item['image_url'], // Gambar dari API
                                  height: 80,
                                  width: 140,
                                ),
                              ),
                              SizedBox(
                                width: 190,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'], // Nama item dari API
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      item[
                                          'description'], // Deskripsi item dari API
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "Rp ${item['price']}", // Harga dari API
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        CupertinoIcons.minus,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        item['quantity']
                                            .toString(), // Jumlah item
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Icon(
                                        CupertinoIcons.plus,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),

                  // Jika tidak ada item dalam cart
                  if (cartItems.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Keranjang Anda kosong.",
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ),

                  // Summary Pesanan
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total Pesanan: ",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "$totalPesanan",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          const Divider(color: Colors.black),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Sub Total: ",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "Rp $totalHarga",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Biaya Antar: ",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "Rp $biayaAntar",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total Harga: ",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "Rp ${totalHarga + biayaAntar}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      bottomNavigationBar: CartBottomNavBar(),
    );
  }
}
