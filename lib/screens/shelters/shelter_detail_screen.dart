import 'package:flutter/material.dart';

class ShelterDetailScreen extends StatelessWidget {
  final String shelterId;

  const ShelterDetailScreen({super.key, required this.shelterId});

  static const _mockById = {
    's-1': {
      'name': 'Abrigo do Sol',
      'status': 'safe',
      'visibility': 'public',
      'capacity': 12,
      'description': 'Local estável com energia renovável e área de descanso.',
    },
    's-2': {
      'name': 'Bunker Verde',
      'status': 'safe',
      'visibility': 'faction',
      'capacity': 8,
      'description': 'Refúgio interno para aliados da facção e estoques críticos.',
    },
    's-3': {
      'name': 'Posto do Pântano',
      'status': 'unsafe',
      'visibility': 'public',
      'capacity': 6,
      'description': 'Estrutura precária com risco de contaminação e baixa proteção.',
    },
  };

  @override
  Widget build(BuildContext context) {
    final shelter = _mockById[shelterId] ?? {
      'name': 'Abrigo',
      'status': 'safe',
      'visibility': 'public',
      'capacity': 10,
      'description': 'Detalhes do abrigo indisponíveis no momento.',
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F5),
      appBar: AppBar(title: const Text('Detalhes do abrigo')),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shelter['name'] as String,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(shelter['description'] as String),
                const SizedBox(height: 18),
                _InfoRow(
                  label: 'Status',
                  value: shelter['status'] == 'safe' ? 'Seguro' : 'Comprometido',
                ),
                _InfoRow(
                  label: 'Visibilidade',
                  value: shelter['visibility'] == 'public' ? 'Público' : 'Facção',
                ),
                _InfoRow(
                  label: 'Capacidade',
                  value: '${shelter['capacity']} pessoas',
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {},
                    child: const Text('Entrar em contato'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF5A6A62))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
