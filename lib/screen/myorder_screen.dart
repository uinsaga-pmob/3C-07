import 'dart:ui'; // Wajib buat efek blur kaca
import 'main_screen.dart';
import 'package:flutter/material.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  int _selectedCategory = 0; // 0: Film, 1: Food
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // BACKGROUND UTAMA APLIKASI: Pakai putih bersih biar efek kacanya kelihatan clean
      backgroundColor: Colors.white, 
      appBar: AppBar(
        title: const Text(
          'CINETIX',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
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
          // Kategori Selection
          Container(
            height: 60,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Film Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = 0;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    decoration: BoxDecoration(
                      color: _selectedCategory == 0 ? Colors.black : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: _selectedCategory == 0 ? Colors.black : Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.movie,
                          color: _selectedCategory == 0 ? Colors.white : Colors.black,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Film',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: _selectedCategory == 0 ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Food Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = 1;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    decoration: BoxDecoration(
                      color: _selectedCategory == 1 ? Colors.black : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: _selectedCategory == 1 ? Colors.black : Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.fastfood,
                          color: _selectedCategory == 1 ? Colors.white : Colors.black,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Food',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: _selectedCategory == 1 ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content Area dengan Scroll Biar Aman dari Kuning-Kuning
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: _selectedCategory == 0
                    ? _buildFilmContent()
                    : _buildFoodContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // ── 1. KONTEN FILM MURNI CLEAN & GLASS (BENING) ──
  Widget _buildFilmContent() {
    return Center(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05), // Bayangan super tipis biar clean
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0), // Efek buram kencang ala kaca frosted
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 35),
              decoration: BoxDecoration(
                // KUNCI GLASS BENING: Pakai warna hitam transparan tipis banget (0.05) biar nembus warna putih di belakangnya
                color: Colors.black.withOpacity(0.05), 
                border: Border.all(
                  color: Colors.black.withOpacity(0.15), // Tepian kaca halus
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Bebas kuning overflow
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.movie_creation_outlined, size: 40, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Belum ada tiket film',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Yuk, cari dan pesan tiket film favoritmu sekarang!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _navigateToHome(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Tombol dibikin hitam solid biar kontras dan tegas
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Cari Film', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  // ── 2. KONTEN FOOD MURNI CLEAN & GLASS (BENING) ──
  Widget _buildFoodContent() {
    return Center(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 35),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05), // Kaca bening
                border: Border.all(
                  color: Colors.black.withOpacity(0.15),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.fastfood_outlined, size: 40, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Belum ada pesanan',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Beli camilan popcorn biar nonton kamu lebih seru!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _navigateToFood(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Beli Cemilan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreenWrapper(initialIndex: 0),
      ),
    );
  }
  
  void _navigateToFood(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreenWrapper(initialIndex: 2),
      ),
    );
  }
}

// Wrapper untuk MainScreen dengan initial index
class MainScreenWrapper extends StatefulWidget {
  final int initialIndex;
  
  const MainScreenWrapper({super.key, required this.initialIndex});
  
  @override
  State<MainScreenWrapper> createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {
  @override
  Widget build(BuildContext context) {
    return MainScreen(initialIndex: widget.initialIndex);
  }
}