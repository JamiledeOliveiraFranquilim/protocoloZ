import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/trade_card.dart';

class TradeScreen extends StatelessWidget {
  const TradeScreen({super.key});

  static const _mockTrades = [
    {
      'id': 'trade-101',
      'title': 'Troca de suprimentos',
      'from': 'Nexa',
      'status': 'pending',
      'summary': 'Ofereço 2 garrafas de água e 1 kit médico por 3 alimentos secos.',
    },
    {
      'id': 'trade-102',
      'title': 'Recursos de construção',
      'from': 'Mara',
      'status': 'accepted',
      'summary': '2 telas de metal + 1 ferramenta por 1 fuel can e 1 comida.',
    },
    {
      'id': 'trade-103',
      'title': 'Medicamentos',
      'from': 'Kiro',
      'status': 'expired',
      'summary': 'Ofereço remédios em troca de materiais de abrigo e metralha.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F5),
      appBar: AppBar(
        title: const Text('Trocas'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const SizedBox(height: 8),
          ..._mockTrades.map(
            (trade) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TradeCard(
                title: trade['title'] as String,
                from: trade['from'] as String,
                status: trade['status'] as String,
                summary: trade['summary'] as String,
                onTap: () => context.go('/trocas/${trade['id']}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
