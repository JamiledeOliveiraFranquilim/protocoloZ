import 'package:flutter/material.dart';

class ShelterCard extends StatelessWidget {
  final String name;
  final String status;
  final String visibility;
  final int capacity;
  final String? photoUrl;
  final VoidCallback? onTap;

  const ShelterCard({
    super.key,
    required this.name,
    required this.status,
    required this.visibility,
    required this.capacity,
    this.photoUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: 76,
                  height: 76,
                  child: photoUrl != null
                      ? Image.network(
                          photoUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.home_work_rounded),
                        )
                      : Container(
                          color: const Color(0xFFEAF4ED),
                          child: const Icon(Icons.home_work_rounded, color: Color(0xFF3EA65E)),
                        ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      status == 'safe' ? 'Seguro' : 'Comprometido',
                      style: TextStyle(
                        color: status == 'safe' ? const Color(0xFF3EA65E) : const Color(0xFFD96E6E),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Visibilidade: ${visibility == 'public' ? 'Público' : 'Facção'} • Capacidade: $capacity',
                      style: const TextStyle(color: Color(0xFF5A6A62)),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFF3EA65E)),
            ],
          ),
        ),
      ),
    );
  }
}
