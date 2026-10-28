import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_routes.dart';
import '../services/app_session.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifs = true;
  bool _emailNotifs = true;
  bool _smsNotifs = false;
  bool _darkMode = false;
  bool _biometric = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 12),
                children: [
                  _buildSection('Notificaciones', [
                    _buildToggleTile(
                      icon: Icons.notifications_rounded,
                      iconColor: AppColors.primary,
                      title: 'Notificaciones push',
                      subtitle: 'Alertas de nuevos casos y mensajes',
                      value: _pushNotifs,
                      onChanged: (v) => setState(() => _pushNotifs = v),
                    ),
                    _buildToggleTile(
                      icon: Icons.email_rounded,
                      iconColor: const Color(0xFF7C3AED),
                      title: 'Notificaciones por email',
                      subtitle: 'Resúmenes y actualizaciones importantes',
                      value: _emailNotifs,
                      onChanged: (v) => setState(() => _emailNotifs = v),
                    ),
                    _buildToggleTile(
                      icon: Icons.sms_rounded,
                      iconColor: const Color(0xFF10B981),
                      title: 'Notificaciones por SMS',
                      subtitle: 'Alertas urgentes por mensaje de texto',
                      value: _smsNotifs,
                      onChanged: (v) => setState(() => _smsNotifs = v),
                    ),
                  ]),
                  const SizedBox(height: 8),
                  _buildSection('Apariencia y Seguridad', [
                    _buildToggleTile(
                      icon: Icons.dark_mode_rounded,
                      iconColor: const Color(0xFF334155),
                      title: 'Modo oscuro',
                      subtitle: 'Cambia el tema de la aplicación',
                      value: _darkMode,
                      onChanged: (v) => setState(() => _darkMode = v),
                    ),
                    _buildToggleTile(
                      icon: Icons.fingerprint_rounded,
                      iconColor: const Color(0xFFF59E0B),
                      title: 'Autenticación biométrica',
                      subtitle: 'Desbloquea con huella o Face ID',
                      value: _biometric,
                      onChanged: (v) => setState(() => _biometric = v),
                    ),
                  ]),
                  const SizedBox(height: 8),
                  _buildSection('Cuenta', [
                    _buildNavTile(
                      icon: Icons.lock_outline_rounded,
                      iconColor: const Color(0xFF334155),
                      title: 'Cambiar contraseña',
                      onTap: () {},
                    ),
                    _buildNavTile(
                      icon: Icons.language_rounded,
                      iconColor: AppColors.primary,
                      title: 'Idioma',
                      trailing: 'Español',
                      onTap: () {},
                    ),
                    _buildNavTile(
                      icon: Icons.phone_android_rounded,
                      iconColor: const Color(0xFF7C3AED),
                      title: 'Dispositivos vinculados',
                      onTap: () {},
                    ),
                  ]),
                  const SizedBox(height: 8),
                  _buildSection('Soporte', [
                    _buildNavTile(
                      icon: Icons.help_outline_rounded,
                      iconColor: const Color(0xFF10B981),
                      title: 'Centro de ayuda',
                      onTap: () {},
                    ),
                    _buildNavTile(
                      icon: Icons.privacy_tip_outlined,
                      iconColor: AppColors.primary,
                      title: 'Política de privacidad',
                      onTap: () {},
                    ),
                    _buildNavTile(
                      icon: Icons.description_outlined,
                      iconColor: const Color(0xFF64748B),
                      title: 'Términos y condiciones',
                      onTap: () {},
                    ),
                    _buildNavTile(
                      icon: Icons.info_outline_rounded,
                      iconColor: const Color(0xFF94A3B8),
                      title: 'Versión de la app',
                      trailing: '1.0.0',
                      onTap: null,
                    ),
                  ]),
                  const SizedBox(height: 8),
                  // Botón cerrar sesión
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              title: const Text('Cerrar sesión',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              content: const Text(
                                  '¿Estás seguro que deseas cerrar sesión?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancelar'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                      AppSession.clear();
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, AppRoutes.welcome, (_) => false);
                                    },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade600,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                  ),
                                  child: const Text('Cerrar sesión'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.logout_rounded, size: 18),
                        label: const Text('Cerrar sesión',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade50,
                          foregroundColor: Colors.red.shade700,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF0F172A), size: 20),
          ),
          const Expanded(
            child: Text(
              'Configuración',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 6),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(0xFF94A3B8),
                letterSpacing: 0.8),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFF1F5F9)),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildToggleTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
                Text(subtitle,
                    style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildNavTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF0F172A))),
            ),
            Text(
              trailing ?? '',
              style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
            ),
            if (onTap != null) ...[
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right_rounded,
                  color: Color(0xFFCBD5E1), size: 20),
            ],
          ],
        ),
      ),
    );
  }
}
