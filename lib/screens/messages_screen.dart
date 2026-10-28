import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_routes.dart';
import '../services/app_session.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _segmentIndex = 0; // 0=Todos, 1=Abogados, 2=Clientes
  int _currentNavIndex = 2; // Mensajes activo
  final _searchCtrl = TextEditingController();

  final List<Map<String, dynamic>> _conversations = [
    {
      'name': 'Lic. Alejandro Ruiz',
      'message':
          'Adjunto el contrato de arrendamiento revisado. Por favor, échale un vistazo antes de la firma.',
      'time': '14:20',
      'timeBlue': true,
      'unread': true,
      'online': true,
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBZbV3dv-5OCHeLa2sx_kJkjml6ZT86VJWXwPSv_JHSnIl846QVaSemF_EYfPSYAwTmrqa5ZyM_lSsytGeZ4ygnGynmMPhNvUVEYC2A9ThlqP4dp2OmxcKhLeVakBVXWyPbfOIYZ2hexupmZpeVfDW-Tu_l4lxJa5ikgoHueGeSfzydMD4zT3m-1ePW0p2yTmyAR2qnjB2-Xjg0Qb3IcReCCh_rxqiFja0rq7ggH-bTUpHJirx5fcdfekLxxl-3FMOQRtwJghs-2uY',
    },
    {
      'name': 'Dra. Elena Martínez',
      'message':
          '¿Podemos agendar una llamada para mañana a las 10:00 AM para discutir los honorarios?',
      'time': 'Ayer',
      'timeBlue': false,
      'unread': false,
      'online': false,
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD0DYzBC1dHTH9yJJ0e58-3jv7wOH7xNYL9SaCpoqkZPR11awkN8NrMfPd-fy5ka1E3gQC2aqOxSQks3Xq1mLD19OzL7EAnBIJDLCYU5Jhd2foUbXZ_kLqEB2wN5RnCFIalMES1uKoKUHDhZWsU_ZKVnR3Gc4jqb8lrm0eTluHUsh_FNuPrGzj50MJJtGIG_dIf6BiH3dnThVXCOw6dLZrAzu725EUHRRf9m4BfN2FVFhfY1s54AW58QxjWKmFdjRgkeov_bf7xiYY',
    },
    {
      'name': 'Dr. Roberto Valdés',
      'message':
          'Los documentos de la notaría están listos. Solo falta tu firma digital.',
      'time': 'Lun',
      'timeBlue': true,
      'unread': true,
      'online': true,
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuA5cRcqrj7TuDasPNbC6F4YanWezyMAVHgolOh0rsTpYIAbyP2VBhW9qroCTTd8jMEy48l1saWhnTQWOkLc7s9xsqygrbaH_4NxsQWEEVIyNkhpJeIvuN8nqjIdpp1PG5xU2CWq54dEwDcjDksX94I58dd5JcIHX_54fHATHKMB3zhL81LDJRGKyEoq6T8Vp_FrFQKo4um3Q6Ax3tfgnuedfazZixw50jGWexoacKRQUxAEkByZtw8p_pmyYhPItoAyF_OMRPMOYSc',
    },
    {
      'name': 'Lic. Sofía García',
      'message':
          'Gracias por la información enviada. Estaré pendiente de las novedades del caso.',
      'time': 'Dom',
      'timeBlue': false,
      'unread': false,
      'online': false,
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuB1cgIdKNXv-NCFOB_YL3Z3c1slRVjaINXbNou1iiTyUIhHzsJrIny1w5B08nLqpTe4_R9HZRzwG9sSn7CvcvvaKUO0tfp_CiN8rHoq6TLkYD9Otmd6lO-8gYj9ts-DYx_TvY_vRuEWNYDhwV5cv6rWvD89xGDtOG2Xk2XeCwLUb71ZzqDOKvu3masIrKh8x1UyI5oCCFPp16zNl_Owr28L7VjUwcYEw4JgUpC1M39R_EdOtoJ99DbKE28quCeyYcZeB8T4uLMs66c',
    },
    {
      'name': 'Dr. Juan Pérez',
      'message':
          'Revisaré los términos de la demanda hoy mismo y te enviaré mis comentarios.',
      'time': '15 May',
      'timeBlue': false,
      'unread': false,
      'online': false,
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAlQ0sW-I5nrDzLYP9b9Eeqv0Yhu190yUpeDySLPBWHiPDYNqTasBng8q4CoY4AMT7wGLoiAlJ5_lDbTahs53KrSYg3SW8DlOoUA1kLsRwogfIYFaRpXiNYuzHRUgHiiQmUqlj8L0TcodkgU1KW-3pUQDmmM25n2ubMYdtx2rel3DB3GjiXQ_vrQVNJCGeQma99uMOHIH9GFU8urlAhp0yg2o4wHZ_7Q1xYSZsZR4HeOGjDn2e5b8Sgw-kuJ64EHVRlndzKG9RcEvQ',
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: _conversations.length,
              itemBuilder: (_, i) =>
                  _buildConversationTile(_conversations[i]),
            ),
          ),
        ],
      ),
      // FAB redactar
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 72),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 5,
          child: const Icon(Icons.edit_rounded, size: 24),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ─────────────────────────────────────────
  // Header con título grande + segmented control
  // ─────────────────────────────────────────
  Widget _buildHeader() {
    return SafeArea(
      bottom: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.93),
          border:
              Border(bottom: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fila atrás + editar
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.chevron_left_rounded,
                        size: 28, color: AppColors.primary),
                    label: const Text(
                      'Atrás',
                      style: TextStyle(
                          color: AppColors.primary, fontSize: 17),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit_square,
                        color: AppColors.primary, size: 22),
                  ),
                ],
              ),
            ),

            // Título grande
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 2, 16, 10),
              child: Text(
                'Mensajes',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
              ),
            ),

            // Buscador
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchCtrl,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Buscar mensajes',
                  hintStyle: const TextStyle(
                      fontSize: 14, color: Color(0xFF94A3B8)),
                  prefixIcon: const Icon(Icons.search_rounded,
                      color: Color(0xFF94A3B8), size: 20),
                  filled: true,
                  fillColor: const Color(0xFFF1F5F9),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Segmented control: Todos / Abogados / Clientes
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Container(
                height: 36,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    _segmentBtn('Todos', 0),
                    _segmentBtn('Abogados', 1),
                    _segmentBtn('Clientes', 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _segmentBtn(String label, int index) {
    final isActive = _segmentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _segmentIndex = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    )
                  ]
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight:
                  isActive ? FontWeight.w600 : FontWeight.normal,
              color: isActive
                  ? const Color(0xFF0F172A)
                  : const Color(0xFF64748B),
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // Tile de conversación — iOS style con 2 líneas
  // ─────────────────────────────────────────
  Widget _buildConversationTile(Map<String, dynamic> conv) {
    final bool unread = conv['unread'] as bool;
    final bool online = conv['online'] as bool;
    final bool timeBlue = conv['timeBlue'] as bool;

    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRoutes.chat),
      splashColor: Colors.grey.shade100,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar + indicador online
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xFFE2E8F0),
                  backgroundImage:
                      NetworkImage(conv['image'] as String),
                  onBackgroundImageError: (_, __) {},
                ),
                if (online)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),

            // Contenido + separador
            Expanded(
              child: Column(
                children: [
                  // Nombre + hora
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          conv['name'] as String,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      Text(
                        conv['time'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: timeBlue
                              ? FontWeight.w600
                              : FontWeight.normal,
                          color: timeBlue
                              ? AppColors.primary
                              : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),

                  // Mensaje (2 líneas) + chevron
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          conv['message'] as String,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: unread
                                ? const Color(0xFF0F172A)
                                : const Color(0xFF64748B),
                            fontWeight: unread
                                ? FontWeight.w500
                                : FontWeight.normal,
                            height: 1.35,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Icon(Icons.chevron_right_rounded,
                            color: Color(0xFFCBD5E1), size: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Separador
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    color: Colors.grey.shade100,
                  ),
                ],
              ),
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
    final bool isClient = AppSession.isClient;
    final List<Map<String, dynamic>> items = isClient
        ? [
            {'icon': Icons.home_rounded, 'label': 'Inicio', 'route': AppRoutes.homeClient},
            {'icon': Icons.search_rounded, 'label': 'Búsqueda', 'route': AppRoutes.search},
            {'icon': Icons.calendar_today_rounded, 'label': 'Citas', 'route': AppRoutes.activityClient},
            {'icon': Icons.person_rounded, 'label': 'Perfil', 'route': AppRoutes.profile},
          ]
        : [
            {'icon': Icons.home_rounded, 'label': 'Inicio', 'route': AppRoutes.homeLawyer},
            {'icon': Icons.work_rounded, 'label': 'Casos', 'route': ''},
            {'icon': Icons.chat_bubble_rounded, 'label': 'Mensajes', 'route': ''},
            {'icon': Icons.calendar_today_rounded, 'label': 'Agenda', 'route': AppRoutes.activity},
            {'icon': Icons.person_rounded, 'label': 'Perfil', 'route': AppRoutes.profile},
          ];

    final int activeIndex = isClient ? -1 : 2; // Mensajes es activo solo para abogado index 2

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.93),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final isActive = i == activeIndex;
              final route = items[i]['route'] as String;
              return GestureDetector(
                onTap: () {
                  if (route.isNotEmpty) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, route, (r) => false);
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      items[i]['icon'] as IconData,
                      size: 26,
                      color: isActive
                          ? AppColors.primary
                          : const Color(0xFF94A3B8),
                    ),
                    const SizedBox(height: 3),
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
