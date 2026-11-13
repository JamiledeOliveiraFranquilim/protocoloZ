import 'package:flutter/material.dart';

class TradeCard extends StatelessWidget {
  final String title;
  final String from;
  final String status;
  final String summary;
  final VoidCallback? onTap;

  const TradeCard({
    super.key,
    required this.title,
    required this.from,
    required this.status,
    required this.summary,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isAccepted = status == 'accepted';
    final isPending = status == 'pending';

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isAccepted
                          ? const Color(0xFFEAF4ED)
                          : isPending
                              ? const Color(0xFFF4EFE7)
                              : const Color(0xFFF4E7E7),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      isAccepted ? 'Aceita' : isPending ? 'Pendente' : 'Expirada',
                      style: TextStyle(
                        color: isAccepted
                            ? const Color(0xFF3EA65E)
                            : isPending
                                ? const Color(0xFFB77826)
                                : const Color(0xFFD96E6E),
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Proposta de: $from', style: const TextStyle(color: Color(0xFF5A6A62))),
              const SizedBox(height: 6),
              Text(summary, style: const TextStyle(color: Color(0xFF1A2A23))),
            ],
          ),
        ),
      ),
    );
  }
}
