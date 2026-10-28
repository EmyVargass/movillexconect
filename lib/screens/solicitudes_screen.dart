import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_routes.dart';

class SolicitudesScreen extends StatefulWidget {
  const SolicitudesScreen({super.key});

  @override
  State<SolicitudesScreen> createState() => _SolicitudesScreenState();
}

class _SolicitudesScreenState extends State<SolicitudesScreen> {
  final _searchCtrl = TextEditingController();
  int _activeFilter = 2; // "Urgente" activo por defecto
  int _currentNavIndex = 0; // Explorar activo

  final List<Map<String, String>> _filters = [
    {'label': 'Área', 'type': 'dropdown'},
    {'label': 'Jurisdicción', 'type': 'dropdown'},
    {'label': 'Urgente', 'type': 'tag'},
  ];

  final List<Map<String, dynamic>> _cases = [
    {
      'title': 'Divorcio Contencioso',
      'specialty': 'Derecho de Familia',
      'time': 'Hace 2 horas',
      'description':
          'Se requiere representación legal para proceso de divorcio con liquidación de sociedad conyugal y custodia de menores...',
      'location': 'Madrid, España',
      'isNew': true,
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuArJ79Uv209d1yostCwwT4ZDPlwSUpjiPjV2KaOiXSX8D3TGgMscrXdR-2BWmaLQh8InkFx_ySefgYSOXBWhUOOv06VUvb5YB9CrHacMWBO79vjCRx_VbptXy7x5pBuPvU-yhbYmB7STCZz5nPUJEpBX-VBSr1Z6X5DdoG9fEzmHTxciliU6Hcpy3i3g5TT-w_WvOBKv0QcUyBRxm-KmODtm7QJo60c-oBRnpJjSyoIPNahMd1LZ5ECs5YBmhD7kGl5PF5CBJtEyyU',
    },
    {
      'title': 'Revisión de Contrato Mercantil',
      'specialty': 'Derecho Civil',
      'time': 'Hace 5 horas',
      'description':
          'Startup tecnológica busca abogado para revisar contrato de prestación de servicios y cláusulas de confidencialidad...',
      'location': 'Barcelona, España',
      'isNew': false,
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDpVEVRmb0QeUZDbxGpc_WzKLSFo44SdCSIlnc_U-9TFEU2599Mo1SocvTwNk1H1Kzj26eZZdI_LqlDLcCD_JIQ1CefWfAh8GuLbeNARr25t0Of-Iq2h17rJAbRYsLWdOCfMyTvot_XyPkr0xJgHQ1H3aHNe5qS3IQ7OrYvN_LxzZ8O2WyEpoHdiYJmqmsjuyjlbClEDHnyzhnLJwJOVx9yHf874vUtBX0Sevc0ylXbjhJujjHLYxlhkBmWyaxk354AbKAbZz3-omk',
    },
    {
      'title': 'Despido Improcedente',
      'specialty': 'Derecho Laboral',
      'time': 'Hace 1 día',
      'description':
          'Asesoramiento para reclamación de indemnización tras despido disciplinario sin causas justificadas en sector retail...',
      'location': 'Valencia, España',
      'isNew': false,
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuA5gEFVVOGULhXDl1NcRraxLtQr3fZUeOLBcbmINXAvO9G2nJLHSmdNtkVbc9vf-89DQ6m5ufZ_HV1RS3taWlS2qGUp1NtRz2oc4ULO-znrY1k_Vyofb-Ir5Rtrp9S2g71nZLmcSqkkM4bjqEtYwWv7oXzSxWu3zIOkw3wSvPAgw4etyjF3EDpHrDKJMzlR7mYpNTjhDoG625wly-sDdq4nMa2pe_-spRoXBNpTG42SuFiweX3m0lfZelhiiw05drcrwlIv9F5S9KE',
    },
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

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
                _buildSearchAndFilters(),
                _buildCasesList(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ─────────────────────────────────────────
  // Header
  // ─────────────────────────────────────────
  Widget _buildHeader() {
    return SafeArea(
      bottom: false,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
        ),
        child: Row(
          children: [
            // Icono de perfil
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.account_circle_rounded,
                  color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 12),

            // Título + subtítulo
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Solicitudes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.2,
                    ),
                  ),
                  Text(
                    'Abogado verificado',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),

            // Notificaciones
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.notifications_outlined,
                  color: Color(0xFF475569), size: 20),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // Buscador + filtros
  // ─────────────────────────────────────────
  Widget _buildSearchAndFilters() {
    return Column(
      children: [
        // Barra de búsqueda
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.transparent),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 14),
                  child: Icon(Icons.search_rounded,
                      color: Color(0xFF94A3B8), size: 22),
                ),
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    style: const TextStyle(
                        fontSize: 14, color: Color(0xFF0F172A)),
                    decoration: const InputDecoration(
                      hintText: 'Buscar casos legales...',
                      hintStyle: TextStyle(
                          fontSize: 14, color: Color(0xFF94A3B8)),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Chips de filtro
        SizedBox(
          height: 52,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            itemCount: _filters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final isActive = _activeFilter == i;
              final isDropdown = _filters[i]['type'] == 'dropdown';
              return GestureDetector(
                onTap: () => setState(() => _activeFilter = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primary.withOpacity(0.1)
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(
                      color: isActive
                          ? AppColors.primary.withOpacity(0.25)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _filters[i]['label']!,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: isActive
                              ? AppColors.primary
                              : const Color(0xFF475569),
                        ),
                      ),
                      if (isDropdown) ...[
                        const SizedBox(width: 2),
                        Icon(Icons.expand_more_rounded,
                            size: 16,
                            color: isActive
                                ? AppColors.primary
                                : const Color(0xFF64748B)),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  // Lista de tarjetas de casos
  // ─────────────────────────────────────────
  Widget _buildCasesList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Column(
        children: _cases
            .map((c) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildCaseCard(c),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildCaseCard(Map<String, dynamic> c) {
    final bool isNew = c['isNew'] as bool;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen de portada
          SizedBox(
            height: 120,
            width: double.infinity,
            child: Image.network(
              c['image'] as String,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFFE2E8F0),
                child: const Center(
                  child: Icon(Icons.gavel_rounded,
                      color: Color(0xFF94A3B8), size: 36),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título + badge NUEVO
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        c['title'] as String,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    if (isNew) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'NUEVO',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 5),

                // Especialidad + tiempo
                Row(
                  children: [
                    Text(
                      c['specialty'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF334155),
                      ),
                    ),
                    const Text(
                      ' • ',
                      style: TextStyle(color: Color(0xFF94A3B8)),
                    ),
                    Text(
                      c['time'] as String,
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF94A3B8)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Descripción (2 líneas)
                Text(
                  c['description'] as String,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),

                // Separador
                const Divider(height: 1, color: Color(0xFFF8FAFC)),
                const SizedBox(height: 12),

                // Ubicación + botón Ver detalles
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 14, color: Color(0xFF94A3B8)),
                        const SizedBox(width: 3),
                        Text(
                          c['location'] as String,
                          style: const TextStyle(
                              fontSize: 11, color: Color(0xFF94A3B8)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 36,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(
                            context, AppRoutes.solicitudDetalle),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Ver detalles',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // Bottom Nav del abogado
  // ─────────────────────────────────────────
  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.explore_rounded, 'label': 'Explorar', 'route': ''},
      {'icon': Icons.business_center_rounded, 'label': 'Mis Casos', 'route': ''},
      {'icon': Icons.forum_rounded, 'label': 'Mensajes', 'route': AppRoutes.messages},
      {'icon': Icons.person_rounded, 'label': 'Perfil', 'route': AppRoutes.profile},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      items[i]['icon'] as IconData,
                      color: isActive
                          ? AppColors.primary
                          : const Color(0xFF94A3B8),
                      size: 24,
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
