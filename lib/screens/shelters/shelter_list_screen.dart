import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/shelter_card.dart';

class ShelterListScreen extends StatelessWidget {
  const ShelterListScreen({super.key});

  static const _mockShelters = [
    {
      'id': 's-1',
      'name': 'Abrigo do Sol',
      'status': 'safe',
      'visibility': 'public',
      'capacity': 12,
      'photoUrl': null,
    },
    {
      'id': 's-2',
      'name': 'Bunker Verde',
      'status': 'safe',
      'visibility': 'faction',
      'capacity': 8,
      'photoUrl': null,
    },
    {
      'id': 's-3',
      'name': 'Posto do Pântano',
      'status': 'unsafe',
      'visibility': 'public',
      'capacity': 6,
      'photoUrl': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F5),
      appBar: AppBar(title: const Text('Abrigos')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          ..._mockShelters.map(
            (shelter) => ShelterCard(
              name: shelter['name'] as String,
              status: shelter['status'] as String,
              visibility: shelter['visibility'] as String,
              capacity: shelter['capacity'] as int,
              photoUrl: shelter['photoUrl'] as String?,
              onTap: () => context.go('/abrigos/${shelter['id']}'),
            ),
          ),
        ],
      ),
    );
  }
}
