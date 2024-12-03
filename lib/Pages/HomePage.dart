import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:njajanz/Widgets/AppBarWidget.dart';
import 'package:njajanz/Widgets/CategoriesWidget.dart';
import 'package:njajanz/Widgets/DrawerWidget.dart';
import 'package:njajanz/Widgets/NewestItemsWidget.dart';
import 'package:njajanz/Widgets/PopulerItemsWidget.dart';

// Data dummy untuk item
List<Map<String, String>> items = [
  {"name": "Batagor", "image": "images/batagor.png"},
  {"name": "Siomay", "image": "images/siomay.png"},
  {"name": "Bakso", "image": "images/bakso.png"},
  {"name": "Martabak", "image": "images/marsin.png"},
  {"name": "Risol Mayo", "image": "images/risma.png"},
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController =
      TextEditingController(); // Controller untuk input search
  List<Map<String, String>> filteredItems =
      items; // Variabel untuk menyimpan hasil filter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Header
          Container(
            width: double.infinity,
            color: Colors.blueGrey[200],
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: const Text(
              "NJAJANZ",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          AppBarWidget(),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.search,
                      color: Colors.blue,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            filteredItems = items.where((item) {
                              return item["name"]!
                                  .toLowerCase()
                                  .contains(value.toLowerCase());
                            }).toList(); // Update hasil filter
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: "Jajan apa bro hari ini?",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Icon(Icons.filter_list),
                  ],
                ),
              ),
            ),
          ),

          // Menampilkan hasil pencarian dalam bentuk card
          if (searchController.text.isNotEmpty && filteredItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: filteredItems.map((item) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    elevation: 4,
                    child: ListTile(
                      leading: Image.asset(
                        item["image"]!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        item["name"]!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        // Tambahkan aksi ketika item diklik
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          if (searchController.text.isNotEmpty && filteredItems.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Tidak ada hasil ditemukan.",
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),

          // Bagian lainnya tetap sama
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Kategori",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          CategoriesWidget(),

          const Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Populer",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          PopulerItemsWidget(),

          const Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Terbaru",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          NewestItemsWidget(),
        ],
      ),
      drawer: DrawerWidget(),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "CartPage");
          },
          backgroundColor: Colors.white,
          child: Icon(
            CupertinoIcons.cart,
            size: 28,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
