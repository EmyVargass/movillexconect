import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: Column(
        children: [
          // ── Header con imagen de fondo y logo ──
          Expanded(
            flex: 5,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Imagen de fondo
                Positioned.fill(
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCzevsjrXsLCVKYJasbOmGVG5DZfT55HXPldTcKrO_bkFiwjbwRb7FmJsw2TkPRYGU4yPCwQGN5B2y24UbFeB7Gay9e8WRFM9y84sMPbPvllXtF1xv6PpYJyF5KpgKINuT9fBB_ff9y5RFWJ7vPlggwXiukPKgcfUbrKRkyj6HPJpWoUGNUE-5MFkHLB6Mv1Q9tFXu_92CEfd96deauaC8UQqzDaG-NPId7vPJuzoutheEQWks2FifglxMwtyibGV3-GDWvHJih8kM',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.blueGrey.shade200,
                    ),
                  ),
                ),
                // Gradiente overlay
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          const Color(0xFFF6F7F8).withOpacity(0.5),
                          const Color(0xFFF6F7F8).withOpacity(0.95),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ),
                // Logo con ícono gavel
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.gavel_rounded,
                    color: Colors.white,
                    size: 56,
                  ),
                ),
              ],
            ),
          ),

          // ── Contenido inferior ──
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  // Título
                  const Text(
                    'LexConecta',
                    style: TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  // Subtítulo
                  const Text(
                    'Tu conexión legal de confianza',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const Spacer(),

                  // Botón Crear Cuenta
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.register);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        shadowColor: AppColors.primary.withOpacity(0.4),
                      ),
                      child: const Text(
                        'Crear Cuenta',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Botón Iniciar Sesión
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(
                          color: AppColors.primary,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Iniciar Sesión',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Footer
                  const Text(
                    'EXPERTOS EN DERECHO A UN CLIC',
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  // iOS Home Indicator
                  Container(
                    width: 128,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
