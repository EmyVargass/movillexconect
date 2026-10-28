import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _msgCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  // ── Datos de mensajes de prueba ──
  final List<Map<String, dynamic>> _messages = [
    {
      'type': 'received',
      'text': 'Hola, he terminado de revisar el borrador del contrato de arrendamiento. ¿Tienes un momento para discutirlo?',
      'time': '10:42 AM',
      'attachment': null,
    },
    {
      'type': 'sent',
      'text': '¡Hola Doctor! Sí, justo iba a preguntarle por eso. Me preocupa la cláusula de terminación anticipada.',
      'time': '10:45 AM',
      'read': true,
      'attachment': null,
    },
    {
      'type': 'received',
      'text': 'Entiendo. He ajustado el texto para que sea más flexible. Aquí tienes el documento:',
      'time': '10:48 AM',
      'attachment': {
        'name': 'Contrato_Final_v2.pdf',
        'size': '1.2 MB • PDF',
      },
    },
    {
      'type': 'sent',
      'text': 'Perfecto, lo reviso ahora mismo.',
      'time': '10:50 AM',
      'read': false,
      'attachment': null,
    },
  ];

  @override
  void dispose() {
    _msgCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: Column(
        children: [
          // ── Header ──
          _buildHeader(),

          // ── Área de chat ──
          Expanded(
            child: ListView(
              controller: _scrollCtrl,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                // Separador de fecha
                _buildDateSeparator('HOY'),
                const SizedBox(height: 16),

                // Mensajes
                ..._messages.map((m) {
                  final isSent = m['type'] == 'sent';
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: isSent
                        ? _buildSentMessage(m)
                        : _buildReceivedMessage(m),
                  );
                }),
              ],
            ),
          ),

          // ── Barra de entrada ──
          _buildInputBar(),
        ],
      ),
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
            const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Row(
          children: [
            // Botón atrás
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 20, color: Color(0xFF475569)),
            ),

            // Avatar con online
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFFE2E8F0),
                  backgroundImage: const NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuA6KlADElEndqwUF-E5yucZbQFR4nYEx9RmWCZyMnEfTtafQShfbAI8AKrg7hiM9KAd9mIVj-eKrVlCZveQ8pluVRoD0hni49BVtsxwbUOJqhkyRj8hMkhrRhoM9Os8Vaa_uI5isnZ36nB3-jD73iNUcopz2xU8bxb6lBalL6VYQ9BKptlxHJ7He5-1lfzUlGHY4V9UXnz4klTIM4ZezYLuFYv90rY3GO1_kMBfNh98fLBZqyLVpPeJcS-7BnXb3Uin10yAyu9uvAY',
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 11,
                    height: 11,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),

            // Nombre y especialidad
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dr. Alejandro Ruiz',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const Text(
                    'ESPECIALISTA CIVIL',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),

            // Acciones call + more
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call_rounded,
                  color: Color(0xFF475569), size: 22),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert_rounded,
                  color: Color(0xFF475569), size: 22),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // Separador de fecha
  // ─────────────────────────────────────────
  Widget _buildDateSeparator(String label) {
    return Center(
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFE2E8F0),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF64748B),
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // Mensaje recibido (burbuja gris izquierda)
  // ─────────────────────────────────────────
  Widget _buildReceivedMessage(Map<String, dynamic> m) {
    final attachment = m['attachment'] as Map<String, dynamic>?;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Mini avatar
        const CircleAvatar(
          radius: 16,
          backgroundColor: Color(0xFFE2E8F0),
          backgroundImage: NetworkImage(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuA6KlADElEndqwUF-E5yucZbQFR4nYEx9RmWCZyMnEfTtafQShfbAI8AKrg7hiM9KAd9mIVj-eKrVlCZveQ8pluVRoD0hni49BVtsxwbUOJqhkyRj8hMkhrRhoM9Os8Vaa_uI5isnZ36nB3-jD73iNUcopz2xU8bxb6lBalL6VYQ9BKptlxHJ7He5-1lfzUlGHY4V9UXnz4klTIM4ZezYLuFYv90rY3GO1_kMBfNh98fLBZqyLVpPeJcS-7BnXb3Uin10yAyu9uvAY',
          ),
        ),
        const SizedBox(width: 8),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Burbuja
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.72),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0).withOpacity(0.85),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
                padding: attachment != null
                    ? const EdgeInsets.fromLTRB(0, 0, 0, 4)
                    : const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                child: attachment != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                14, 12, 14, 10),
                            child: Text(
                              m['text'] as String,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF0F172A),
                                height: 1.4,
                              ),
                            ),
                          ),
                          // Adjunto PDF
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                8, 0, 8, 8),
                            child: _buildAttachment(attachment),
                          ),
                        ],
                      )
                    : Text(
                        m['text'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF0F172A),
                          height: 1.4,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                m['time'] as String,
                style: const TextStyle(
                    fontSize: 10, color: Color(0xFF94A3B8)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  // Mensaje enviado (burbuja azul derecha)
  // ─────────────────────────────────────────
  Widget _buildSentMessage(Map<String, dynamic> m) {
    final isRead = m['read'] as bool? ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.72),
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: Text(
              m['text'] as String,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
                height: 1.4,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              m['time'] as String,
              style: const TextStyle(
                  fontSize: 10, color: Color(0xFF94A3B8)),
            ),
            const SizedBox(width: 3),
            Icon(
              Icons.done_all_rounded,
              size: 14,
              color: isRead
                  ? AppColors.primary
                  : const Color(0xFF94A3B8),
            ),
          ],
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  // Widget de adjunto PDF
  // ─────────────────────────────────────────
  Widget _buildAttachment(Map<String, dynamic> attachment) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.description_rounded,
                color: Colors.red, size: 20),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attachment['name'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  attachment['size'] as String,
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.download_rounded,
                color: AppColors.primary, size: 20),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // Barra de entrada
  // ─────────────────────────────────────────
  Widget _buildInputBar() {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        child: Row(
          children: [
            // Adjuntar
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.attach_file_rounded,
                    color: Color(0xFF64748B), size: 20),
              ),
            ),
            const SizedBox(width: 8),

            // Campo de texto
            Expanded(
              child: Container(
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _msgCtrl,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: 'Escribe un mensaje...',
                          hintStyle: TextStyle(
                              fontSize: 14, color: Color(0xFF94A3B8)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(
                              18, 10, 4, 10),
                        ),
                      ),
                    ),
                    // Emoji
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.sentiment_satisfied_rounded,
                            color: Color(0xFF94A3B8), size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Botón enviar
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(Icons.send_rounded,
                    color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
