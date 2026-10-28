import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_routes.dart';

class SolicitudDetalleScreen extends StatefulWidget {
  const SolicitudDetalleScreen({super.key});

  @override
  State<SolicitudDetalleScreen> createState() =>
      _SolicitudDetalleScreenState();
}

class _SolicitudDetalleScreenState extends State<SolicitudDetalleScreen> {
  final _contraparteCtrl = TextEditingController();
  final _dniCtrl = TextEditingController();
  int _currentNavIndex = 1; // Casos activo

  // Estados posibles: 'idle' | 'conflict' | 'clear'
  String _verificationState = 'idle';

  @override
  void dispose() {
    _contraparteCtrl.dispose();
    _dniCtrl.dispose();
    super.dispose();
  }

  void _runVerification() {
    // Simula la verificación — alterna entre estados para demo
    setState(() {
      _verificationState =
          _verificationState == 'conflict' ? 'clear' : 'conflict';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCaseImageAndTitle(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCaseDetails(),
                        const SizedBox(height: 20),
                        _buildConflictCheckSection(),
                        const SizedBox(height: 16),
                        if (_verificationState == 'conflict')
                          _buildConflictWarning(),
                        if (_verificationState == 'conflict')
                          const SizedBox(height: 16),
                        _buildSendProposalButton(),
                        if (_verificationState != 'clear')
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Center(
                              child: Text(
                                'La opción de propuesta se habilitará tras una verificación negativa de conflicto.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF94A3B8),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
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
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        ),
        padding:
            const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_rounded,
                  color: Color(0xFF0F172A), size: 22),
            ),
            const Expanded(
              child: Text(
                'Detalle de la Solicitud',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.2,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share_outlined,
                  color: Color(0xFF0F172A), size: 22),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // Imagen 16:9 con overlay y título
  // ─────────────────────────────────────────
  Widget _buildCaseImageAndTitle() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Imagen de fondo
              Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuAKB1urxeftjva6w6-tGMaiJbHDlEc-xMf4_1NMzDO44XeXe23Yb8hEkmDpJ379uWpLnhBx1-UPsch5nTnQIXyed847HSBzGacEUylyQeWTvnDdtRnEU-JW0Sf8UM9jGgmzvlNuFwfQ8dDNnwebqbgspEhhOoztWcTayqR7HlC32tJYfB5w0K2Lsr_OIGJ1Z9oZSZPw5M6Dcutyjgd4bXWzUMqxUo2-UtiwXprJAWeRsHp-cVbzufNRwvqxlYk4qOZihG1nlWUMgDQ',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFF334155),
                  child: const Icon(Icons.gavel_rounded,
                      color: Colors.white38, size: 48),
                ),
              ),

              // Gradiente inferior
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black87, Colors.transparent],
                    stops: [0, 0.65],
                  ),
                ),
              ),

              // Badge + título
              Positioned(
                bottom: 14,
                left: 14,
                right: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'DERECHO DE FAMILIA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Divorcio de Mutuo Acuerdo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.3,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // Card de detalles del caso
  // ─────────────────────────────────────────
  Widget _buildCaseDetails() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiempo
          Row(
            children: [
              const Icon(Icons.schedule_rounded,
                  size: 14, color: AppColors.primary),
              const SizedBox(width: 6),
              const Text(
                'Publicado hace 2 horas',
                style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Descripción
          const Text(
            'El cliente busca asesoría integral para un proceso de divorcio voluntario. Incluye la liquidación de bienes mancomunados (vivienda y cuentas bancarias) y la determinación de la custodia de dos menores de edad.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF475569),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),

          Divider(height: 1, color: Colors.grey.shade200),
          const SizedBox(height: 14),

          // Ubicación + Presupuesto (cuadrícula 2 col)
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'UBICACIÓN',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF94A3B8),
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_rounded,
                            color: AppColors.primary, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          'Madrid, ES',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
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
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.payments_rounded,
                            color: AppColors.primary, size: 18),
                        const SizedBox(width: 4),
                        const Text(
                          '€1.500 - €2.000',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // Sección verificación de conflicto
  // ─────────────────────────────────────────
  Widget _buildConflictCheckSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verificar Conflicto de Interés',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Es obligatorio verificar que no existan conflictos antes de enviar una propuesta.',
          style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
        ),
        const SizedBox(height: 16),

        // Campo nombre contraparte
        _buildInputField(
          label: 'Nombre de la contraparte',
          hint: 'Ej: Maria García López',
          controller: _contraparteCtrl,
        ),
        const SizedBox(height: 12),

        // Campo DNI
        _buildInputField(
          label: 'DNI / NIE de la contraparte',
          hint: 'Ej: 12345678X',
          controller: _dniCtrl,
        ),
        const SizedBox(height: 14),

        // Botón verificar
        SizedBox(
          width: double.infinity,
          height: 46,
          child: ElevatedButton(
            onPressed: _runVerification,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F172A),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Realizar Verificación',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          style: const TextStyle(fontSize: 14, color: Color(0xFF0F172A)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
                fontSize: 13, color: Color(0xFF94A3B8)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  // Tarjeta de conflicto detectado
  // ─────────────────────────────────────────
  Widget _buildConflictWarning() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded,
              color: Colors.red.shade600, size: 22),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Conflicto detectado',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7F1D1D),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Se ha detectado una coincidencia en su base de datos de clientes existentes. De acuerdo al código deontológico, no puede enviar una propuesta para este caso.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFB91C1C),
                    height: 1.4,
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
  // Botón Enviar Propuesta
  // ─────────────────────────────────────────
  Widget _buildSendProposalButton() {
    final bool enabled = _verificationState == 'clear';
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: enabled
            ? () => Navigator.pushNamed(context, AppRoutes.crearPropuesta)
            : null,
        icon: const Icon(Icons.send_rounded, size: 20),
        label: const Text(
          'Enviar Propuesta',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              enabled ? AppColors.primary : const Color(0xFFE2E8F0),
          foregroundColor:
              enabled ? Colors.white : const Color(0xFF94A3B8),
          elevation: enabled ? 3 : 0,
          shadowColor: AppColors.primary.withOpacity(0.3),
          disabledBackgroundColor: const Color(0xFFE2E8F0),
          disabledForegroundColor: const Color(0xFF94A3B8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // Bottom Nav
  // ─────────────────────────────────────────
  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'Inicio', 'route': AppRoutes.homeLawyer},
      {'icon': Icons.gavel_rounded, 'label': 'Casos', 'route': ''},
      {'icon': Icons.chat_bubble_rounded, 'label': 'Mensajes', 'route': AppRoutes.messages},
      {'icon': Icons.person_rounded, 'label': 'Perfil', 'route': AppRoutes.profile},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.93),
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final isActive = _currentNavIndex == i;
              final route = items[i]['route'] as String;
              return GestureDetector(
                onTap: () {
                  if (route.isNotEmpty) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, route, (r) => false);
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
