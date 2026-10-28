import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_routes.dart';

class LawyerProfileScreen extends StatefulWidget {
  const LawyerProfileScreen({super.key});

  @override
  State<LawyerProfileScreen> createState() => _LawyerProfileScreenState();
}

class _LawyerProfileScreenState extends State<LawyerProfileScreen> {
  bool _isSaved = false;

  final List<Map<String, dynamic>> _reviews = [
    {
      'name': 'María González',
      'rating': 5,
      'date': 'Hace 2 semanas',
      'comment': 'Excelente profesional. Resolvió mi caso con mucha eficiencia y me mantuvo informada en todo momento.',
    },
    {
      'name': 'Carlos Rodríguez',
      'rating': 5,
      'date': 'Hace 1 mes',
      'comment': 'Muy recomendado. Trató mi caso laboral con gran dedicación. Los resultados superaron mis expectativas.',
    },
    {
      'name': 'Ana Martínez',
      'rating': 4,
      'date': 'Hace 2 meses',
      'comment': 'Buen abogado, muy puntual y profesional. El único detalle fue la demora en algunas respuestas.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildProfileCard(),
                _buildStats(),
                _buildSpecialties(),
                _buildAbout(),
                _buildReviews(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildActions(),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
          child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => setState(() => _isSaved = !_isSaved),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
            padding: const EdgeInsets.all(8),
            child: Icon(
              _isSaved ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
              color: Colors.white, size: 20,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
          decoration: const BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined, color: Colors.white, size: 18),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1E3A5F), Color(0xFF137fec)],
                ),
              ),
              child: const Center(
                child: Icon(Icons.gavel_rounded, color: Colors.white24, size: 80),
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter, end: Alignment.topCenter,
                  colors: [Colors.black45, Colors.transparent],
                ),
              ),
            ),
          ],
        ),
      ),
      title: const Text('Perfil del Abogado',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 34,
                    backgroundColor: Color(0xFFE2E8F0),
                    child: Icon(Icons.person_rounded, color: Color(0xFF94A3B8), size: 36),
                  ),
                  Positioned(
                    bottom: 2, right: 2,
                    child: Container(
                      width: 14, height: 14,
                      decoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('Dr. Alejandro Ruiz',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                          child: const Icon(Icons.verified_rounded, color: Colors.white, size: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    const Text('Abogado Colegiado · No. 87234',
                        style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                    const SizedBox(height: 4),
                    Row(
                      children: const [
                        Icon(Icons.location_on_outlined, size: 13, color: Color(0xFF94A3B8)),
                        SizedBox(width: 3),
                        Text('Madrid, España', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ...List.generate(5, (_) => const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 18)),
              const SizedBox(width: 6),
              const Text('4.9', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              const Text('  (127 reseñas)', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    final items = [
      {'v': '8+', 'l': 'Años exp.'},
      {'v': '350+', 'l': 'Casos'},
      {'v': '96%', 'l': 'Éxito'},
      {'v': '24h', 'l': 'Respuesta'},
    ];
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 1),
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: items.map((s) => Expanded(
          child: Column(
            children: [
              Text(s['v']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
              const SizedBox(height: 2),
              Text(s['l']!, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildSpecialties() {
    const specs = ['Derecho de Familia', 'Derecho Civil', 'Derecho Mercantil'];
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Especialidades',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: specs.map((s) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: Text(s, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.primary)),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAbout() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sobre mí', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          SizedBox(height: 10),
          Text(
            'Abogado especialista en Derecho de Familia y Civil con más de 8 años de experiencia. Egresado de la Universidad Complutense de Madrid con Máster en Derecho Procesal.\n\nHe representado a más de 350 clientes en procesos de divorcio, custodia, liquidación de bienes y revisión de contratos, con una tasa de éxito del 96%.',
            style: TextStyle(fontSize: 13, color: Color(0xFF475569), height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Reseñas de clientes',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              const Text('Ver todas (127)',
                  style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 14),
          ..._reviews.map((r) => _buildReviewCard(r)),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> r) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFE2E8F0),
                child: Text((r['name'] as String)[0],
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF475569))),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r['name'] as String,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
                    Row(
                      children: [
                        ...List.generate(r['rating'] as int,
                            (_) => const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 12)),
                        const SizedBox(width: 6),
                        Text(r['date'] as String,
                            style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(r['comment'] as String,
              style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), height: 1.5)),
          const SizedBox(height: 10),
          Divider(height: 1, color: Colors.grey.shade100),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Row(
            children: [
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.chat),
                  icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18),
                  label: const Text('Chat'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE2E8F0),
                    foregroundColor: const Color(0xFF334155),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.handshake_outlined, size: 18),
                    label: const Text('Invitar al Caso'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: AppColors.primary.withOpacity(0.3),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
