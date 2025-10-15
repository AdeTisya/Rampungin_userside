import 'package:flutter/material.dart';
import 'package:rampungin_id_userside/screens/detail/elektronik_screen.dart';
import 'screens/Widgets/welcome.dart';
import 'screens/Login/login.dart';
import 'screens/content_bottom/home_screen.dart';
import 'screens/content_bottom/chat_screen.dart';
import 'screens/content_bottom/payment_screen.dart';
import 'screens/detail/notification_screen.dart';
import 'screens/detail/profile_screen.dart';
import 'screens/detail/bangunan_screen.dart';
import 'screens/detail/katagoribangunan_screen.dart';
import 'screens/detail/setting.dart';
import 'screens/detail/lisrik_screen.dart';
import 'screens/detail/ac_screen.dart';
import 'screens/detail/cs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Welcome(),
        '/login': (context) => const LoginScreen(),
        '/HomeScreen': (context) => const HomeScreen(),  
        '/ChatScreen': (context) => const ChatScreen(),  
        '/PaymentScreen': (context) => const PaymentScreen(), 
        '/NotificationScreen': (context) => const NotificationScreen(),
        '/ProfileScreen': (context) => ProfileScreen(),
        '/BangunanScreen': (context) => const BangunanScreen(),
        '/KategoriBangunanMaster': (context) => const KategoriBangunanScreen(),
        '/ElektronikScreen': (context) => const ElektronikScreen(),
        '/setting': (context) => Setting(),
        '/LisrikScreen': (context) => const LisrikScreen(),
        '/AcScreen': (context) => const AcScreen(),
        '/CsScreen': (context) => const CsScreen(),
      },
    );
  }
}