import 'package:flutter/material.dart';
import 'constants/app_colors.dart';
import 'constants/app_routes.dart';
// ── Onboarding ──
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/role_selection_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
// ── Homes por rol ──
import 'screens/home_client_screen.dart';
import 'screens/home_lawyer_screen.dart';
// ── Flujo abogado ──
import 'screens/solicitudes_screen.dart';
import 'screens/solicitud_detalle_screen.dart';
import 'screens/crear_propuesta_screen.dart';
// ── Compartidas ──
import 'screens/search_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/activity_screen.dart';
import 'screens/activity_client_screen.dart';
import 'screens/lawyer_profile_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LexConecta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          error: AppColors.error,
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      initialRoute: AppRoutes.splash,
      routes: {
        // ── Onboarding ──
        AppRoutes.splash:           (context) => const SplashScreen(),
        AppRoutes.welcome:          (context) => const WelcomeScreen(),
        AppRoutes.roleSelection:    (context) => const RoleSelectionScreen(),
        AppRoutes.login:            (context) => const LoginScreen(),
        AppRoutes.register:         (context) => const RegisterScreen(),
        AppRoutes.registerClient:   (context) => const RegisterScreen(),
        AppRoutes.registerLawyer:   (context) => const RegisterScreen(),
        // ── Homes por rol ──
        AppRoutes.home:             (context) => const HomeClientScreen(),
        AppRoutes.homeClient:       (context) => const HomeClientScreen(),
        AppRoutes.homeLawyer:       (context) => const HomeLawyerScreen(),
        // ── Flujo abogado ──
        AppRoutes.solicitudes:      (context) => const SolicitudesScreen(),
        AppRoutes.solicitudDetalle: (context) => const SolicitudDetalleScreen(),
        AppRoutes.crearPropuesta:   (context) => const CrearPropuestaScreen(),
        // ── Compartidas ──
        AppRoutes.search:           (context) => const SearchScreen(),
        AppRoutes.messages:         (context) => const MessagesScreen(),
        AppRoutes.chat:             (context) => const ChatScreen(),
        AppRoutes.activity:         (context) => const ActivityScreen(),
        AppRoutes.activityClient:   (context) => const ActivityClientScreen(),
        AppRoutes.lawyerProfile:    (context) => const LawyerProfileScreen(),
        AppRoutes.profile:          (context) => const ProfileScreen(),
        AppRoutes.notifications:    (context) => const NotificationsScreen(),
        AppRoutes.settings:         (context) => const SettingsScreen(),
      },
    );
  }
}
