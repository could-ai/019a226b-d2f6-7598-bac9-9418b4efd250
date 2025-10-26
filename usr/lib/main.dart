import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/consultation_provider.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/symptom_entry_screen.dart';
import 'screens/doctor_matching_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/consultation_screen.dart';
import 'screens/feedback_screen.dart';
import 'screens/forum_screen.dart';
import 'screens/webinar_screen.dart';
import 'screens/corporate_dashboard_screen.dart';
import 'screens/admin_panel_screen.dart';

void main() {
  runApp(const CareTeamAfricaApp());
}

class CareTeamAfricaApp extends StatelessWidget {
  const CareTeamAfricaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ConsultationProvider()),
      ],
      child: MaterialApp.router(
        title: 'CareTeam Africa',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF1E3A8A), // Royal Blue
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1E3A8A),
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
              foregroundColor: Colors.white,
            ),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1E3A8A),
            secondary: const Color(0xFFFFD700), // Gold
          ),
          textTheme: const TextTheme(
            headlineMedium: TextStyle(
              color: Color(0xFF1E3A8A),
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: TextStyle(color: Colors.black87),
          ),
        ),
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/symptom-entry',
      builder: (context, state) => const SymptomEntryScreen(),
    ),
    GoRoute(
      path: '/doctor-matching',
      builder: (context, state) => const DoctorMatchingScreen(),
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) => const PaymentScreen(),
    ),
    GoRoute(
      path: '/consultation',
      builder: (context, state) => const ConsultationScreen(),
    ),
    GoRoute(
      path: '/feedback',
      builder: (context, state) => const FeedbackScreen(),
    ),
    GoRoute(
      path: '/forum',
      builder: (context, state) => const ForumScreen(),
    ),
    GoRoute(
      path: '/webinar',
      builder: (context, state) => const WebinarScreen(),
    ),
    GoRoute(
      path: '/corporate-dashboard',
      builder: (context, state) => const CorporateDashboardScreen(),
    ),
    GoRoute(
      path: '/admin-panel',
      builder: (context, state) => const AdminPanelScreen(),
    ),
  ],
);
