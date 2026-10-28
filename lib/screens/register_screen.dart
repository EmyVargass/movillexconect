import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_routes.dart';
import '../services/app_session.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _step = 1; // 1: Rol, 2: Datos, 3: Seguridad
  String? _role;

  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();
  
  bool _obscure = true;
  bool _loading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_step == 1 && _role == null) return;
    if (_step == 2) {
      // Validar datos básicos si es necesario, por ahora solo avanzar
    }
    setState(() => _step++);
  }

  Future<void> _submit() async {
    if (_passCtrl.text != _confirmPassCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    
    AppSession.setRole(_role!);
    setState(() => _loading = false);
    
    Navigator.pushNamedAndRemoveUntil(context, AppSession.homeRoute, (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkHeroBackground,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.darkHeroBackground, AppColors.premiumGradientEnd],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopNav(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: _buildCurrentStep(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopNav() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
            onPressed: () {
              if (_step > 1) {
                setState(() => _step--);
              } else {
                Navigator.pop(context);
              }
            },
          ),
          Row(
            children: List.generate(3, (i) {
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _step == i + 1 ? Colors.white : Colors.white24,
                ),
              );
            }),
          ),
          const SizedBox(width: 40), // Balance
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_step) {
      case 1: return _buildStep1();
      case 2: return _buildStep2();
      case 3: return _buildStep3();
      default: return _buildStep1();
    }
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Crea tu cuenta',
            style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Selecciona tu perfil de usuario',
            style: TextStyle(color: Colors.white70, fontSize: 16)),
        const SizedBox(height: 40),
        _buildRoleCard(
          role: 'cliente',
          title: 'Soy Cliente',
          desc: 'Busco ayuda legal para mis problemas.',
          icon: Icons.person_rounded,
        ),
        const SizedBox(height: 16),
        _buildRoleCard(
          role: 'abogado',
          title: 'Soy Abogado',
          desc: 'Quiero ofrecer mis servicios profesionales.',
          icon: Icons.gavel_rounded,
        ),
        const SizedBox(height: 60),
        _buildNextButton(onPressed: _role != null ? _nextStep : null),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tus datos',
            style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
        const SizedBox(height: 40),
        _buildGlassTextField(controller: _nameCtrl, hint: 'Nombre completo', icon: Icons.person_outline),
        const SizedBox(height: 16),
        _buildGlassTextField(controller: _emailCtrl, hint: 'Correo electrónico', icon: Icons.email_outlined),
        const SizedBox(height: 16),
        _buildGlassTextField(controller: _phoneCtrl, hint: 'Teléfono', icon: Icons.phone_android),
        const SizedBox(height: 60),
        _buildNextButton(onPressed: _nextStep),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Seguridad',
            style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
        const SizedBox(height: 40),
        _buildGlassTextField(controller: _passCtrl, hint: 'Contraseña', icon: Icons.lock_outline, isPass: true),
        const SizedBox(height: 16),
        _buildGlassTextField(controller: _confirmPassCtrl, hint: 'Confirmar contraseña', icon: Icons.lock_clock_outlined, isPass: true),
        const SizedBox(height: 60),
        _buildNextButton(label: 'REGISTRARME', onPressed: _loading ? null : _submit),
      ],
    );
  }

  Widget _buildRoleCard({required String role, required String title, required String desc, required IconData icon}) {
    final isSelected = _role == role;
    return GestureDetector(
      onTap: () => setState(() => _role = role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : AppColors.glassWhite,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isSelected ? Colors.white : AppColors.glassBorder),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.darkHeroBackground : Colors.white, size: 32),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(
                    color: isSelected ? AppColors.darkHeroBackground : Colors.white,
                    fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(desc, style: TextStyle(
                    color: isSelected ? AppColors.darkHeroBackground.withOpacity(0.7) : Colors.white70,
                    fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassTextField({required TextEditingController controller, required String hint, required IconData icon, bool isPass = false}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.glassWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPass && _obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38),
          prefixIcon: Icon(icon, color: Colors.white70),
          suffixIcon: isPass ? IconButton(
            icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off, color: Colors.white70),
            onPressed: () => setState(() => _obscure = !_obscure),
          ) : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }

  Widget _buildNextButton({String label = 'CONTINUAR', VoidCallback? onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.darkHeroBackground,
          disabledBackgroundColor: Colors.white24,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: _loading ? const CircularProgressIndicator() : Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
