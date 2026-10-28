import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_routes.dart';

class HomeClientScreen extends StatefulWidget {
  const HomeClientScreen({super.key});

  @override
  State<HomeClientScreen> createState() => _HomeClientScreenState();
}

class _HomeClientScreenState extends State<HomeClientScreen> {
  int _currentIndex = 0;

  // ── 8 Áreas de práctica (igual que la web) ──
  final List<Map<String, dynamic>> _areas = [
    {
      'label': 'Familia',
      'icon': Icons.family_restroom_rounded,
      'color': AppColors.areaFamilia,
    },
    {
      'label': 'Laboral',
      'icon': Icons.work_rounded,
      'color': AppColors.areaLaboral,
    },
    {
      'label': 'Penal',
      'icon': Icons.gavel_rounded,
      'color': AppColors.areaPenal,
    },
    {
      'label': 'Inmobiliario',
      'icon': Icons.real_estate_agent_rounded,
      'color': AppColors.areaInmobiliario,
    },
    {
      'label': 'Contratos',
      'icon': Icons.description_rounded,
      'color': AppColors.areaContratos,
    },
    {
      'label': 'Accidentes',
      'icon': Icons.car_crash_rounded,
      'color': AppColors.areaAccidentes,
    },
    {
      'label': 'Extranjería',
      'icon': Icons.flight_rounded,
      'color': AppColors.areaExtranjeria,
    },
    {
      'label': 'Mercantil',
      'icon': Icons.storefront_rounded,
      'color': AppColors.areaMercantil,
    },
  ];

  // ── Propuestas recientes ──
  final List<Map<String, dynamic>> _proposals = [
    {
      'name': 'Carlos Méndez',
      'specialty': 'Derecho Civil',
      'rating': '4.9',
      'budget': '150€ / h',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDo1U6LYVZfnZsTrusNpPtbZ0J1JCp5ibJNHptj8fkcuw2ZJmZ5ZcF8MjfPSAQRlAoGz-U0LORJGfx6mXoIV-kP2Z8-gUGMGrdyKulQq-wxJB4nc8xV-RJayLt0_Y4TEQDdVe2M3Tj2rgGsclNIrlDmC5qnxu4gEPmCTcz-KfQ86j8FlKNDcBpi7QrV5q25VLgh67CudlEcSWXqJuP9DOl94din4sEmXgaSa2yoJOJJMyLz1nmcBYxx1jwXfZxp0vBtQhNRF69o2GI',
    },
    {
      'name': 'Elena Ramos',
      'specialty': 'Laboral',
      'rating': '4.8',
      'budget': '450€ Fijo',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDV3hFCm0etMRf51ZwwKkg2oIY_5joPH8arv8J_3JcIwtV3IZzcZS-iwLZGqesFF8kIHdkeDEyIToxEp-DQTiwRcq_GwyhqW4-LGaAsSRbmM2--x5weygh-mTT2sFKETfYhw5iMhIp-Ohb3_-8TeliJcdvcHbgc_D1wacmnP0MFbvZVeJVv2Uhu8GU1kfL4RkkUrnOFw3FR_O31rVqnSi0-_H1RglgIWtlZZp2UpBvqNa9zhUsiDR7w1QW1cQJvWCifrevigbT76i4',
    },
    {
      'name': 'Marcos López',
      'specialty': 'Derecho Penal',
      'rating': '4.7',
      'budget': '200€ / h',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAQ-7XRfIek6NYRCkCuze3oNmJ5D8EReilTGxoKtEjObacFMxwAuH87ivcR5Y6Su98m2wolNVQwILC403yQ9jaJGiFQT-SGB1p7HhoNOSVJE3RY4YM4yzuUSOLRdGK6eN8jnCRQnborP8Jwolo5oYdhb8T0t48EtlQD0KopHF7LaNEIaeStenS9GyMbRNnsoOwlqe26MvK0v_RNlMD8KVaS8ugKBPKZmpCebSGOS6DKjQcffF_Ez-aherbRW-KDqRexb-41QHjdTWg',
    },
  ];

  // ── Actividad activa ──
  final List<Map<String, dynamic>> _activeActivity = [
    {
      'title': 'Divorcio Mutuo Acuerdo',
      'subtitle': 'Abogado: Roberto Díaz',
      'status': 'En curso',
      'statusColor': AppColors.secondary,
      'icon': Icons.gavel_rounded,
      'iconBg': AppColors.areaFamilia,
    },
    {
      'title': 'Revisión Contrato Arriendo',
      'subtitle': 'Esperando tu revisión',
      'status': 'Pendiente firma',
      'statusColor': AppColors.primary,
      'icon': Icons.description_rounded,
      'iconBg': AppColors.areaContratos,
    },
  ];

  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // ── Header Hero (Impacto Web) ──
          _buildHeroHeader(),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              children: [
                _buildPracticeAreasSection(),
                const SizedBox(height: 32),
                _buildProposalsSection(),
                const SizedBox(height: 32),
                _buildHowItWorksSection(),
                const SizedBox(height: 32),
                _buildActivitySection(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ─────────────────────────────────────────
  // Header Hero - Fondo Oscuro Premium (SaaS Style)
  // ─────────────────────────────────────────
  Widget _buildHeroHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.darkHeroBackground,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.darkHeroBackground, AppColors.premiumGradientEnd],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fila superior: Perfil + Campana
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.profile),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundColor: AppColors.glassWhite,
                            backgroundImage: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hola, Emily 👋',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            'LexConecta',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.notifications),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              const Text(
                '¿En qué situación legal\nte encuentras hoy?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 24),

              // Buscador Premium
              Container(
                decoration: BoxDecoration(
                  color: AppColors.glassWhite,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.glassBorder),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchCtrl,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  onSubmitted: (v) =>
                      Navigator.pushNamed(context, AppRoutes.search),
                  decoration: InputDecoration(
                    hintText: 'Busca divorcios, contratos, penal...',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: Colors.white.withOpacity(0.5),
                      size: 20,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // Barra de búsqueda tipo hero de la web
  // ─────────────────────────────────────────
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Encuentra al experto legal\npara tu caso',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
              height: 1.25,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.search),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.search_rounded,
                    color: Color(0xFF94A3B8),
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Área de práctica o especialidad...',
                      style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Buscar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Búsquedas populares
          Wrap(
            spacing: 8,
            children: ['Divorcio', 'Despidos', 'Herencias'].map((tag) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, AppRoutes.search),
                child: Text(
                  tag,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // Acciones rápidas (2 botones)
  // ─────────────────────────────────────────
  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: Row(
        children: [
          // Publicar caso (azul)
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add_box_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Publicar caso',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Describe tu situación',
                      style: TextStyle(color: Colors.white70, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Buscar abogado (blanco)
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoutes.search),
              child: Container(
                padding: const EdgeInsets.all(16),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person_search_rounded,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Buscar abogado',
                      style: TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Directorio experto',
                      style: TextStyle(color: Color(0xFF64748B), fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // Áreas de Práctica Destacadas (8 —igual web)
  // ─────────────────────────────────────────
  Widget _buildPracticeAreasSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Áreas de Práctica',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, AppRoutes.search),
                child: Row(
                  children: const [
                    Text(
                      'Ver todas',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.85,
          ),
          itemCount: _areas.length,
          itemBuilder: (_, i) {
            final area = _areas[i];
            final Color color = area['color'] as Color;
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoutes.search),
              child: Container(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        area['icon'] as IconData,
                        color: color,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      area['label'] as String,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  // Cómo funciona (3 pasos — igual que la web)
  // ─────────────────────────────────────────
  Widget _buildHowItWorksSection() {
    final steps = [
      {
        'step': '1',
        'title': 'Describe tu caso',
        'body':
            'Cuéntanos brevemente qué necesitas. Es gratis, anónimo y sin compromiso.',
        'icon': Icons.edit_note_rounded,
      },
      {
        'step': '2',
        'title': 'Recibe propuestas',
        'body':
            'Abogados especializados te enviarán presupuestos en menos de 24h.',
        'icon': Icons.mark_email_read_rounded,
      },
      {
        'step': '3',
        'title': 'Contrata con confianza',
        'body':
            'Compara perfiles, lee reseñas verificadas y elige al mejor abogado.',
        'icon': Icons.handshake_rounded,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 4),
          child: Text(
            'Cómo funciona LexConecta',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 4, 16, 12),
          child: Text(
            'Tu solución legal en tres simples pasos.',
            style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: steps.map((s) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(
                          s['icon'] as IconData,
                          color: AppColors.primary,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${s['step']}. ${s['title']}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            s['body'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  // Propuestas recientes (scroll horizontal)
  // ─────────────────────────────────────────
  Widget _buildProposalsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Propuestas recientes',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.activityClient),
                child: const Text(
                  'Ver todas',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _proposals.length,
            itemBuilder: (context, index) {
              final p = _proposals[index];
              return Container(
                width: 240,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(14),
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            p['image'] as String,
                            width: 46,
                            height: 46,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 46,
                              height: 46,
                              color: const Color(0xFFE2E8F0),
                              child: const Icon(
                                Icons.person_rounded,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                p['name'] as String,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                p['specialty'] as String,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFEAB308),
                              size: 13,
                            ),
                            Text(
                              p['rating'] as String,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFEAB308),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Divider(color: Colors.grey.shade100, height: 1),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'PRESUPUESTO',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF94A3B8),
                                letterSpacing: 0.8,
                              ),
                            ),
                            Text(
                              p['budget'] as String,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.lawyerProfile,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Revisar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  // Actividad activa
  // ─────────────────────────────────────────
  Widget _buildActivitySection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Actividad activa',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Color(0xFFE2E8F0),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${_activeActivity.length}',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF475569),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.activityClient),
                child: const Text(
                  'Ver todo',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._activeActivity.map(
            (act) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildActivityCard(act),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> act) {
    final Color iconBg = act['iconBg'] as Color;
    final Color statusColor = act['statusColor'] as Color;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.activityClient),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: iconBg.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(act['icon'] as IconData, color: iconBg, size: 22),
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
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Text(
                          act['status'] as String,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    act['subtitle'] as String,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFCBD5E1),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // Bottom Navigation Bar
  // ─────────────────────────────────────────
  Widget _buildBottomNav() {
    final items = [
      {
        'icon': Icons.home_rounded,
        'label': 'Inicio',
        'route': AppRoutes.homeClient,
      },
      {
        'icon': Icons.search_rounded,
        'label': 'Búsqueda',
        'route': AppRoutes.search,
      },
      {
        'icon': Icons.calendar_today_rounded,
        'label': 'Citas',
        'route': AppRoutes.activityClient,
      },
      {
        'icon': Icons.person_rounded,
        'label': 'Perfil',
        'route': AppRoutes.profile,
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.97),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isActive = _currentIndex == index;
              final badge = items[index]['badge'] as int? ?? 0;
              final route = items[index]['route'] as String;
              return GestureDetector(
                onTap: () {
                  if (route.isNotEmpty) {
                    Navigator.pushNamed(context, route);
                  } else {
                    setState(() => _currentIndex = index);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primary.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            items[index]['icon'] as IconData,
                            color: isActive
                                ? AppColors.primary
                                : const Color(0xFF94A3B8),
                            size: 24,
                          ),
                          if (badge > 0)
                            Positioned(
                              top: -4,
                              right: -8,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '$badge',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
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
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
