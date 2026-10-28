import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_routes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchCtrl = TextEditingController();
  int _activeArea = -1; // -1 = Todas
  int _currentNavIndex = 1;

  // ── 8 Áreas de práctica ──
  final List<Map<String, dynamic>> _areas = [
    {'label': 'Familia', 'icon': Icons.family_restroom_rounded, 'color': AppColors.areaFamilia},
    {'label': 'Laboral', 'icon': Icons.work_rounded, 'color': AppColors.areaLaboral},
    {'label': 'Penal', 'icon': Icons.gavel_rounded, 'color': AppColors.areaPenal},
    {'label': 'Inmobiliario', 'icon': Icons.real_estate_agent_rounded, 'color': AppColors.areaInmobiliario},
    {'label': 'Contratos', 'icon': Icons.description_rounded, 'color': AppColors.areaContratos},
    {'label': 'Accidentes', 'icon': Icons.car_crash_rounded, 'color': AppColors.areaAccidentes},
    {'label': 'Extranjería', 'icon': Icons.flight_rounded, 'color': AppColors.areaExtranjeria},
    {'label': 'Mercantil', 'icon': Icons.storefront_rounded, 'color': AppColors.areaMercantil},
  ];

  final List<Map<String, dynamic>> _lawyers = [
    {
      'name': 'Dr. Alejandro Ruiz',
      'specialty': 'Derecho Corporativo, Civil',
      'area': 'Mercantil',
      'rating': '4.9',
      'reviews': '128',
      'price': '\$120',
      'availability': 'Disponible hoy',
      'verified': true,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAQ-7XRfIek6NYRCkCuze3oNmJ5D8EReilTGxoKtEjObacFMxwAuH87ivcR5Y6Su98m2wolNVQwILC403yQ9jaJGiFQT-SGB1p7HhoNOSVJE3RY4YM4yzuUSOLRdGK6eN8jnCRQnborP8Jwolo5oYdhb8T0t48EtlQD0KopHF7LaNEIaeStenS9GyMbRNnsoOwlqe26MvK0v_RNlMD8KVaS8ugKBPKZmpCebSGOS6DKjQcffF_Ez-aherbRW-KDqRexb-41QHjdTWg',
    },
    {
      'name': 'Dra. Elena Martínez',
      'specialty': 'Derecho de Familia, Divorcios',
      'area': 'Familia',
      'rating': '4.8',
      'reviews': '94',
      'price': '\$95',
      'availability': 'Mañana',
      'verified': true,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAVr2vKNto-sdkSDULy_KcQNYrTI8jQPmAeefiAqxenGWNEvhOCfhz-k9JgSDKKwgig2HSPDxBFgdEzvNt_k57lTBSUqzwPMKIPpF8nIcz_JsxtAlGJ2Gq7_McnhJn2rzKrR7deWOwqCdf1wkN-_AAwb3rEKLhNYhVYMdHpmfT7WxPKDKM0ofiNKR5Wzrf1U00kv4xvIQK5jqAnjq6e9ziFUbuq5jeapX288l4g17s22PfuXMAnLiOub0p2kVx9RY4fWq7UnGAGHLU',
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    final query = _searchCtrl.text.toLowerCase();
    return _lawyers.where((l) {
      final matchesArea = _activeArea == -1 ||
          (l['area'] as String) == (_areas[_activeArea]['label'] as String);
      final matchesQuery = query.isEmpty ||
          (l['name'] as String).toLowerCase().contains(query) ||
          (l['specialty'] as String).toLowerCase().contains(query);
      return matchesArea && matchesQuery;
    }).toList();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filtered;
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          _buildHeroHeader(),
          Expanded(
            child: results.isEmpty
                ? _buildEmpty()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
                    itemCount: results.length + 1,
                    itemBuilder: (_, i) {
                      if (i == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'RESULTADOS (${results.length})',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF94A3B8),
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const Icon(Icons.filter_list_rounded,
                                  color: AppColors.primary, size: 20),
                            ],
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildLawyerCard(results[i - 1]),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

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
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white, size: 16),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text('Buscar Abogados',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      )),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.glassWhite,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: TextField(
                  controller: _searchCtrl,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  onChanged: (v) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Nombre o especialidad...',
                    hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.4), fontSize: 14),
                    prefixIcon: Icon(Icons.search_rounded,
                        color: Colors.white.withOpacity(0.5), size: 18),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildAreaChip(-1, 'Todos'),
                    ...List.generate(_areas.length, (i) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: _buildAreaChip(i, _areas[i]['label']),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAreaChip(int index, String label) {
    final isSelected = _activeArea == index;
    return GestureDetector(
      onTap: () => setState(() => _activeArea = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.darkHeroBackground : Colors.white,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildLawyerCard(Map<String, dynamic> lawyer) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(lawyer['image'] as String),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(lawyer['name'] as String,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(lawyer['specialty'] as String,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  ],
                ),
              ),
              const Icon(Icons.verified, color: AppColors.primary, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('PRECIO/HORA',
                      style: TextStyle(fontSize: 10, color: Colors.grey)),
                  Text(lawyer['price'] as String,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary)),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Ver Perfil'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(child: Text('No se encontraron abogados'));
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentNavIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      onTap: (i) => setState(() => _currentNavIndex = i),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Buscar'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment_rounded), label: 'Citas'),
        BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Perfil'),
      ],
    );
  }
}
