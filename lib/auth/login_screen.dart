import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  // Key untuk form
  final _formKey = GlobalKey<FormState>();
  // Controller untuk mengambil teks dari input field
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fungsi yang dipanggil saat tombol "Log In" ditekan
  void _login() {
    if (_formKey.currentState!.validate()) {
      // Jika validasi berhasil, navigasi ke halaman utama
      Navigator.pushReplacementNamed(context, '/main');
      
      // Untuk debugging (opsional)
      print('Nomor HP: ${_phoneController.text}');
      print('Password: ${_passwordController.text}');
    }
  }

  @override
  void dispose() {
    // Bersihkan controller saat widget dihapus
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // --- Logo/Header ---
                _buildHeader(),
                const SizedBox(height: 20),

                // --- Input Fields ---
                Text(
                  'Selamat Datang',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),

                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 30),

                // No HP Input
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'no HP*',
                    hintText: 'Masukkan no HP',
                    border: UnderlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan Nomor HP';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password Input
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password*',
                    hintText: 'Enter Password',
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan Password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // --- Link Simpan Password & Lupa Password ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        print('Simpan Password ditekan');
                      },
                      child: const Text('Simpan Password', style: TextStyle(color: Colors.grey)),
                    ),
                    TextButton(
                      onPressed: () {
                        print('Lupa Password ditekan');
                      },
                      child: const Text('Lupa Password', style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // --- Tombol Login ---
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC79244),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // --- Link Daftar ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Tidak punya akun?'),
                    TextButton(
                      onPressed: () {
                        // Navigasi ke halaman register
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        'Daftar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC79244),
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

  // Widget terpisah untuk bagian header/logo
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: 100, // Diperbesar dari 5 untuk menampung gambar
        height: 100, // Diperbesar dari 60 untuk menampung gambar
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 32, 29, 79),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Image.asset(
            'assets/logo.png',
            width: 80, // Sesuaikan ukuran gambar
            height: 80,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              // Fallback jika gambar tidak ditemukan
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.movie, color: Color(0xFFC79244), size: 40),
                  SizedBox(height: 8),
                  Text(
                    'CINETIX',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}