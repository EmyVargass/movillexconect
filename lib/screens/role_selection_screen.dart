import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_routes.dart';
import '../services/app_session.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole; // 'cliente' | 'abogado'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top App Bar ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    style: IconButton.styleFrom(
                      foregroundColor: const Color(0xFF0F172A),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Registro',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                  // Espacio para centrar el título
                  const SizedBox(width: 48),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ── Header ──
                    const SizedBox(height: 32),
                    const Text(
                      '¿Cómo quieres usar la app?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Selecciona el perfil que mejor se adapte\na tus necesidades para comenzar.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // ── Cards de Rol ──
                    _RoleCard(
                      role: 'cliente',
                      title: 'Soy Cliente',
                      subtitle: 'Necesito asesoría legal',
                      icon: Icons.person_rounded,
                      imageUrl:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuDr8Ta9lW82MUMQgITHFmpwXhSCEsJnKAjE6ku1-1ReXU1tnyhojtLcWiQH0P8OtiP8aQPlnmaY-ftrqqa3Dh1v9QN4IeIr-7DK43s-whxyR71TorRpXh8oqhr7l3N-e04w9hernL72XUk8AacYjZhAg5X_6Qz5VSb2_w0s3pQpl0zYxo0OECyCLTvtSjhc5tPkee3Jqd_BkW3DNyGll9KRab4KfBUnipSAXbgmstJwNDzl1gJHubm7I9qHe4_dDCEE5XadLLN3qZI',
                      isSelected: _selectedRole == 'cliente',
                      onTap: () => setState(() => _selectedRole = 'cliente'),
                    ),
                    const SizedBox(height: 12),
                    _RoleCard(
                      role: 'abogado',
                      title: 'Soy Abogado',
                      subtitle: 'Quiero ofrecer mis servicios',
                      icon: Icons.work_rounded,
                      imageUrl:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuAK5WEgYEbBbifm6HMjkDkkZ_7X9LzJlg8QrZt3jDMNGutLNgSNO_q9VeWmtxVweo1MOu_UG4S5fvcrEohsB5cmlp0BFAQlaHWu-nFHF1FvqjV6gbw70a38MJ5Woi1_bYlwhJVgDamtwUUfg5OtOg5kBcfiEupi6bZESD4gQqRbeicabjpT_Wzt3gmgpRv21pwX54btwOdoQ-eWsXbCqZs7lANlIC-TQrbQsXCO-RbLO5OKQrZeBMNC_-mhE5WsEHKJi-5gU',
                      isSelected: _selectedRole == 'abogado',
                      onTap: () => setState(() => _selectedRole = 'abogado'),
                    ),

                    const Spacer(),

                    // ── Botón Continuar ──
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _selectedRole == null
                            ? null
                            : () {
                                AppSession.setRole(_selectedRole!);
                                final route = _selectedRole == 'abogado'
                                    ? AppRoutes.registerLawyer
                                    : AppRoutes.registerClient;
                                Navigator.pushNamed(context, route);
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          disabledBackgroundColor:
                              AppColors.primary.withOpacity(0.4),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          shadowColor: AppColors.primary.withOpacity(0.25),
                        ),
                        child: const Text(
                          'Continuar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ── Link Iniciar Sesión ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '¿Ya tienes una cuenta? ',
                          style: TextStyle(
                              fontSize: 14, color: Color(0xFF64748B)),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, AppRoutes.login),
                          child: const Text(
                            'Inicia sesión',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ── Indicador de progreso ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Paso activo
                        Container(
                          width: 28,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                        const SizedBox(width: 6),
                        // Pasos inactivos
                        ...List.generate(
                          2,
                          (_) => Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE2E8F0),
                                borderRadius: BorderRadius.circular(99),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Widget de Card de Rol ──
class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.role,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.imageUrl,
    required this.isSelected,
    required this.onTap,
  });

  final String role;
  final String title;
  final String subtitle;
  final IconData icon;
  final String imageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.12)
                  : Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Info
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Ícono
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(icon,
                            color: AppColors.primary, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Botón Seleccionar
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Seleccionar',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Imagen cuadrada
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                width: 88,
                height: 88,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 88,
                  height: 88,
                  color: AppColors.primary.withOpacity(0.08),
                  child: Icon(icon,
                      color: AppColors.primary.withOpacity(0.3), size: 32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
