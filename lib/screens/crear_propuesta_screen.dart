import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CrearPropuestaScreen extends StatefulWidget {
  const CrearPropuestaScreen({super.key});

  @override
  State<CrearPropuestaScreen> createState() => _CrearPropuestaScreenState();
}

class _CrearPropuestaScreenState extends State<CrearPropuestaScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _modeloPrecio;
  final _montoCtrl = TextEditingController();
  final _plazoCtrl = TextEditingController();
  final _alcanceCtrl = TextEditingController();
  final _terminosCtrl = TextEditingController();

  final List<Map<String, String>> _modelos = [
    {'value': 'fijo', 'label': 'Precio fijo'},
    {'value': 'hora', 'label': 'Por hora'},
    {'value': 'mixto', 'label': 'Híbrido'},
  ];

  @override
  void dispose() {
    _montoCtrl.dispose();
    _plazoCtrl.dispose();
    _alcanceCtrl.dispose();
    _terminosCtrl.dispose();
    super.dispose();
  }

  void _submitProposal() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Propuesta enviada exitosamente'),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCaseSummary(),
                    const SizedBox(height: 24),
                    _buildFormSection(),
                    const SizedBox(height: 20),
                    _buildDisclaimerBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: _buildFooter(),
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
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF0F172A), size: 20),
            ),
            const Expanded(
              child: Text(
                'Crear Propuesta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.2,
                ),
              ),
            ),
            // Spacer igual al iconbutton para centrar
            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // Resumen del caso (referencia)
  // ─────────────────────────────────────────
  Widget _buildCaseSummary() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: AppColors.primary.withOpacity(0.12)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CASO #2409',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Asesoría Civil: Contrato de Arrendamiento',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Cliente: Inmobiliaria del Norte S.A.',
                  style: TextStyle(
                      fontSize: 12, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // Sección de formulario
  // ─────────────────────────────────────────
  Widget _buildFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título sección
        Row(
          children: const [
            Icon(Icons.description_rounded,
                color: AppColors.primary, size: 20),
            SizedBox(width: 8),
            Text(
              'Detalles de la Propuesta',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // 1. Modelo de precio (dropdown)
        _buildFieldLabel('Modelo de precio'),
        const SizedBox(height: 6),
        Container(
          decoration: _fieldDecoration(),
          child: DropdownButtonFormField<String>(
            value: _modeloPrecio,
            hint: const Text(
              'Seleccionar modelo...',
              style: TextStyle(
                  fontSize: 14, color: Color(0xFF94A3B8)),
            ),
            icon: const Icon(Icons.expand_more_rounded,
                color: Color(0xFF64748B)),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            ),
            items: _modelos
                .map((m) => DropdownMenuItem<String>(
                      value: m['value'],
                      child: Text(
                        m['label']!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (v) => setState(() => _modeloPrecio = v),
            validator: (v) => v == null ? 'Selecciona un modelo' : null,
          ),
        ),
        const SizedBox(height: 14),

        // 2. Monto estimado
        _buildFieldLabel('Monto estimado (\$)'),
        const SizedBox(height: 6),
        Container(
          decoration: _fieldDecoration(),
          child: TextFormField(
            controller: _montoCtrl,
            keyboardType: TextInputType.number,
            style: const TextStyle(
                fontSize: 14, color: Color(0xFF0F172A)),
            decoration: const InputDecoration(
              hintText: '0.00',
              hintStyle:
                  TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
              prefixText: '\$  ',
              prefixStyle: TextStyle(
                  fontSize: 14, color: Color(0xFF64748B)),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            ),
            validator: (v) => (v == null || v.isEmpty)
                ? 'Ingresa el monto estimado'
                : null,
          ),
        ),
        const SizedBox(height: 14),

        // 3. Plazo estimado
        _buildFieldLabel('Plazo estimado'),
        const SizedBox(height: 6),
        Container(
          decoration: _fieldDecoration(),
          child: TextFormField(
            controller: _plazoCtrl,
            style: const TextStyle(
                fontSize: 14, color: Color(0xFF0F172A)),
            decoration: const InputDecoration(
              hintText: 'Ej: 15 días hábiles',
              hintStyle:
                  TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
              prefixIcon: Icon(Icons.calendar_today_rounded,
                  color: Color(0xFF64748B), size: 18),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 4, vertical: 13),
            ),
            validator: (v) =>
                (v == null || v.isEmpty) ? 'Indica el plazo' : null,
          ),
        ),
        const SizedBox(height: 14),

        // 4. Alcance del trabajo
        _buildFieldLabel('Alcance del trabajo'),
        const SizedBox(height: 6),
        Container(
          decoration: _fieldDecoration(),
          child: TextFormField(
            controller: _alcanceCtrl,
            maxLines: 4,
            style: const TextStyle(
                fontSize: 14, color: Color(0xFF0F172A)),
            decoration: const InputDecoration(
              hintText:
                  'Describe detalladamente las tareas, entregables y etapas del proceso legal...',
              hintStyle: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF94A3B8),
                  height: 1.5),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(14),
            ),
            validator: (v) => (v == null || v.isEmpty)
                ? 'Describe el alcance del trabajo'
                : null,
          ),
        ),
        const SizedBox(height: 14),

        // 5. Términos y condiciones
        _buildFieldLabel('Términos y condiciones'),
        const SizedBox(height: 6),
        Container(
          decoration: _fieldDecoration(),
          child: TextFormField(
            controller: _terminosCtrl,
            maxLines: 3,
            style: const TextStyle(
                fontSize: 14, color: Color(0xFF0F172A)),
            decoration: const InputDecoration(
              hintText:
                  'Especifica condiciones de pago, gastos reembolsables o exclusiones...',
              hintStyle: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF94A3B8),
                  height: 1.5),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xFF334155),
        ),
      ),
    );
  }

  BoxDecoration _fieldDecoration() {
    return BoxDecoration(
      color: const Color(0xFFF8FAFC),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE2E8F0)),
    );
  }

  // ─────────────────────────────────────────
  // Aviso de confidencialidad
  // ─────────────────────────────────────────
  Widget _buildDisclaimerBox() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.amber.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded,
              color: Colors.amber.shade700, size: 20),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Al enviar esta propuesta, te comprometes a mantener la confidencialidad de la información compartida por el cliente.',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF78350F),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // Footer fijo con botón Enviar
  // ─────────────────────────────────────────
  Widget _buildFooter() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: _submitProposal,
              icon: const Text(
                'Enviar Propuesta',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              label: const Icon(Icons.send_rounded, size: 18),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor: AppColors.primary.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
