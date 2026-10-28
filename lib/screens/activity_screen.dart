import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_routes.dart';
import '../services/app_session.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchCtrl = TextEditingController();

  // ── Datos de citas ──
  final List<Map<String, dynamic>> _appointments = [
    {
      'section': 'Hoy, 15 de Octubre',
      'name': 'Dr. Alejandro Ruiz',
      'specialty': 'Especialista en Derecho Civil',
      'time': '10:00 AM',
      'timeBlue': true,
      'type': 'video',
      'typeLabel': 'Video Consulta',
      'subject': 'Asesoría contractual para arrendamiento',
      'primaryAction': 'Unirse a Videollamada',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAwaTeBSt5BJIRGiIJOZC1a77b2iCJal4soncBD-G2Ros0Q7Spi4y5KCteWczRAAl4X57Vs87x46PSDkypw20emNoFuPP6jn-2C6lD7h5HTciCyflQCOiITk5f7sCCW0Z1gz-YYJMUVKa2qBQrPRieI-cLjMNTzCJk5gFWIATgr1rvqucp7DXgB_02q1A5EvI00a4p8sWb4Hnl8aNN22rv3PLerqLEU_CpG7PVw61N5Je97TeqGShv1hcodrD_OiedIgv-HrZCHkiE',
    },
    {
      'section': 'Mañana, 16 de Octubre',
      'name': 'Dra. Lucía Méndez',
      'specialty': 'Derecho Laboral',
      'time': '03:30 PM',
      'timeBlue': false,
      'type': 'presential',
      'typeLabel': 'Oficina Presencial',
      'subject': null,
      'primaryAction': null,
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuA3OTSghCxpUpg7CE3_YRgLnX-y4z9IqzaF5UK9-tijE28l6whuuiR99iUAzIrxSgLZdUzDXzXXkWD1i6Wf17YjMxqfIKm8hv9DbiYccgZTKhSjkh4ZUKpMxl_3HmgMkPFItgEjqsTayNKzdIoK8w4eazUZbKL7FWzdtMOAb9SYx_8mfGK1YAAdrSTw6XK1W11irvKmO0Wd00P5VXnjraP6Hzy0nsLVADbN0saLVGBeKvTXQIdKWmzDVnIHaU2D8rB1pDOmeacENTw',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──
            _buildHeader(),

            // ── Contenido con tabs ──
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Tab Próximas
                  _buildAppointmentList(),
                  // Tab Pasadas
                  _buildEmptyTab(),
                ],
              ),
            ),
          ],
        ),
      ),

      // ── Bottom Nav con FAB central ──
      bottomNavigationBar: _buildBottomNav(),
      // Quitamos el floatingActionButton estándar para usar la nav personalizada
    );
  }

  // ─────────────────────────────────────────
  // Header con tabs
  // ─────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7F8),
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        children: [
          // Fila título
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 16, 0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF0F172A), size: 20),
                ),
                const Expanded(
                  child: Text(
                    'Mi Actividad',
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

          // Tabs
          TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: const Color(0xFF64748B),
            indicatorColor: AppColors.primary,
            indicatorWeight: 2,
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            tabs: const [Tab(text: 'Próximas'), Tab(text: 'Pasadas')],
          ),

          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'Buscar consultas...',
                hintStyle: const TextStyle(
                    fontSize: 14, color: Color(0xFF94A3B8)),
                prefixIcon: const Icon(Icons.search_rounded,
                    color: Color(0xFF94A3B8), size: 20),
                filled: true,
                fillColor: const Color(0xFFE2E8F0).withOpacity(0.6),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                      color: AppColors.primary, width: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // Lista de citas
  // ─────────────────────────────────────────
  Widget _buildAppointmentList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      itemCount: _appointments.length,
      itemBuilder: (context, index) {
        final apt = _appointments[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Etiqueta de sección (fecha)
            Padding(
              padding: EdgeInsets.only(bottom: 10, top: index == 0 ? 0 : 16),
              child: Text(
                apt['section'] as String,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF64748B),
                  letterSpacing: 1.5,
                ),
              ),
            ),
            _buildAppointmentCard(apt),
          ],
        );
      },
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> apt) {
    final isVideo = apt['type'] == 'video';
    final subject = apt['subject'] as String?;
    final primaryAction = apt['primaryAction'] as String?;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Info del abogado
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Foto
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    apt['image'] as String,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 64,
                      height: 64,
                      color: const Color(0xFFE2E8F0),
                      child: const Icon(Icons.person_rounded,
                          color: Color(0xFF94A3B8), size: 30),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        apt['name'] as String,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        apt['specialty'] as String,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Tipo de consulta
                      Row(
                        children: [
                          Icon(
                            isVideo
                                ? Icons.videocam_rounded
                                : Icons.location_on_rounded,
                            size: 15,
                            color: isVideo
                                ? AppColors.primary
                                : const Color(0xFF64748B),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            apt['typeLabel'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isVideo
                                  ? AppColors.primary
                                  : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Hora
                Text(
                  apt['time'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: (apt['timeBlue'] as bool)
                        ? AppColors.primary
                        : const Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
          ),

          // Sección Asunto (solo si existe)
          if (subject != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ASUNTO',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF64748B),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subject,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Botones de acción
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: primaryAction != null
                // Botón único de videollamada
                ? SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.video_call_rounded, size: 20),
                      label: Text(primaryAction),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 3,
                        shadowColor: AppColors.primary.withOpacity(0.3),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                // Dos botones: Ver Detalles + Reprogramar
                : Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 46,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE2E8F0),
                              foregroundColor: const Color(0xFF0F172A),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Ver Detalles',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 46,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              side: const BorderSide(
                                  color: AppColors.primary, width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Reprogramar',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // Tab vacío (Pasadas)
  // ─────────────────────────────────────────
  Widget _buildEmptyTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy_rounded,
              size: 60, color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Text(
            'No tienes consultas pasadas.',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // Bottom Nav con FAB central elevado
  // ─────────────────────────────────────────
  Widget _buildBottomNav() {
    final bool isClient = AppSession.isClient;
    final List<Map<String, dynamic>> items = isClient
        ? [
            {'icon': Icons.home_rounded, 'label': 'Inicio', 'route': AppRoutes.homeClient},
            {'icon': Icons.search_rounded, 'label': 'Búsqueda', 'route': AppRoutes.search},
            {'icon': Icons.calendar_today_rounded, 'label': 'Citas', 'route': ''},
            {'icon': Icons.person_rounded, 'label': 'Perfil', 'route': AppRoutes.profile},
          ]
        : [
            {'icon': Icons.home_rounded, 'label': 'Inicio', 'route': AppRoutes.homeLawyer},
            {'icon': Icons.work_rounded, 'label': 'Casos', 'route': ''},
            {'icon': Icons.chat_bubble_rounded, 'label': 'Mensajes', 'route': AppRoutes.messages},
            {'icon': Icons.calendar_today_rounded, 'label': 'Agenda', 'route': ''},
            {'icon': Icons.person_rounded, 'label': 'Perfil', 'route': AppRoutes.profile},
          ];

    final int activeIndex = isClient ? 2 : 3; // Citas es index 2 para cliente, Agenda index 3 para abogado

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final isActive = i == activeIndex;
              final route = items[i]['route'] as String;
              
              // Evitar el ícono central (FAB) en esta versión simple para mantener consistencia
              return GestureDetector(
                onTap: () {
                  if (route.isNotEmpty) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, route, (r) => false);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      items[i]['icon'] as IconData,
                      color: isActive ? AppColors.primary : const Color(0xFF94A3B8),
                      size: 22,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      items[i]['label'] as String,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: activeIndex == i ? FontWeight.bold : FontWeight.w500,
                        color: activeIndex == i ? AppColors.primary : const Color(0xFF94A3B8),
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

  Widget _navItem(
      IconData icon, String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: active ? AppColors.primary : const Color(0xFF94A3B8),
            size: 22,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight:
                  active ? FontWeight.bold : FontWeight.w500,
              color: active ? AppColors.primary : const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}
