import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'icon': Icons.gavel_rounded,
      'color': AppColors.primary,
      'title': 'Nueva solicitud de caso',
      'body': 'Un cliente solicita asesoría en Derecho Laboral: "Despido improcedente".',
      'time': 'Hace 5 min',
      'read': false,
      'type': 'case',
    },
    {
      'icon': Icons.chat_bubble_rounded,
      'color': Color(0xFF7C3AED),
      'title': 'Nuevo mensaje de Ana García',
      'body': '¿Podría enviarme el contrato firmado esta tarde?',
      'time': 'Hace 20 min',
      'read': false,
      'type': 'message',
    },
    {
      'icon': Icons.star_rounded,
      'color': Color(0xFFF59E0B),
      'title': 'Nueva reseña recibida',
      'body': 'Carlos Rodríguez te ha dejado una reseña de 5 estrellas.',
      'time': 'Hace 1 hora',
      'read': false,
      'type': 'review',
    },
    {
      'icon': Icons.check_circle_rounded,
      'color': Color(0xFF10B981),
      'title': 'Propuesta aceptada',
      'body': 'Tu propuesta para el caso #2409 fue aceptada por Inmobiliaria del Norte.',
      'time': 'Hace 3 horas',
      'read': true,
      'type': 'proposal',
    },
    {
      'icon': Icons.calendar_today_rounded,
      'color': Color(0xFFEF4444),
      'title': 'Recordatorio de cita',
      'body': 'Tienes una reunión con María González mañana a las 10:00 AM.',
      'time': 'Hace 1 día',
      'read': true,
      'type': 'reminder',
    },
    {
      'icon': Icons.payments_rounded,
      'color': Color(0xFF10B981),
      'title': 'Pago recibido',
      'body': 'Has recibido un pago de €1.200 por el caso de divorcio #1832.',
      'time': 'Hace 2 días',
      'read': true,
      'type': 'payment',
    },
    {
      'icon': Icons.verified_rounded,
      'color': AppColors.primary,
      'title': 'Verificación completada',
      'body': 'Tu cédula profesional ha sido verificada correctamente.',
      'time': 'Hace 3 días',
      'read': true,
      'type': 'system',
    },
  ];

  void _markAllRead() {
    setState(() {
      for (var n in _notifications) {
        n['read'] = true;
      }
    });
  }

  int get _unreadCount => _notifications.where((n) => !(n['read'] as bool)).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _notifications.isEmpty
                  ? _buildEmpty()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: _notifications.length,
                      separatorBuilder: (_, __) =>
                          const Divider(height: 1, indent: 72, color: Color(0xFFF1F5F9)),
                      itemBuilder: (_, i) => _buildNotificationTile(_notifications[i], i),
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
              'Notificaciones',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
          ),
          if (_unreadCount > 0)
            TextButton(
              onPressed: _markAllRead,
              child: const Text(
                'Leídas',
                style: TextStyle(
                    fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600),
              ),
            )
          else
            const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildNotificationTile(Map<String, dynamic> n, int index) {
    final bool unread = !(n['read'] as bool);
    return GestureDetector(
      onTap: () => setState(() => _notifications[index]['read'] = true),
      child: Container(
        color: unread
            ? AppColors.primary.withOpacity(0.04)
            : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icono circular
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: (n['color'] as Color).withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(n['icon'] as IconData,
                  color: n['color'] as Color, size: 22),
            ),
            const SizedBox(width: 12),
            // Contenido
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          n['title'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: unread ? FontWeight.bold : FontWeight.w500,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      if (unread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                              color: AppColors.primary, shape: BoxShape.circle),
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    n['body'] as String,
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF64748B), height: 1.4),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    n['time'] as String,
                    style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.notifications_none_rounded,
              color: Color(0xFFCBD5E1), size: 60),
          SizedBox(height: 12),
          Text('No hay notificaciones',
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8))),
          SizedBox(height: 4),
          Text('Aquí aparecerán tus alertas y avisos',
              style: TextStyle(fontSize: 12, color: Color(0xFFCBD5E1))),
        ],
      ),
    );
  }
}
