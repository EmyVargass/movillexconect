import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_routes.dart';

class ActivityClientScreen extends StatefulWidget {
  const ActivityClientScreen({super.key});

  @override
  State<ActivityClientScreen> createState() => _ActivityClientScreenState();
}

class _ActivityClientScreenState extends State<ActivityClientScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // ── Propuestas recibidas ──
  final List<Map<String, dynamic>> _proposals = [
    {
      'name': 'Dr. Alejandro Ruiz',
      'rating': '4.9',
      'status': 'Pendiente',
      'statusColor': Colors.amber,
      'preview':
          '"Tengo amplia experiencia en litigios civiles. Puedo revisar su contrato de arrendamiento y ofrecerle una estrategia sólida..."',
      'fee': '\$150.000',
      'isAccepted': false,
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAwaTeBSt5BJIRGiIJOZC1a77b2iCJal4soncBD-G2Ros0Q7Spi4y5KCteWczRAAl4X57Vs87x46PSDkypw20emNoFuPP6jn-2C6lD7h5HTciCyflQCOiITk5f7sCCW0Z1gz-YYJMUVKa2qBQrPRieI-cLjMNTzCJk5gFWIATgr1rvqucp7DXgB_02q1A5EvI00a4p8sWb4Hnl8aNN22rv3PLerqLEU_CpG7PVw61N5Je97TeqGShv1hcodrD_OiedIgv-HrZCHkiE',
    },
    {
      'name': 'Dra. Lucía Méndez',
      'rating': '4.8',
      'status': 'Aceptada',
      'statusColor': Colors.green,
      'preview': 'Esta propuesta fue convertida en contratación.',
      'fee': null,
      'isAccepted': true,
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuA3OTSghCxpUpg7CE3_YRgLnX-y4z9IqzaF5UK9-tijE28l6whuuiR99iUAzIrxSgLZdUzDXzXXkWD1i6Wf17YjMxqfIKm8hv9DbiYccgZTKhSjkh4ZUKpMxl_3HmgMkPFItgEjqsTayNKzdIoK8w4eazUZbKL7FWzdtMOAb9SYx_8mfGK1YAAdrSTw6XK1W11irvKmO0Wd00P5VXnjraP6Hzy0nsLVADbN0saLVGBeKvTXQIdKWmzDVnIHaU2D8rB1pDOmeacENTw',
    },
  ];

  // ── Historial de contrataciones ──
  final List<Map<String, dynamic>> _hirings = [
    {
      'title': 'Divorcio de Mutuo Acuerdo',
      'status': 'En curso',
      'statusColor': Colors.blue,
      'lawyerName': 'Dr. Alejandro Ruiz',
      'date': 'Iniciado: 12 Oct',
      'icon': Icons.gavel_rounded,
      'iconColor': AppColors.primary,
      'finished': false,
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAwaTeBSt5BJIRGiIJOZC1a77b2iCJal4soncBD-G2Ros0Q7Spi4y5KCteWczRAAl4X57Vs87x46PSDkypw20emNoFuPP6jn-2C6lD7h5HTciCyflQCOiITk5f7sCCW0Z1gz-YYJMUVKa2qBQrPRieI-cLjMNTzCJk5gFWIATgr1rvqucp7DXgB_02q1A5EvI00a4p8sWb4Hnl8aNN22rv3PLerqLEU_CpG7PVw61N5Je97TeqGShv1hcodrD_OiedIgv-HrZCHkiE',
    },
    {
      'title': 'Revisión de Contrato',
      'status': 'Finalizado',
      'statusColor': const Color(0xFF64748B),
      'lawyerName': 'Dra. Lucía Méndez',
      'date': '05 Oct',
      'icon': Icons.description_rounded,
      'iconColor': const Color(0xFF94A3B8),
      'finished': true,
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildProposalsTab(),
                  _buildHiringsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ─────────────────────────────────────────
  // Header con tabs
  // ─────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        children: [
          // Fila título
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 6, 16, 0),
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
                      fontSize: 17,
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

          // TabBar
          TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: const Color(0xFF64748B),
            indicatorColor: AppColors.primary,
            indicatorWeight: 2,
            labelStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'Propuestas'),
              Tab(text: 'Contrataciones'),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // Tab: Propuestas
  // ─────────────────────────────────────────
  Widget _buildProposalsTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      children: [
        // Encabezado sección con badge
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'RECIBIDAS RECIENTEMENTE',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(0xFF64748B),
                letterSpacing: 1.2,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(99),
              ),
              child: const Text(
                '3 Nuevas',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        ..._proposals.map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildProposalCard(p),
            )),
      ],
    );
  }

  Widget _buildProposalCard(Map<String, dynamic> p) {
    final Color statusColor = p['statusColor'] as Color;
    final bool isAccepted = p['isAccepted'] as bool;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fila avatar + nombre + badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: const Color(0xFFE2E8F0),
                      backgroundImage: NetworkImage(p['image'] as String),
                      onBackgroundImageError: (_, __) {},
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p['name'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded,
                                color: Color(0xFFF59E0B), size: 14),
                            const SizedBox(width: 2),
                            Text(
                              p['rating'] as String,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF59E0B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                // Badge estado
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    p['status'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            if (!isAccepted) ...[
              // Preview de propuesta
              Text(
                p['preview'] as String,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),

              // Honorarios + botones
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'HONORARIOS',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF94A3B8),
                          letterSpacing: 0.8,
                        ),
                      ),
                      Text(
                        p['fee'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Botón Chat
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, AppRoutes.chat),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 9),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2E8F0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Chat',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF334155),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Ver Propuesta
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 9),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Ver Propuesta',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ] else ...[
              // Propuesta aceptada
              Divider(color: Colors.grey.shade100, height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    p['preview'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Ver Detalles',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // Tab: Contrataciones
  // ─────────────────────────────────────────
  Widget _buildHiringsTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      children: [
        const Text(
          'HISTORIAL DE CONTRATACIONES',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Color(0xFF64748B),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        ..._hirings.map((h) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildHiringCard(h),
            )),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            'Has llegado al final de tu actividad reciente.',
            style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
          ),
        ),
      ],
    );
  }

  Widget _buildHiringCard(Map<String, dynamic> h) {
    final Color statusColor = h['statusColor'] as Color;
    final bool finished = h['finished'] as bool;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título + badge
            Row(
              children: [
                Icon(h['icon'] as IconData,
                    color: h['iconColor'] as Color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    h['title'] as String,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    h['status'] as String,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Mini avatar + abogado + fecha
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: const Color(0xFFE2E8F0),
                  backgroundImage: NetworkImage(h['image'] as String),
                  onBackgroundImageError: (_, __) {},
                ),
                const SizedBox(width: 8),
                Text(
                  h['lawyerName'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF334155),
                  ),
                ),
                const SizedBox(width: 6),
                Text('•',
                    style: TextStyle(color: Colors.grey.shade300)),
                const SizedBox(width: 6),
                Text(
                  h['date'] as String,
                  style: const TextStyle(
                      fontSize: 11, color: Color(0xFF94A3B8)),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Botones de acción
            finished
                ? SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.star_rate_rounded,
                          size: 18),
                      label: const Text('Calificar Servicio'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.primary.withOpacity(0.1),
                        foregroundColor: AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE2E8F0),
                              foregroundColor: const Color(0xFF334155),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Documentos',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pushNamed(
                                context, AppRoutes.messages),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Mensajes',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // Bottom Nav con FAB central elevado
  // ─────────────────────────────────────────
  Widget _buildBottomNav() {
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
            children: [
              _navItem(Icons.explore_rounded, 'Explorar', false,
                  () => Navigator.pushNamed(context, AppRoutes.search)),
              _navItem(Icons.history_rounded, 'Actividad', true, () {}),

              // FAB central
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 52,
                  height: 52,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add_rounded,
                      color: Colors.white, size: 30),
                ),
              ),

              _navItem(Icons.chat_bubble_rounded, 'Mensajes', false,
                  () => Navigator.pushNamed(context, AppRoutes.messages)),
              _navItem(Icons.person_rounded, 'Perfil', false,
                  () => Navigator.pushNamed(context, AppRoutes.profile)),
            ],
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
          Icon(icon,
              color: active ? AppColors.primary : const Color(0xFF94A3B8),
              size: 22),
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
