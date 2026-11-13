import 'package:flutter/material.dart';

class TradeDetailScreen extends StatelessWidget {
  final String tradeId;

  const TradeDetailScreen({super.key, required this.tradeId});

  static const _mockById = {
    'trade-101': {
      'title': 'Troca de suprimentos',
      'from': 'Nexa',
      'status': 'pending',
      'summary': 'Ofereço 2 garrafas de água e 1 kit médico por 3 alimentos secos.',
    },
    'trade-102': {
      'title': 'Recursos de construção',
      'from': 'Mara',
      'status': 'accepted',
      'summary': '2 telas de metal + 1 ferramenta por 1 fuel can e 1 comida.',
    },
    'trade-103': {
      'title': 'Medicamentos',
      'from': 'Kiro',
      'status': 'expired',
      'summary': 'Ofereço remédios em troca de materiais de abrigo e metralha.',
    },
  };

  @override
  Widget build(BuildContext context) {
    final data = _mockById[tradeId] ?? {
      'title': 'Troca',
      'from': 'Desconhecido',
      'status': 'pending',
      'summary': 'Detalhes da troca indisponíveis no momento.',
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F5),
      appBar: AppBar(title: const Text('Detalhes da troca')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title'] as String,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Origem: ${data['from']}'),
                  const SizedBox(height: 8),
                  Text('Status: ${_statusLabel(data['status'] as String)}'),
                  const SizedBox(height: 12),
                  Text(data['summary'] as String),
                  const SizedBox(height: 18),
                  const Divider(),
                  const SizedBox(height: 10),
                  const Text('Itens oferecidos', style: TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  const _ItemRow(label: 'Água', value: '2 garrafas'),
                  const _ItemRow(label: 'Kit médico', value: '1 unidade'),
                  const _ItemRow(label: 'Comida', value: '3 pacotes'),
                  const SizedBox(height: 18),
                  const Text('Itens pedidos', style: TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  const _ItemRow(label: 'Energia', value: '1 cartucho'),
                  const _ItemRow(label: 'Metal', value: '2 peças'),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {},
                      child: const Text('Responder troca'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'accepted':
        return 'Aceita';
      case 'pending':
        return 'Pendente';
      default:
        return 'Expirada';
    }
  }
}

class _ItemRow extends StatelessWidget {
  final String label;
  final String value;

  const _ItemRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
