import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../repositories/player_repository.dart';
import '../../widgets/faction_badge.dart';

class FactionScreen extends StatefulWidget {
  const FactionScreen({super.key});

  @override
  State<FactionScreen> createState() => _FactionScreenState();
}

class _FactionScreenState extends State<FactionScreen> {
  List<Map<String, dynamic>> _factions = [];
  bool _loading = true;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await PlayerRepository(Supabase.instance.client).getFactions();
      if (mounted) {
        setState(() {
          _factions = data;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = 'Não foi possível carregar as facções.';
        });
      }
    }
  }

  Future<void> _choose(String id) async {
    setState(() => _saving = true);
    try {
      await PlayerRepository(Supabase.instance.client).chooseFaction(id);
      if (mounted) context.go('/home');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Não foi possível escolher a facção: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F5),
      appBar: AppBar(title: const Text('Escolha sua facção')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : ListView(
                  padding: const EdgeInsets.all(18),
                  children: [
                    const Text(
                      'Sua decisão definirá sua identidade neste mundo. Esta escolha é permanente.',
                      style: TextStyle(color: Color(0xFF5A6A62)),
                    ),
                    const SizedBox(height: 18),
                    ..._factions.map(
                      (f) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    FactionBadge(
                                      symbol: f['symbol'] ?? '✦',
                                      colorHex: f['color'] ?? '#69C67A',
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        _normalizeName(f['name'] ?? 'Coroa Verde'),
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF1A2A23),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  f['description'] ?? 'Líderes do novo mundo.',
                                  style: const TextStyle(color: Color(0xFF5A6A62)),
                                ),
                                const SizedBox(height: 14),
                                SizedBox(
                                  width: double.infinity,
                                  child: FilledButton(
                                    onPressed: _saving ? null : () => _choose(f['id']),
                                    child: Text(_saving ? 'CONFIRMANDO...' : 'ESCOLHER FACÇÃO'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  String _normalizeName(String value) {
    const map = {
      'Ativistas': 'Vanguarda Viva',
      'Bandidos': 'Lenda do Pântano',
      'Medic': 'Ordem da Sombra',
      'Coroa Verde': 'Coroa Verde',
      'None': 'Coroa Verde',
    };
    return map[value] ?? value;
  }
}
