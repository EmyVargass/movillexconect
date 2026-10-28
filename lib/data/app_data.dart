import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Datos compartidos de la aplicación LexConecta.
/// Centraliza información reutilizable en múltiples pantallas.
class AppData {
  AppData._();

  // ─────────────────────────────────────────
  // Áreas de práctica legal (8 áreas estándar)
  // ─────────────────────────────────────────
  static const List<Map<String, dynamic>> practiceAreas = [
    {'label': 'Familia',      'icon': Icons.family_restroom_rounded,   'color': AppColors.areaFamilia},
    {'label': 'Laboral',      'icon': Icons.work_rounded,              'color': AppColors.areaLaboral},
    {'label': 'Penal',        'icon': Icons.gavel_rounded,             'color': AppColors.areaPenal},
    {'label': 'Inmobiliario', 'icon': Icons.real_estate_agent_rounded, 'color': AppColors.areaInmobiliario},
    {'label': 'Contratos',    'icon': Icons.description_rounded,       'color': AppColors.areaContratos},
    {'label': 'Accidentes',   'icon': Icons.car_crash_rounded,         'color': AppColors.areaAccidentes},
    {'label': 'Extranjería',  'icon': Icons.flight_rounded,            'color': AppColors.areaExtranjeria},
    {'label': 'Mercantil',    'icon': Icons.storefront_rounded,        'color': AppColors.areaMercantil},
  ];

  // ─────────────────────────────────────────
  // Pasos del proceso (cliente)
  // ─────────────────────────────────────────
  static const List<Map<String, dynamic>> processSteps = [
    {
      'step': '1',
      'title': 'Describe tu caso',
      'body': 'Cuéntanos brevemente qué necesitas. Es gratis, anónimo y sin compromiso.',
      'icon': Icons.edit_note_rounded,
    },
    {
      'step': '2',
      'title': 'Recibe propuestas',
      'body': 'Abogados especializados te enviarán presupuestos en menos de 24h.',
      'icon': Icons.mark_email_read_rounded,
    },
    {
      'step': '3',
      'title': 'Contrata con confianza',
      'body': 'Compara perfiles, lee reseñas verificadas y elige al mejor abogado.',
      'icon': Icons.handshake_rounded,
    },
  ];

  // ─────────────────────────────────────────
  // Abogados de demostración
  // ─────────────────────────────────────────
  static const List<Map<String, dynamic>> demoLawyers = [
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
    {
      'name': 'Lic. Roberto Gómez',
      'specialty': 'Derecho Laboral, Seguridad Social',
      'area': 'Laboral',
      'rating': '4.7',
      'reviews': '67',
      'price': '\$80',
      'availability': 'Lunes',
      'verified': false,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBRzQa6sjuLJIhQof-XJkG9WH8fRS6TWmTm12UoVOLFMBHQhqctMjnXdSdQ5AYoZoHPfORKXD_vyAYxRyhkRlj2Lgk-AwGaFprtfXxhPwQjXzxClrFO6PQfSbJZ7HcqbVrt9xjFEzEvN-BCRkwsO83hgpIayarWbXYxae8fpULpjWt8SF1Z2CrfmGxj1fRJ7PQPvWfFQenpXrNBS7sep4rBB6Btx3Iv1XuX_9QnuJHc3WwLPquXK97SB5yiWmngOAd9goGiEiUZmBc',
    },
    {
      'name': 'Dra. Sofía Herrera',
      'specialty': 'Derecho Penal, Defensa',
      'area': 'Penal',
      'rating': '4.9',
      'reviews': '211',
      'price': '\$180',
      'availability': 'Disponible hoy',
      'verified': true,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDV3hFCm0etMRf51ZwwKkg2oIY_5joPH8arv8J_3JcIwtV3IZzcZS-iwLZGqesFF8kIHdkeDEyIToxEp-DQTiwRcq_GwyhqW4-LGaAsSRbmM2--x5weygh-mTT2sFKETfYhw5iMhIp-Ohb3_-8TeliJcdvcHbgc_D1wacmnP0MFbvZVeJVv2Uhu8GU1kfL4RkkUrnOFw3FR_O31rVqnSi0-_H1RglgIWtlZZp2UpBvqNa9zhUsiDR7w1QW1cQJvWCifrevigbT76i4',
    },
  ];
}
