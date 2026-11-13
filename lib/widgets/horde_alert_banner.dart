import 'package:flutter/material.dart';

class HordeAlertBanner extends StatelessWidget {
  final String message;

  const HordeAlertBanner({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF4EFE7),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE0C78D), width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFE3C984).withAlpha(80),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: Color(0xFFB77826),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ALERTA DE PERIGO',
                  style: TextStyle(
                    color: Color(0xFF7B4E10),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    color: Color(0xFF4E534F),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
