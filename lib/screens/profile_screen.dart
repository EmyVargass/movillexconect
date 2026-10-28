import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_routes.dart';
import '../services/app_session.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isAvailable = true;
  int _currentNavIndex = 3; // Perfil activo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: Column(
        children: [
          // ── Header ──
          SafeArea(
            bottom: false,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF6F7F8),
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_rounded,
                        color: Color(0xFF0F172A)),
                  ),
                  const Expanded(
                    child: Text(
                      'Mi Perfil',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),

          // ── Contenido scrollable ──
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                // ── Sección Avatar y datos ──
                _buildProfileHeader(),

                const SizedBox(height: 8),

                // ── Toggle Disponibilidad (Solo Abogados) ──
                if (AppSession.isLawyer) _buildAvailabilityToggle(),

                const SizedBox(height: 16),

                // ── Grupos de menú ──
                _buildMenuGroup(
                  title: 'Cuenta y Seguridad',
                  items: [
                    _MenuItem(
                      icon: Icons.person_rounded,
                      label: 'Editar Perfil',
                      onTap: () {},
                    ),
                    if (AppSession.isClient)
                      _MenuItem(
                        icon: Icons.history_rounded,
                        label: 'Mis Casos',
                        onTap: () {},
                      ),
                    _MenuItem(
                      icon: Icons.payments_rounded,
                      label: 'Métodos de Pago',
                      onTap: () {},
                    ),
                    if (AppSession.isLawyer)
                      _MenuItem(
                        icon: Icons.description_rounded,
                        label: 'Documentos',
                        onTap: () {},
                        isLast: true,
                      )
                    else
                      _MenuItem(
                        icon: Icons.security_rounded,
                        label: 'Privacidad',
                        onTap: () {},
                        isLast: true,
                      ),
                  ],
                ),

                const SizedBox(height: 20),

                _buildMenuGroup(
                  title: 'Preferencias',
                  items: [
                    _MenuItem(
                      icon: Icons.settings_rounded,
                      label: 'Configuración',
                      onTap: () => Navigator.pushNamed(
                          context, AppRoutes.settings),
                    ),
                    _MenuItem(
                      icon: Icons.help_rounded,
                      label: 'Centro de Ayuda',
                      onTap: () {},
                      isLast: true,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ── Botón Cerrar Sesión ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      AppSession.clear();
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.welcome, (r) => false);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout_rounded,
                              color: Colors.red, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Cerrar Sesión',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // ── Bottom Navigation Bar ──
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ─────────────────────────────────────────
  // Header de perfil
  // ─────────────────────────────────────────
  Widget _buildProfileHeader() {
    final isLawyer = AppSession.isLawyer;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          // Avatar con botón editar
          Stack(
            children: [
              CircleAvatar(
                radius: 56,
                backgroundColor: const Color(0xFFE2E8F0),
                backgroundImage: NetworkImage(
                  isLawyer
                      ? 'https://lh3.googleusercontent.com/aida-public/AB6AXuAQD54d0RvtwBD_AIx-M_F2EGvEov-zJo7qQTHPU-0PXvkodbGBBdB0b_fdIYU65lBx9aSJLerqA9Ji5QOl5BXlfIjL_M9m1PG2HwcI8kvJZXVMCwB5NJLlfaVuhX2aXvg7gGV9z31WinL3QexLnAjmqPpurBseWB79r5I1Ys7zXpQvNOSwdWZhz_ayXQUupjX66VudEincl4U7QhZUte_SToRa5ssYHxrpQm2QNzG2Tv_Q1RKVeX9iIT_6j_JxpbMV7VstgGriin0' // Foto abogado
                      : 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png', // Avatar genérico cliente
                ),
                child: null,
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.edit_rounded,
                        color: Colors.white, size: 16),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Nombre
          Text(
            isLawyer ? 'Carlos Rodríguez' : 'Usuario Invitado',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
              letterSpacing: -0.3,
            ),
          ),

          const SizedBox(height: 8),

          // Badge rol
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: (isLawyer ? AppColors.primary : AppColors.secondary)
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(isLawyer ? Icons.gavel_rounded : Icons.person_rounded,
                    color: isLawyer ? AppColors.primary : AppColors.secondary,
                    size: 13),
                const SizedBox(width: 5),
                Text(
                  isLawyer ? 'ABOGADO COLEGIADO' : 'CLIENTE VERIFICADO',
                  style: TextStyle(
                    color: isLawyer ? AppColors.primary : AppColors.secondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Ubicación y especialidad
          Text(
            isLawyer
                ? 'Madrid, España • Especialista en Civil'
                : 'Miembro desde 2024',
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // Toggle Disponibilidad
  // ─────────────────────────────────────────
  Widget _buildAvailabilityToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            // Texto
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Disponibilidad',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Activa para recibir nuevas consultas',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),

            // Switch
            Switch(
              value: _isAvailable,
              onChanged: (val) => setState(() => _isAvailable = val),
              activeColor: AppColors.primary,
              activeTrackColor: AppColors.primary.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // Grupo de menú
  // ─────────────────────────────────────────
  Widget _buildMenuGroup({
    required String title,
    required List<_MenuItem> items,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título sección
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(0xFF64748B),
                letterSpacing: 1.5,
              ),
            ),
          ),

          // Contenedor cards
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: items.asMap().entries.map((entry) {
                final isLast = entry.value.isLast;
                return Column(
                  children: [
                    InkWell(
                      onTap: entry.value.onTap,
                      borderRadius: BorderRadius.vertical(
                        top: entry.key == 0
                            ? const Radius.circular(16)
                            : Radius.zero,
                        bottom: isLast
                            ? const Radius.circular(16)
                            : Radius.zero,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        child: Row(
                          children: [
                            Icon(entry.value.icon,
                                color: AppColors.primary, size: 22),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                entry.value.label,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                            ),
                            Icon(Icons.chevron_right_rounded,
                                color: Colors.grey.shade400, size: 20),
                          ],
                        ),
                      ),
                    ),
                    if (!isLast)
                      Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey.shade100,
                          indent: 52),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // Bottom Navigation Bar
  // ─────────────────────────────────────────
  Widget _buildBottomNav() {
    final bool isClient = AppSession.isClient;
    
    // Configuración de items según el rol
    final List<Map<String, dynamic>> items = isClient
        ? [
            {'icon': Icons.home_rounded, 'label': 'Inicio', 'route': AppRoutes.homeClient},
            {'icon': Icons.search_rounded, 'label': 'Búsqueda', 'route': AppRoutes.search},
            {'icon': Icons.calendar_today_rounded, 'label': 'Citas', 'route': AppRoutes.activityClient},
            {'icon': Icons.person_rounded, 'label': 'Perfil', 'route': ''},
          ]
        : [
            {'icon': Icons.home_rounded, 'label': 'Inicio', 'route': AppRoutes.homeLawyer},
            {'icon': Icons.work_rounded, 'label': 'Casos', 'route': ''}, // TODO: Pantalla casos abogado
            {'icon': Icons.chat_bubble_rounded, 'label': 'Mensajes', 'route': AppRoutes.messages},
            {'icon': Icons.calendar_today_rounded, 'label': 'Agenda', 'route': AppRoutes.activity},
            {'icon': Icons.person_rounded, 'label': 'Perfil', 'route': ''},
          ];

    final int profileIndex = isClient ? 3 : 4;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isActive = index == profileIndex; // Perfil es el último
              return GestureDetector(
                onTap: () {
                  final route = items[index]['route'] as String;
                  if (route.isNotEmpty) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, route, (r) => false);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      items[index]['icon'] as IconData,
                      color: isActive
                          ? AppColors.primary
                          : const Color(0xFF94A3B8),
                      size: 22,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      items[index]['label'] as String,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isActive
                            ? AppColors.primary
                            : const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ── Modelo simple para items de menú ──
class _MenuItem {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isLast;
}
