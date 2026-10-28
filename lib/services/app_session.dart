/// Sesión de usuario en memoria.
/// Guarda el rol seleccionado durante la sesión actual.
/// 'cliente' | 'abogado'
class AppSession {
  AppSession._();

  // ── Credenciales demo para pruebas ──
  static const Map<String, String> _demoAccounts = {
    'cliente@demo.com': 'cliente',
    'abogado@demo.com': 'abogado',
  };
  static const String _demoPassword = 'demo1234';

  static String _role = 'cliente'; // valor por defecto

  /// Rol activo: 'cliente' o 'abogado'
  static String get role => _role;

  static bool get isClient => _role == 'cliente';
  static bool get isLawyer => _role == 'abogado';

  /// Establece el rol del usuario (llamar desde RoleSelectionScreen / LoginScreen)
  static void setRole(String role) {
    assert(role == 'cliente' || role == 'abogado',
        'Rol inválido: debe ser "cliente" o "abogado"');
    _role = role;
  }

  /// Ruta del home según el rol activo
  static String get homeRoute =>
      _role == 'abogado' ? '/home-lawyer' : '/home-client';

  /// Autentica con credenciales demo.
  /// Devuelve el rol si son válidas, o null si no coinciden.
  static String? demoLogin(String email, String password) {
    final role = _demoAccounts[email.trim().toLowerCase()];
    if (role != null && password == _demoPassword) return role;
    return null;
  }

  /// Limpia la sesión al cerrar sesión
  static void clear() => _role = 'cliente';
}
