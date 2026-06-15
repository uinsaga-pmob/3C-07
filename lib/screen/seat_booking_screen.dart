import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/movie.dart';
import 'main_screen.dart';

class SeatBookingScreen extends StatefulWidget {
  final Movie movie;

  const SeatBookingScreen({super.key, required this.movie});

  @override
  State<SeatBookingScreen> createState() => _SeatBookingScreenState();
}

class _SeatBookingScreenState extends State<SeatBookingScreen> {
  // Config
  final int ticketPrice = 50000; // Rp. 50.000 per ticket
  
  // Selections
  late List<DateTime> _dates;
  late int _selectedDateIndex;
  late String _selectedTime;
  final List<String> _selectedSeats = [];

  // Mock occupied seats
  final Set<String> _occupiedSeats = {
    'A2', 'A5', 'B3', 'B4', 'C7', 'D4', 'D5', 'E1', 'E8', 'F3', 'F6'
  };

  final List<String> _times = ['12:30', '15:15', '18:00', '20:45'];
  final List<String> _rows = ['A', 'B', 'C', 'D', 'E', 'F'];
  final int _seatsPerRow = 8;

  @override
  void initState() {
    super.initState();
    // Generate next 7 days starting from today
    _dates = List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    _selectedDateIndex = 0;
    _selectedTime = _times[0];
  }

  String _formatWeekday(DateTime dt) {
    const weekdays = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
    return weekdays[dt.weekday % 7];
  }

  String _formatDateStr(DateTime dt) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${dt.day} ${months[dt.month - 1]}';
  }

  void _toggleSeat(String seatId) {
    if (_occupiedSeats.contains(seatId)) return;
    setState(() {
      if (_selectedSeats.contains(seatId)) {
        _selectedSeats.remove(seatId);
      } else {
        _selectedSeats.add(seatId);
      }
    });
  }

  Future<void> _bookTickets() async {
    if (_selectedSeats.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih kursi terlebih dahulu!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final date = _dates[_selectedDateIndex];
    final dateStr = '${_formatWeekday(date)}, ${_formatDateStr(date)}';
    final quantity = _selectedSeats.length;
    final total = quantity * ticketPrice;
    final seatsStr = _selectedSeats.join(', ');

    // Create DB entry map
    final booking = {
      'movieId': widget.movie.id ?? 0,
      'movieTitle': widget.movie.title,
      'movieImagePath': widget.movie.imagePath,
      'bookingDate': dateStr,
      'bookingTime': _selectedTime,
      'seats': seatsStr,
      'quantity': quantity,
      'totalPrice': total,
    };

    // Save to Database
    await DatabaseHelper.instance.insertBooking(booking);

    // Show booking receipt success dialog
    if (mounted) {
      _showSuccessDialog(dateStr, seatsStr, quantity, total);
    }
  }

  void _showSuccessDialog(String dateStr, String seatsStr, int quantity, int total) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.85),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated check icon
                      Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          color: Color(0xFFC79244),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x66C79244),
                              blurRadius: 15,
                              spreadRadius: 2,
                            )
                          ]
                        ),
                        child: const Icon(Icons.check, color: Colors.white, size: 40),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Pemesanan Berhasil!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tiket Anda telah berhasil dipesan & disimpan.',
                        style: TextStyle(color: Colors.grey[400], fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      // Ticket receipt mockup container
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            // Ticket Header
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/logo.png',
                                    height: 30,
                                    width: 30,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.movie,
                                      color: Color(0xFFC79244),
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'CINETIX TICKET',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Ticket Details
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.movie.title.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildReceiptDetail('TANGGAL', dateStr),
                                      _buildReceiptDetail('WAKTU', _selectedTime),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildReceiptDetail('KURSI', seatsStr),
                                      _buildReceiptDetail('JUMLAH', '$quantity Tiket'),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildReceiptDetail('BIOSKOP', 'Cinema 1 (3D/HD)'),
                                      _buildReceiptDetail('TOTAL BAYAR', 'Rp ${total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}'),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  // Separator line
                                  Row(
                                    children: List.generate(
                                      20,
                                      (index) => Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 2),
                                          height: 1,
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  // Fake Barcode
                                  Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 220,
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Code_128_Barcode.svg/1200px-Code_128_Barcode.svg.png'),
                                              fit: BoxFit.fill,
                                            ),
                                            // Fallback pure vector representation if network fails
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: List.generate(28, (index) {
                                              return Container(
                                                width: (index % 3 == 0) ? 4 : (index % 2 == 0) ? 2 : 1,
                                                color: Colors.black,
                                              );
                                            }),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          'CNT-BK-${widget.movie.id ?? 99}-${DateTime.now().millisecond}',
                                          style: TextStyle(
                                            fontSize: 11,
                                            letterSpacing: 3,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      // View Tickets button
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => const MainScreen(initialIndex: 1)),
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC79244),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'LIHAT TIKET SAYA',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildReceiptDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey[500], fontSize: 11, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF13131D), // Elegant cinetic dark
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.movie.title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. Date selector (horizontal)
          Container(
            height: 80,
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _dates.length,
              itemBuilder: (context, index) {
                final date = _dates[index];
                final isSelected = index == _selectedDateIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDateIndex = index;
                    });
                  },
                  child: Container(
                    width: 70,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFC79244) : const Color(0xFF1D1D2B),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected ? const Color(0xFFC79244) : const Color(0xFF2E2E3E),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _formatWeekday(date),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[400],
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // 2. Showtime selector (horizontal)
          Container(
            height: 46,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _times.length,
              itemBuilder: (context, index) {
                final time = _times[index];
                final isSelected = time == _selectedTime;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTime = time;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFC79244) : const Color(0xFF1D1D2B),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected ? const Color(0xFFC79244) : const Color(0xFF2E2E3E),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      time,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[300],
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // 3. Cinema Screen Indicator
          const SizedBox(height: 12),
          Center(
            child: CustomPaint(
              size: const Size(280, 24),
              painter: ScreenArcPainter(),
            ),
          ),
          Center(
            child: Text(
              'Layar Bioskop',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 11,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 4. Seat Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _rows.length * (_seatsPerRow + 1), // extra column for row letter in center or aisle
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 9, // 4 seats, 1 space (aisle), 4 seats
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final rowIndex = index ~/ 9;
                  final colIndex = index % 9;

                  // Middle column is the aisle
                  if (colIndex == 4) {
                    return Center(
                      child: Text(
                        _rows[rowIndex],
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  // Calculate actual seat index
                  final seatColIndex = colIndex < 4 ? colIndex + 1 : colIndex;
                  final seatId = '${_rows[rowIndex]}$seatColIndex';
                  final isOccupied = _occupiedSeats.contains(seatId);
                  final isSelected = _selectedSeats.contains(seatId);

                  Color seatColor;
                  Border? seatBorder;
                  if (isOccupied) {
                    seatColor = const Color(0xFF2E2E3E);
                  } else if (isSelected) {
                    seatColor = const Color(0xFFC79244);
                  } else {
                    seatColor = Colors.transparent;
                    seatBorder = Border.all(color: const Color(0xFF424258), width: 1.5);
                  }

                  return GestureDetector(
                    onTap: () => _toggleSeat(seatId),
                    child: Container(
                      decoration: BoxDecoration(
                        color: seatColor,
                        border: seatBorder,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: isOccupied
                          ? const Center(
                              child: Icon(Icons.close, color: Color(0xFF5A5A7A), size: 12),
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),

          // Legend
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegendItem(Colors.transparent, 'Tersedia', border: Border.all(color: const Color(0xFF424258), width: 1.5)),
                _buildLegendItem(const Color(0xFF2E2E3E), 'Terisi'),
                _buildLegendItem(const Color(0xFFC79244), 'Pilihan'),
              ],
            ),
          ),

          // 5. Checkout Panel
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            decoration: const BoxDecoration(
              color: Color(0xFF1D1D2B),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _selectedSeats.isEmpty
                                ? 'Belum ada kursi terpilih'
                                : 'Kursi: ${_selectedSeats.join(', ')}',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Rp ${(_selectedSeats.length * ticketPrice).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 160,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _bookTickets,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC79244),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'BELI TIKET',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text, {Border? border}) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            border: border,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(color: Colors.grey[400], fontSize: 12),
        ),
      ],
    );
  }
}

class ScreenArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFC79244).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path();
    path.moveTo(10, size.height);
    path.quadraticBezierTo(size.width / 2, 0, size.width - 10, size.height);
    
    final shadowPaint = Paint()
      ..color = const Color(0xFFC79244).withOpacity(0.12)
      ..style = PaintingStyle.fill;
    
    final fillPath = Path()
      ..moveTo(10, size.height)
      ..quadraticBezierTo(size.width / 2, 0, size.width - 10, size.height)
      ..lineTo(size.width - 10, size.height + 25)
      ..lineTo(10, size.height + 25)
      ..close();
    
    canvas.drawPath(fillPath, shadowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
