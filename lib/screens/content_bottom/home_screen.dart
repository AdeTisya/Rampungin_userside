import 'package:flutter/material.dart';
import 'package:rampungin_id_userside/screens/detail/bangunan_screen.dart';
import 'package:rampungin_id_userside/screens/detail/katagoribangunan_screen.dart';
import 'package:rampungin_id_userside/screens/detail/elektronik_screen.dart';
// import 'package:rampungin_id_userside/screens/detail/ac_screen.dart'; 
import 'package:rampungin_id_userside/screens/detail/car_screen.dart';
import 'package:rampungin_id_userside/screens/detail/lisrik_screen.dart'; 
import 'package:rampungin_id_userside/screens/detail/cs_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final int _currentIndex = 1;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Fade animation for overall content
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Slide animation for cards
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Scale animation for interactive elements

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

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _handleNavigation(int index) {
    if (index == _currentIndex) return;

    // Animate out before navigation
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
            color: const Color(0xFF000000).withValues(alpha:0.15),
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
            _buildNavItem(
              0,
              Icons.chat_bubble_outline,
              Icons.chat_bubble,
              'Chat',
            ),
            _buildNavItem(
              1,
              Icons.home_outlined,
              Icons.home,
              'Home',
              isCenter: true,
            ),
            _buildNavItem(
              2,
              Icons.account_balance_wallet_outlined,
              Icons.account_balance_wallet,
              'Payment',
            ),
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
          decoration:
              isCenter && isSelected
                  ? BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha:0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  )
                  : isSelected && !isCenter
                  ? BoxDecoration(
                    color: Colors.white.withValues(alpha:0.2),
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
                  color:
                      isCenter && isSelected
                          ? const Color(0xFFF3B950)
                          : isSelected
                          ? Colors.white
                          : Colors.white.withValues(alpha:0.7),
                ),
              ),
              const SizedBox(height: 2),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color:
                      isCenter && isSelected
                          ? const Color(0xFFF3B950)
                          : isSelected
                          ? Colors.white
                          : Colors.white.withValues(alpha:0.7),
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
            color: Colors.black.withValues(alpha:0.1),
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
          // const SizedBox(height: 17),
          // _buildAnimatedCard(_buildPopularServicesSection(), delay: 200),
          const SizedBox(height: 31),
          _buildAnimatedCard(_buildCategoriesSection(), delay: 300),
          const SizedBox(height: 10),
        ],
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
            color: Colors.black.withValues(alpha:0.1),
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
              color: Colors.black.withValues(alpha:0.1),
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
                onTap: () {
                  // Filter action
                },
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

  // Widget _buildPopularServicesSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Padding(
  //         padding: EdgeInsets.only(left: 80),
  //         child: Text(
  //           'Tukang Terpopuler :',
  //           style: TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.w600,
  //             color: Colors.black,
  //           ),
  //         ),
  //       ),
  //       const SizedBox(height: 12),
  //       _buildServiceCardWithBackground(
  //         Icons.ac_unit, 
  //         'Layanan AC', 
  //         'assets/img/ac.png',
  //         const Color(0xFF2196F3),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildServiceCardWithBackground(
  //   IconData icon, 
  //   String title, 
  //   String backgroundImagePath, 
  //   Color overlayColor,
  // ) {
  //   return Center(
  //     child: Material(
  //       color: Colors.transparent,
  //       child: InkWell(
  //         borderRadius: BorderRadius.circular(15),
  //         onTap: () {
  //           if (title == 'Layanan AC') {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => const AcScreen()),
  //             );
  //           }
  //         },
  //         child: Container(
  //           width: double.infinity,
  //           constraints: const BoxConstraints(maxWidth: 296),
  //           height: 80,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(15),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.black.withValues(alpha:0.2),
  //                 blurRadius: 10,
  //                 offset: const Offset(0, 4),
  //               ),
  //             ],
  //           ),
  //           child: Stack(
  //             children: [
  //               // Background Image
  //               ClipRRect(
  //                 borderRadius: BorderRadius.circular(15),
  //                 child: Image.asset(
  //                   backgroundImagePath,
  //                   width: double.infinity,
  //                   height: double.infinity,
  //                   fit: BoxFit.cover,
  //                   errorBuilder: (context, error, stackTrace) {
  //                     // Fallback jika gambar tidak ditemukan
  //                     return Container(
  //                       color: overlayColor,
  //                     );
  //                   },
  //                 ),
  //               ),
                
  //               // Overlay untuk meningkatkan kontras
  //               Container(
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(15),
  //                   gradient: LinearGradient(
  //                     begin: Alignment.centerLeft,
  //                     end: Alignment.centerRight,
  //                     colors: [
  //                       overlayColor.withValues(alpha:0.7),
  //                       overlayColor.withValues(alpha:0.4),
  //                     ],
  //                   ),
  //                 ),
  //               ),

  //               // Content
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 20),
  //                 child: Row(
  //                   children: [
  //                     Container(
  //                       width: 50,
  //                       height: 50,
  //                       decoration: BoxDecoration(
  //                         color: Colors.white.withValues(alpha:0.2),
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                       child: Icon(icon, color: Colors.white, size: 30),
  //                     ),
  //                     const SizedBox(width: 15),
  //                     Text(
  //                       title,
  //                       style: const TextStyle(
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.w600,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                     const Spacer(),
  //                     Container(
  //                       width: 30,
  //                       height: 30,
  //                       decoration: BoxDecoration(
  //                         color: Colors.white.withValues(alpha:0.2),
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                       child: const Icon(
  //                         Icons.arrow_forward_ios,
  //                         color: Colors.white,
  //                         size: 16,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 80),
          child: Text(
            'Kategori Tukang :',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildCategoryRow([
          _buildCategoryItem(
            Icons.house,
            'Bangunan',
            const Color(0xFFFF9800),
            0,
          ),
          _buildCategoryItem(
            Icons.electrical_services,
            'Elektronik',
            const Color(0xFF9C27B0),
            1,
          ),
          _buildCategoryItem(
            Icons.directions_car,
            'Car',
            const Color(0xFFF44336),
            2,
          ),
        ]),
        const SizedBox(height: 15),
        _buildCategoryRow([
          _buildCategoryItem(
            Icons.cleaning_services,
            'Cleaning Service',
            const Color(0xFF2196F3),
            3,
          ),
          _buildCategoryItem(
            Icons.electrical_services,
            'Listrik',
            const Color(0xFFFFC107),
            4,
          ),
          _buildCategoryItem(
            Icons.more_horiz,
            'More',
            const Color(0xFF607D8B),
            5,
          ),
        ]),
      ],
    );
  }

  Widget _buildCategoryRow(List<Widget> items) {
    return Center(
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 296),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items,
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
    IconData icon,
    String title,
    Color color,
    int index,
  ) {
    return Expanded(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 400 + (index * 50)),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: Opacity(opacity: value, child: child),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BangunanScreen(),
                    ),
                  );
                } else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ElektronikScreen(),
                    ),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CarScreen()),
                  );
                } else if (index == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CsScreen()),
                  );
                } else if (index == 4) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LisrikScreen(),
                    ),
                  );
                } else if (index == 5) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KategoriBangunanScreen(),
                    ),
                  );
                }
              },
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha:0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(icon, color: Colors.white, size: 30),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}