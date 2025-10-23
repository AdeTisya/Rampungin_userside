import 'package:flutter/material.dart';
import 'package:rampungin_id_userside/screens/detail/bangunan_screen.dart';
import 'package:rampungin_id_userside/screens/detail/katagoribangunan_screen.dart';
import 'package:rampungin_id_userside/screens/detail/elektronik_screen.dart';
// import 'package:rampungin_id_userside/screens/detail/car_screen.dart';
// import 'package:rampungin_id_userside/screens/detail/lisrik_screen.dart';
import 'package:rampungin_id_userside/screens/detail/cs_screen.dart';
import 'package:rampungin_id_userside/screens/detail/detail_order.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final int _currentIndex = 1;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Data tukang per kategori
  final Map<String, List<Map<String, dynamic>>> _techniciansByCategory = {
    'Bangunan': [
      {
        'name': 'Budi Santoso',
        'description': 'Tukang Bangunan',
        'experience': '15 tahun pengalaman',
        'rating': 4.8,
        'reviews': 127,
        'specialty': 'Renovasi & Bangun Rumah',
        'price': 'Rp 150.000/hari',
        'status': 'online',
        'technicianId': 'tech_build_001',
        'image': 'assets/img/technician1.png', // Placeholder
      },
      {
        'name': 'Agus Wijaya',
        'description': 'Tukang Cat',
        'experience': '10 tahun pengalaman',
        'rating': 4.9,
        'reviews': 95,
        'specialty': 'Pengecatan Interior & Eksterior',
        'price': 'Rp 120.000/hari',
        'status': 'online',
        'technicianId': 'tech_build_002',
        'image': 'assets/img/technician2.png',
      },
      {
        'name': 'Hendra Kusuma',
        'description': 'Tukang Batu',
        'experience': '12 tahun pengalaman',
        'rating': 4.7,
        'reviews': 143,
        'specialty': 'Pasang Keramik & Ubin',
        'price': 'Rp 130.000/hari',
        'status': 'online',
        'technicianId': 'tech_build_003',
        'image': 'assets/img/technician3.png',
      },
    ],
    'Elektronik': [
      {
        'name': 'Andi Pratama',
        'description': 'Service TV & Home Theater',
        'experience': '9 tahun pengalaman',
        'rating': 4.9,
        'reviews': 156,
        'specialty': 'Elektronik Entertainment',
        'price': 'Rp 100.000 + sparepart',
        'status': 'online',
        'technicianId': 'tech_elec_001',
        'image': 'assets/img/technician4.png',
      },
      {
        'name': 'Dedi Kurniawan',
        'description': 'Teknisi AC',
        'experience': '12 tahun pengalaman',
        'rating': 4.8,
        'reviews': 234,
        'specialty': 'AC Semua Merk',
        'price': 'Rp 120.000 + sparepart',
        'status': 'online',
        'technicianId': 'tech_elec_002',
        'image': 'assets/img/technician5.png',
      },
    ],
    'Cleaning Service': [
      {
        'name': 'Siti Aminah',
        'description': 'Cleaning Professional',
        'experience': '7 tahun pengalaman',
        'rating': 4.9,
        'reviews': 189,
        'specialty': 'Pembersihan Rumah & Kantor',
        'price': 'Rp 80.000/hari',
        'status': 'online',
        'technicianId': 'tech_cs_001',
        'image': 'assets/img/technician6.png',
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );


    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();

    super.dispose();
  }

  void _handleNavigation(int index) {
    if (index == _currentIndex) return;


    _fadeController.reverse().then((_) {
      switch (index) {
        case 0:
          Navigator.of(context).pushReplacementNamed('/ChatScreen');
          break;
        case 1:
          break;
        case 2:
          Navigator.of(context).pushReplacementNamed('/PaymentScreen');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6E8),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                SlideTransition(
                  position: _slideAnimation,
                  child: _buildMainContent(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildAnimatedBottomNav(),
    );
  }

  Widget _buildAnimatedBottomNav() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE6B366), Color(0xFFF3B950)],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.15),
            offset: const Offset(0, -4),
            blurRadius: 16,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(0, Icons.chat_bubble_outline, Icons.chat_bubble, 'Chat'),
            _buildNavItem(1, Icons.home_outlined, Icons.home, 'Home', isCenter: true),
            _buildNavItem(2, Icons.account_balance_wallet_outlined, Icons.account_balance_wallet, 'Payment'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData icon,
    IconData activeIcon,
    String label, {
    bool isCenter = false,
  }) {
    bool isSelected = _currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => _handleNavigation(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: isCenter && isSelected
              ? BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                )
              : isSelected && !isCenter
                  ? BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    )
                  : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  isSelected ? activeIcon : icon,
                  key: ValueKey(isSelected),
                  size: isCenter ? 28 : 24,
                  color: isCenter && isSelected
                      ? const Color(0xFFF3B950)
                      : isSelected
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 2),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isCenter && isSelected
                      ? const Color(0xFFF3B950)
                      : isSelected
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.7),
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFFFBB41),
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(200)),
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 20,
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(25, 12, 25, 60),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 21),
                Hero(
                  tag: 'app_logo',
                  child: Image.asset(
                    'assets/img/LogoRampung.png',
                    width: 120,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 23),
                const Text(
                  'Selamat Datang (nama)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'KdamThmorPro',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildHeaderIcon(
                  Icons.person_outline,
                  () => Navigator.of(context).pushNamed('/ProfileScreen'),
                  size: 45,
                ),
                const SizedBox(width: 8),
                _buildHeaderIcon(
                  Icons.notifications_none,
                  () => Navigator.of(context).pushNamed('/NotificationScreen'),
                  size: 30,
                  iconSize: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon(
    IconData icon,
    VoidCallback onTap, {
    double size = 30,
    double iconSize = 24,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(size / 2),
          onTap: onTap,
          child: Icon(icon, color: const Color(0xFFF3B950), size: iconSize),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),
          _buildAnimatedCard(_buildBalanceCard(), delay: 0),
          const SizedBox(height: 20),
          _buildAnimatedCard(_buildSearchBar(), delay: 100),

          const SizedBox(height: 31),
          // Kategori Tukang dengan Cards
          ..._buildCategoryTechnicians(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  List<Widget> _buildCategoryTechnicians() {
    List<Widget> widgets = [];
    int delay = 200;

    _techniciansByCategory.forEach((category, technicians) {
      widgets.add(_buildAnimatedCard(
        _buildCategorySection(category, technicians),
        delay: delay,
      ));
      delay += 100;
    });

    return widgets;
  }

  Widget _buildCategorySection(String category, List<Map<String, dynamic>> technicians) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () => _navigateToCategory(category),
                child: const Text(
                  'Lihat Semua',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFF3B950),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: technicians.length,
            itemBuilder: (context, index) {
              return _buildTechnicianCard(technicians[index]);
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildTechnicianCard(Map<String, dynamic> technician) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _navigateToDetailOrder(technician),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Foto Tukang
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3B950).withValues(alpha: 0.2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: const Color(0xFFF3B950),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama
                    Text(
                      technician['name'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${technician['rating']} (${technician['reviews']})',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Harga
                    Text(
                      technician['price'],
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFF3B950),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Button Pesan
                    SizedBox(
                      width: double.infinity,
                      height: 32,
                      child: ElevatedButton(
                        onPressed: () => _navigateToDetailOrder(technician),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF3B950),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text(
                          'Pesan Sekarang',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToCategory(String category) {
    Widget screen;
    switch (category) {
      case 'Bangunan':
        screen = const BangunanScreen();
        break;
      case 'Elektronik':
        screen = const ElektronikScreen();
        break;
      case 'Cleaning Service':
        screen = const CsScreen();
        break;
      default:
        screen = const KategoriBangunanScreen();
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void _navigateToDetailOrder(Map<String, dynamic> technicianData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailOrder(technicianData: technicianData),
      ),
    );
  }

  Widget _buildAnimatedCard(Widget child, {int delay = 0}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + delay),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: child,
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3B950),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 13),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saldo Anda',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Rp. xx.xxx.xxx',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          _buildTopUpButton(),
        ],
      ),
    );
  }

  Widget _buildTopUpButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.of(context).pushNamed('/PaymentScreen');
        },
        child: Column(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: const Color(0xFFF3B950),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 20),
            ),
            const SizedBox(height: 4),
            const Text(
              'Top up',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Center(
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 318),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey, size: 20),
            const SizedBox(width: 10),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari tukang disini...',
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {},
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3B950),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.tune, color: Colors.white, size: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}