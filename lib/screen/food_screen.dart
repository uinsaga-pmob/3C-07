import 'package:flutter/material.dart';
import 'dart:convert';
import '../database/database_helper.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  int _selectedCategory = 0;
  
  final List<String> categories = ['Popcorn', 'Fritters', 'Drink'];
  
  // Data untuk setiap kategori
  final Map<String, List<Map<String, dynamic>>> foodItems = {
    'Popcorn': [
      {
        'name': 'Popcorn Salty (S)',
        'price': 'Rp.12.000',
        'image': 'assets/food/popcorn.jpg',
        'description': 'Popcorn asin ukuran kecil',
      },
      {
        'name': 'Popcorn Salty (M)',
        'price': 'Rp.20.000',
        'image': 'assets/food/popcorn.jpg',
        'description': 'Popcorn asin ukuran sedang',
      },
      {
        'name': 'Popcorn Salty (L)',
        'price': 'Rp.26.000',
        'image': 'assets/food/popcorn.jpg',
        'description': 'Popcorn asin ukuran besar',
      },
      {
        'name': 'Popcorn Caramel (M)',
        'price': 'Rp.25.000',
        'image': 'assets/food/popcorn.jpg',
        'description': 'Popcorn karamel ukuran sedang',
      },
      {
        'name': 'Popcorn Cheese (M)',
        'price': 'Rp.24.000',
        'image': 'assets/food/popcorn.jpg',
        'description': 'Popcorn keju ukuran sedang',
      },
    ],
    'Fritters': [
      {
        'name': 'French Fries',
        'price': 'Rp.23.000',
        'image': 'assets/food/french.jpg',
        'description': 'Kentang goreng renyah',
      },
      {
        'name': 'Cireng',
        'price': 'Rp.20.000',
        'image': 'assets/food/cireng.jpg',
        'description': 'Aci goreng khas Bandung',
      },
      {
        'name': 'Mix Platter',
        'price': 'Rp.32.000',
        'image': 'assets/food/mix plater.jpg',
        'description': 'Campuran berbagai gorengan',
      },
      {
        'name': 'Tahu Crispy',
        'price': 'Rp.18.000',
        'image': 'assets/food/tahu.jpg',
        'description': 'Tahu goreng crispy',
      },
      {
        'name': 'Tempe Mendoan',
        'price': 'Rp.15.000',
        'image': 'assets/food/tempe.jpg',
        'description': 'Tempe goreng mendoan',
      },
    ],
    'Drink': [
      {
        'name': 'Coca-Cola (M)',
        'price': 'Rp.18.000',
        'image': 'assets/food/coca.jpg',
        'description': 'Coca-Cola ukuran sedang',
      },
      {
        'name': 'Pepsi (M)',
        'price': 'Rp.17.000',
        'image': 'assets/food/pepsi.jpg',
        'description': 'Pepsi ukuran sedang',
      },
      {
        'name': 'Fanta (M)',
        'price': 'Rp.17.000',
        'image': 'assets/food/fanta.jpg',
        'description': 'Fanta ukuran sedang',
      },
      {
        'name': 'Air Mineral',
        'price': 'Rp.10.000',
        'image': 'assets/food/air.jpg',
        'description': 'Air mineral botol',
      },
      {
        'name': 'Ice Tea',
        'price': 'Rp.15.000',
        'image': 'assets/food/tea.jpg',
        'description': 'Es teh manis',
      },
    ],
  };

  // Cart state
  final Map<String, int> cart = {};

  @override
  Widget build(BuildContext context) {
    String selectedCategory = categories[_selectedCategory];
    List<Map<String, dynamic>> currentItems = foodItems[selectedCategory] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CINETIX',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/logo.png',
              height: 40,
              width: 40,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.movie,
                  color: Colors.white,
                  size: 30,
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Selection
          Container(
            height: 60,
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(categories.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: _selectedCategory == index
                          ? Colors.black
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: _selectedCategory == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          
          // Category Title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(
                  Icons.fastfood,
                  size: 24,
                  color: Colors.black,
                ),
                const SizedBox(width: 8),
                Text(
                  selectedCategory,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Food Items Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.6, // <--- DIUBAH DARI 0.75 BIAR KARTUNYA LEBIH MANJANG KE BAWAH
                ),
                itemCount: currentItems.length,
                itemBuilder: (context, index) {
                  final item = currentItems[index];
                  final String itemKey = '${selectedCategory}_${item['name']}';
                  final int quantity = cart[itemKey] ?? 0;
                  
                  return _buildFoodCard(
                    name: item['name'] as String,
                    price: item['price'] as String,
                    imagePath: item['image'] as String,
                    description: item['description'] as String,
                    quantity: quantity,
                    onAdd: () {
                      setState(() {
                        cart[itemKey] = (cart[itemKey] ?? 0) + 1;
                      });
                    },
                    onRemove: () {
                      setState(() {
                        if (cart[itemKey] != null && cart[itemKey]! > 0) {
                          cart[itemKey] = cart[itemKey]! - 1;
                          if (cart[itemKey] == 0) {
                            cart.remove(itemKey);
                          }
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ),
          
          // Cart Summary
          if (_calculateTotalItems() > 0)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_calculateTotalItems()} item',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _calculateTotalPrice(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _showOrderConfirmation(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Pesan Sekarang',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFoodCard({
    required String name,
    required String price,
    required String imagePath,
    required String description,
    required int quantity,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              imagePath,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 120,
                  color: Colors.grey[200],
                  child: const Icon(
                    Icons.fastfood,
                    size: 40,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          
          // Food Details - Ditambahin Expanded biar konten rapi ngisi sisa kartu
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // <--- BIAR TOMBOL KE-PUSH KE BAWAH
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  
                  // Quantity Control
                  quantity > 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: onRemove,
                              icon: const Icon(Icons.remove),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                padding: const EdgeInsets.all(4),
                              ),
                            ),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: onAdd,
                              icon: const Icon(Icons.add),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                padding: const EdgeInsets.all(4),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: onAdd,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            child: const Text('Tambah'),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _calculateTotalItems() {
    return cart.values.fold(0, (sum, quantity) => sum + quantity);
  }

  String _calculateTotalPrice() {
    double total = 0;
    
    for (var category in foodItems.keys) {
      for (var item in foodItems[category]!) {
        final String itemKey = '${category}_${item['name']}';
        if (cart.containsKey(itemKey)) {
          // Extract price from string like "Rp.12.000"
          String priceStr = item['price'] as String;
          priceStr = priceStr.replaceAll('Rp.', '').replaceAll('.', '').trim();
          final double price = double.tryParse(priceStr) ?? 0;
          total += price * cart[itemKey]!;
        }
      }
    }
    
    // Dibenarkan format totalnya biar sesuai pembacaan ribuan (biar gak ada koma nyasar)
    return 'Rp.${total.toStringAsFixed(0)}'; 
  }

  void _showOrderConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Pesanan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Apakah Anda yakin ingin memesan?'),
              const SizedBox(height: 16),
              Text('Total: ${_calculateTotalPrice()}'),
              Text('Jumlah item: ${_calculateTotalItems()}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                // Process order
                _processOrder(context);
              },
              child: const Text('Pesan'),
            ),
          ],
        );
      },
    );
  }

  void _processOrder(BuildContext context) async {
    // Build items list to store in JSON
    final List<Map<String, dynamic>> itemsList = [];
    for (var category in foodItems.keys) {
      for (var item in foodItems[category]!) {
        final String itemKey = '${category}_${item['name']}';
        if (cart.containsKey(itemKey)) {
          itemsList.add({
            'name': item['name'],
            'price': item['price'],
            'quantity': cart[itemKey],
            'category': category,
          });
        }
      }
    }

    final totalItems = _calculateTotalItems();
    final totalPriceStr = _calculateTotalPrice();

    final order = {
      'itemsJson': json.encode(itemsList),
      'totalItems': totalItems,
      'totalPrice': totalPriceStr,
    };

    // Save to Database
    await DatabaseHelper.instance.insertFoodOrder(order);

    // Clear cart
    cart.clear();
    
    // Show success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pesanan berhasil diproses!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Close dialog
      Navigator.pop(context);
      
      // Update UI
      setState(() {});
    }
  }
}