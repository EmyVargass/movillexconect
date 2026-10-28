import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_routes.dart';

class HomeLawyerScreen extends StatefulWidget {
  const HomeLawyerScreen({super.key});

  @override
  State<HomeLawyerScreen> createState() => _HomeLawyerScreenState();
}

class _HomeLawyerScreenState extends State<HomeLawyerScreen> {
  bool _isAvailable = true;
  int _currentNavIndex = 0; // Inicio activo

  // ── Invitaciones de clientes ──
  final List<Map<String, dynamic>> _invitations = [
    {
      'clientName': 'Juan Pérez',
      'description': 'Divorcio de mutuo acuerdo. Revisión urgente de convenio regulador...',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCQoSs5BSww24Sx2kpVIc4aJvOckOw4Qia6VdNcTDeKKXgnhT667kHIe-EvqWps7OKLfgBQ-iXFI7MQvpeZYDid6nHaaWMfstTn10_C3RiKveVhbtKMhvNy-YrDMVLuaPNwkrQqzSfhNJihmQk06ctCH8cb6XK2QEItguopGN6vghujJTp5sjAVcdcAHDPwliGD54a7JI5eFrKCTsUKVEIHf1QoPWT-wgO9rvXpdc8p74ZdO1LQfRomAt1dYdgQnC7rAENshX1wMAE',
    },
    {
      'clientName': 'Marta Sánchez',
      'description': 'Demanda por despido improcedente. Empresa tecnológica multinacional.',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAbmfneAtt59YVu8cTRr0FcgVoCJVhl-QTgZBHxt5pthgfD9VYmvnWgNgpNKo0EheA12ZtDbEEiJwT29IQaUZthYcScQ7ittW4zSzi-wsJjGAzcQsuyXvV9y7h4SK-SKJpna5n3rijiL-APOyauvmyYXr4nCI1kzXCqgS24I4tGf1IBlYhPLxyp8lYobHRujhP3WkmlkxD9r-qh-edt1ikpY6MFgWad9SX2VYaOEOnClzRUvFhQtroROITlf20y0QAZ6K1EO-5fN4g',
    },
  ];

  // ── Actividad activa ──
  final List<Map<String, dynamic>> _activity = [
    {
      'title': 'Caso #2841 - Civil',
      'subtitle': 'Ricardo Gómez • Próxima audiencia: Mañana',
      'status': 'En curso',
      'statusColor': Colors.green,
      'icon': Icons.gavel_rounded,
      'iconBg': Colors.blue,
    },
    {
      'title': 'Contrato de Arrendamiento',
      'subtitle': 'Elena Ruiz • Enviado hace 2 horas',
      'status': 'Pendiente firma',
      'statusColor': Colors.amber,
      'icon': Icons.description_rounded,
      'iconBg': Colors.amber,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                _buildMetricsSection(),
                _buildAvailabilitySection(),
                _buildInvitationsSection(),
                _buildActiveActivitySection(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ─────────────────────────────────────────
  // Header sticky
  // ─────────────────────────────────────────
  Widget _buildHeader() {
    return SafeArea(
      bottom: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            // Avatar del abogado
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: AppColors.primary.withOpacity(0.2), width: 2),
              ),
              child: ClipOval(
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDjDlL9A8kUH-4WwiGj_OgLcaE9I8w_rLTyPiuels2Ep9XZGMc5vUt0fX4Pnhs-dkTVZWLtjUVN_3nmr6QPTog9mSEEdRLT_SSjyvrIyEqtvO54NqQEqAA48yUz-0iJdHlnDIWothowahSUONQSnYttsGZ7iFsPGCzyy67ww7xQdtka_7PuafMYDQwOOB7QI4LRkYJ51PBPF0S96Qv1LiOJt9PC9i4XE-9OVES5XRWv_cRDWTSH2iXc3gKmwUhGV23zy7KVudWc4fI',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                      Icons.person_rounded,
                      color: Color(0xFF94A3B8)),
                ),
              ),
            ),

            // Título centrado
            const Expanded(
              child: Text(
                'Resumen',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.2,
                ),
              ),
            ),

            // Notificaciones
            Stack(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.notifications_outlined,
                      color: Color(0xFF475569), size: 22),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
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
  // Métricas rápidas del abogado (inspirado en CTA para profesionales de la web)
  // ─────────────────────────────────────────
  Widget _buildMetricsSection() {
    final metrics = [
      {
        'label': 'Casos Activos',
        'value': '8',
        'icon': Icons.gavel_rounded,
        'color': AppColors.primary,
      },
      {
        'label': 'Calificación',
        'value': '4.9 ★',
        'icon': Icons.star_rounded,
        'color': const Color(0xFFF59E0B),
      },
      {
        'label': 'Solicitudes',
        'value': '3 nuevas',
        'icon': Icons.inbox_rounded,
        'color': AppColors.secondary,
      },
      {
        'label': 'Ingresos',
        'value': '€3,200',
        'icon': Icons.payments_rounded,
        'color': const Color(0xFF10B981),
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tu resumen',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.2,
            ),
            itemCount: metrics.length,
            itemBuilder: (_, i) {
              final m = metrics[i];
              final Color color = m['color'] as Color;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(m['icon'] as IconData, color: color, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            m['value'] as String,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            m['label'] as String,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // Toggle disponibilidad
  // ─────────────────────────────────────────
  Widget _buildAvailabilitySection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04), blurRadius: 8),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Estado de Disponibilidad',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _isAvailable ? 'Disponible ahora' : 'No disponible',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _isAvailable
                          ? AppColors.primary
                          : const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: _isAvailable,
              onChanged: (v) => setState(() => _isAvailable = v),
              activeColor: AppColors.primary,
              activeTrackColor: AppColors.primary.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // Sección Nuevas Invitaciones
  // ─────────────────────────────────────────
  Widget _buildInvitationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Nuevas Invitaciones',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: const Text(
                  '3 Nuevas',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: _invitations
                .map((inv) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildInvitationCard(inv),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildInvitationCard(Map<String, dynamic> inv) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04), blurRadius: 8),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contenido izquierdo
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre del cliente
                  Row(
                    children: [
                      const Icon(Icons.person_outline_rounded,
                          color: Color(0xFF94A3B8), size: 16),
                      const SizedBox(width: 6),
                      Text(
                        inv['clientName'] as String,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Descripción del caso
                  Text(
                    inv['description'] as String,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Botones
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 36,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Ver Caso',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 36,
                        height: 36,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF1F5F9),
                            foregroundColor: const Color(0xFF475569),
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Icon(Icons.close_rounded, size: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Imagen del caso
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                inv['image'] as String,
                width: 88,
                height: 88,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 88,
                  height: 88,
                  color: const Color(0xFFE2E8F0),
                  child: const Icon(Icons.gavel_rounded,
                      color: Color(0xFF94A3B8), size: 32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // Actividad Activa
  // ─────────────────────────────────────────
  Widget _buildActiveActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Actividad Activa',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Ver Todo',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: _activity
                .map((act) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _buildActivityCard(act),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> act) {
    final Color iconBg = act['iconBg'] as Color;
    final Color statusColor = act['statusColor'] as Color;

    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04), blurRadius: 8),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBg.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(act['icon'] as IconData,
                  color: iconBg, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          act['title'] as String,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Text(
                          act['status'] as String,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    act['subtitle'] as String,
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right_rounded,
                color: Color(0xFFCBD5E1), size: 20),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // Bottom Nav (5 ítems para abogado)
  // ─────────────────────────────────────────
  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'Inicio', 'route': AppRoutes.homeLawyer},
      {'icon': Icons.work_rounded, 'label': 'Casos', 'route': ''},
      {'icon': Icons.chat_bubble_rounded, 'label': 'Mensajes', 'route': AppRoutes.messages},
      {'icon': Icons.calendar_today_rounded, 'label': 'Agenda', 'route': AppRoutes.activity},
      {'icon': Icons.account_circle_rounded, 'label': 'Perfil', 'route': AppRoutes.profile},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.93),
        border: Border(top: BorderSide(color: Colors.grey.shade100)),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final isActive = _currentNavIndex == i;
              final route = items[i]['route'] as String;
              return GestureDetector(
                onTap: () {
                  if (route.isNotEmpty) {
                    Navigator.pushNamed(context, route);
                  } else {
                    setState(() => _currentNavIndex = i);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primary.withOpacity(0.08)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        items[i]['icon'] as IconData,
                        color: isActive
                            ? AppColors.primary
                            : const Color(0xFF94A3B8),
                        size: 22,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        items[i]['label'] as String,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: isActive
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: isActive
                              ? AppColors.primary
                              : const Color(0xFF94A3B8),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
