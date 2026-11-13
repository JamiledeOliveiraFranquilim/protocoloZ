import 'package:flutter/material.dart';

class FactionBadge extends StatelessWidget {
  final String symbol;
  final String colorHex;

  const FactionBadge({super.key, required this.symbol, required this.colorHex});

  Color get _color {
    final value = colorHex.replaceFirst('#', '');
    return Color(int.parse('FF$value', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: _color.withAlpha(22),
        shape: BoxShape.circle,
        border: Border.all(color: _color.withAlpha(140), width: 2),
        boxShadow: [
          BoxShadow(
            color: _color.withAlpha(40),
            blurRadius: 14,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            color: _color,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
