class AppRoutes {
  AppRoutes._();

  // ── Onboarding ──
  static const String splash          = '/';
  static const String welcome         = '/welcome';
  static const String roleSelection   = '/role-selection';
  static const String login           = '/login';
  static const String registerClient  = '/register-client';
  static const String registerLawyer  = '/register-lawyer';
  static const String register        = '/register';

  // ── Homes por rol ──
  static const String home            = '/home';
  static const String homeClient      = '/home-client';
  static const String homeLawyer      = '/home-lawyer';

  // ── Flujo del abogado ──
  static const String solicitudes     = '/solicitudes';
  static const String solicitudDetalle= '/solicitud-detalle';
  static const String crearPropuesta  = '/crear-propuesta';

  // ── Compartidas ──
  static const String search          = '/search';
  static const String messages        = '/messages';
  static const String chat            = '/chat';
  static const String activity        = '/activity';
  static const String activityClient  = '/activity-client';
  static const String lawyerProfile   = '/lawyer-profile';
  static const String profile         = '/profile';
  static const String notifications   = '/notifications';
  static const String settings        = '/settings';
}
