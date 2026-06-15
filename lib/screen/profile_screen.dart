import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback? onModeChanged;

  const ProfileScreen({super.key, this.onModeChanged});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Data user (Bisa di-update setelah dari halaman Edit Profil)
  Map<String, String> userData = {
    'name': 'Fahri Kenalpot',
    'phone': '+62 877-2578-2809',
    'email': 'juragansayur04@gmail.com',
  };

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Konfirmasi Logout', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Ya, Logout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  // JALUR NAVIGASI KE HALAMAN EDIT PROFIL YANG SUDAH DIISI
  void _editProfile() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          currentName: userData['name']!,
          currentPhone: userData['phone']!,
          currentEmail: userData['email']!,
        ),
      ),
    );

    // Kalau user kelar edit dan klik simpan, datanya langsung nge-refresh di sini
    if (result != null) {
      setState(() {
        userData = result;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profil berhasil diperbarui!'),
          backgroundColor: const Color.fromARGB(255, 29, 110, 11),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _contactUs() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Hubungi Kami', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Customer Service:', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              _buildContactItem(Icons.phone_outlined, '0896-1234-5678'),
              const SizedBox(height: 12),
              _buildContactItem(Icons.email_outlined, 'support@cinetix.com'),
              const SizedBox(height: 12),
              _buildContactItem(Icons.location_on_outlined, 'Jl. Cinema No. 123, JKT'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup', style: TextStyle(color: Colors.indigo)),
            ),
          ],
        );
      },
    );
  }

  void _changeAccount() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Ganti Akun', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('Anda akan diarahkan ke halaman login untuk masuk dengan akun lain.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Ganti Akun', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Off-white elegan
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF8F9FA),
        title: const Text(
          'CINETIX',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/logo.png',
              height: 35,
              width: 35,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.movie_creation_outlined, color: Colors.indigo, size: 28);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Header Profil Elegan Putih
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.indigo.shade50,
                      border: Border.all(color: Colors.indigo.shade100, width: 2),
                    ),
                    child: Icon(Icons.person, size: 40, color: Colors.indigo.shade400),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData['name']!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userData['email']!,
                          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          userData['phone']!,
                          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 2. Row Statistik Minimalis (Dashboard Ringkas)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem(Icons.calendar_today_rounded, 'Dec 23', 'Member'),
                    Container(height: 30, width: 1, color: Colors.grey.shade200),
                    _buildStatItem(Icons.confirmation_num_outlined, '15', 'Transaksi'),
                    Container(height: 30, width: 1, color: Colors.grey.shade200),
                    _buildStatItem(Icons.stars_rounded, '1,250', 'Points'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 3. Pilihan Menu List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Text(
                      'Pengaturan Akun',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildMenuTile(
                    icon: Icons.edit_outlined,
                    title: 'Edit Profil',
                    onTap: _editProfile,
                  ),
                  _buildMenuTile(
                    icon: Icons.chat_bubble_outline_rounded,
                    title: 'Hubungi Kami',
                    onTap: _contactUs,
                  ),
                  _buildMenuTile(
                    icon: Icons.switch_account_outlined,
                    title: 'Ganti Akun',
                    onTap: _changeAccount,
                  ),
                  _buildMenuTile(
                    icon: DatabaseHelper.instance.isAdmin ? Icons.person_outline : Icons.admin_panel_settings_outlined,
                    title: DatabaseHelper.instance.isAdmin ? 'Ubah ke Mode User' : 'Ubah ke Mode Admin',
                    onTap: () {
                      setState(() {
                        DatabaseHelper.instance.isAdmin = !DatabaseHelper.instance.isAdmin;
                      });
                      widget.onModeChanged?.call();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(DatabaseHelper.instance.isAdmin 
                              ? 'Beralih ke Mode Admin' 
                              : 'Beralih ke Mode User'),
                          backgroundColor: Colors.indigo,
                        ),
                      );
                    },
                  ),
                  _buildMenuTile(
                    icon: Icons.logout_rounded,
                    title: 'Log Out',
                    onTap: () => _logout(context),
                    isLogout: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // App Version
            Text(
              'CINETIX v1.0.0',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 12, letterSpacing: 0.5),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.indigo.shade400, size: 20),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(
          icon,
          color: isLogout ? Colors.red.shade600 : Colors.indigo.shade600,
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isLogout ? Colors.red.shade600 : Colors.black87,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: isLogout ? Colors.red.shade300 : Colors.grey.shade400,
          size: 20,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.indigo.shade600),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(fontSize: 15, color: Colors.black87)),
      ],
    );
  }
}


// ── HALAMAN EDIT PROFIL (FORM AKTIF & ELEGANNYA DI SINI) ──
class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentPhone;
  final String currentEmail;

  const EditProfileScreen({
    super.key,
    required this.currentName,
    required this.currentPhone,
    required this.currentEmail,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _phoneController = TextEditingController(text: widget.currentPhone);
    _emailController = TextEditingController(text: widget.currentEmail);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Kirim balik data kosmetik baru ke ProfileScreen
      Navigator.pop(context, {
        'name': _nameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF8F9FA),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Profil',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Foto Profil Editor Dummy
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.indigo.shade50,
                        border: Border.all(color: Colors.indigo.shade200, width: 2),
                      ),
                      child: Icon(Icons.person, size: 50, color: Colors.indigo.shade300),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.indigo,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 16),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Input Field Nama
              _buildInputField(
                controller: _nameController,
                label: 'Nama Lengkap',
                icon: Icons.person_outline_rounded,
                validator: (val) => val == null || val.isEmpty ? 'Nama gak boleh kosong, Dawg' : null,
              ),
              const SizedBox(height: 20),

              // Input Field Email
              _buildInputField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Email wajib diisi';
                  if (!val.contains('@')) return 'Format email salah, Cok';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Input Field No. HP
              _buildInputField(
                controller: _phoneController,
                label: 'Nomor Telepon',
                icon: Icons.phone_android_outlined,
                keyboardType: TextInputType.phone,
                validator: (val) => val == null || val.isEmpty ? 'Nomor HP isi dulu' : null,
              ),
              const SizedBox(height: 40),

              // Tombol Simpan
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Simpan Perubahan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: Icon(icon, color: Colors.indigo.shade400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}