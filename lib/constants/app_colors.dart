import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Colores principales (alineados con la web LexConecta) ──
  static const Color primary     = Color(0xFF0F49BD); // Azul web
  static const Color primaryLight= Color(0xFF3B6DD4);
  static const Color primaryDark = Color(0xFF0A3490);

  // ── Acento verde (mismo que la web #10b981) ──
  static const Color secondary     = Color(0xFF10B981);
  static const Color secondaryLight= Color(0xFF34D399);
  static const Color secondaryDark = Color(0xFF059669);

  // ── Fondos ──
  static const Color background  = Color(0xFFF6F7F8); // Fondo general
  static const Color surface     = Color(0xFFFFFFFF); // Tarjetas / superficies
  static const Color surfaceDark = Color(0xFF192233); // Modo oscuro (igual que web)
  static const Color borderLight = Color(0xFFE2E8F0); // Bordes claros

  // ── Textos ──
  static const Color textPrimary   = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary  = Color(0xFF94A3B8);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ── Estados ──
  static const Color error   = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981); // = secondary
  static const Color warning = Color(0xFFF59E0B);
  static const Color info    = Color(0xFF3B82F6);

  // ── Tema Oscuro Premium (Hero Web - Slate/Dark) ──
  static const Color darkHeroBackground = Color(0xFF0F172A); // Slate 900
  static const Color darkHeroSurface    = Color(0xFF1E293B); // Slate 800
  static const Color darkHeroAccent     = Color(0xFF334155); // Slate 700
  static const Color glassWhite         = Color(0x1AFFFFFF); // Blanco 10%
  static const Color glassBorder        = Color(0x33FFFFFF); // Blanco 20%
  static const Color premiumGradientEnd = Color(0xFF1E1B4B); // Indigo profundo

  // ── Áreas de práctica (colores de la web) ──
  static const Color areaFamilia    = Color(0xFF3B82F6); // Azul
  static const Color areaLaboral    = Color(0xFF10B981); // Verde éxito
  static const Color areaPenal      = Color(0xFF6366F1); // Índigo
  static const Color areaInmobiliario= Color(0xFFF59E0B); // Ámbar
  static const Color areaContratos  = Color(0xFF0D9488); // Teal
  static const Color areaAccidentes = Color(0xFFEF4444); // Rojo
  static const Color areaExtranjeria= Color(0xFF06B6D4); // Cyan
  static const Color areaMercantil  = Color(0xFF8B5CF6); // Violeta
}
