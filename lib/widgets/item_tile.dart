import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  final String name;
  final String category;
  final String icon;
  final int quantity;

  const ItemTile({
    super.key,
    required this.name,
    required this.category,
    required this.icon,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE1E9E2)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF4ED),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(icon, style: const TextStyle(fontSize: 22)),
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
                const SizedBox(height: 2),
                Text(
                  category,
                  style: const TextStyle(color: Color(0xFF5A6A62)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF4ED),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'x$quantity',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF3EA65E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
