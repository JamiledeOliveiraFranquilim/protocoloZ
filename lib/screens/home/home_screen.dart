import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/theme/app_theme.dart';
import '../../repositories/game_repository.dart';
import '../../widgets/stat_panel.dart';
import '../../widgets/faction_badge.dart';
import '../../widgets/horde_alert_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? _data;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await GameRepository(Supabase.instance.client).dashboard();
      if (mounted) {
        setState(() {
          _data = data;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final data = _data;
    final faction = data?['factions'] as Map<String, dynamic>?;
    final nickname = data?['nickname'] ?? 'Sobrevivente';

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Nexo da colônia'),
        actions: [
          IconButton(
            onPressed: _load,
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Atualizar',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        color: AppTheme.primaryStrong,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
          children: [
            _HeroCard(
              nickname: nickname,
              factionName: _normalizeFactionName(faction?['name'] ?? 'Coroa Verde'),
              symbol: faction?['symbol'] ?? '✦',
              colorHex: faction?['color'] ?? '#69C67A',
              reputation: data?['reputation'] ?? 0,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: StatPanel(
                    icon: Icons.trending_up_rounded,
                    label: 'Vitória',
                    value: '70%',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatPanel(
                    icon: Icons.verified_rounded,
                    label: 'Nível',
                    value: '08',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatPanel(
                      icon: Icons.calendar_today_rounded,
                      label: 'Days',
                      value: '76',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const HordeAlertBanner(
                message: 'Mantenha atenção aos sinais de atividade nas proximidades.',
              ),
              const SizedBox(height: 22),
              Text(
                'Sua jornada',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              _ActionTile(
                icon: Icons.explore_rounded,
                title: 'Iniciar expedição',
                subtitle: 'Procure recursos fora do abrigo.',
                onTap: () => context.go('/expeditions'),
              ),
              const SizedBox(height: 10),
              _ActionTile(
                icon: Icons.inventory_2_rounded,
                title: 'Consultar inventário',
                subtitle: 'Confira seus suprimentos e itens.',
                onTap: () => context.go('/inventory'),
              ),
              const SizedBox(height: 10),
              _ActionTile(
                icon: Icons.map_rounded,
                title: 'Mapa e abrigos',
                subtitle: 'Visualize rotas e pontos estratégicos.',
                onTap: () => context.go('/map'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final String nickname;
  final String factionName;
  final String symbol;
  final String colorHex;
  final int reputation;

  const _HeroCard({
    required this.nickname,
    required this.factionName,
    required this.symbol,
    required this.colorHex,
    required this.reputation,
  });

  Color get _factionColor {
    final value = colorHex.replaceFirst('#', '');
    return Color(int.parse('FF$value', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withAlpha(18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 18,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withAlpha(18),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notifications_none_rounded, size: 20),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(10),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text('Close', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reputação',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.muted,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.monetization_on_rounded, color: AppTheme.primary, size: 18),
                  Text(
                    ' $reputation',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                FactionBadge(symbol: symbol, colorHex: colorHex),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nickname,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '@${nickname.toLowerCase().replaceAll(' ', '')}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.muted,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: _factionColor.withAlpha(30),
                    shape: BoxShape.circle,
                    border: Border.all(color: _factionColor, width: 2),
                  ),
                  child: Icon(Icons.add_rounded, color: _factionColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              factionName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.neutral,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppTheme.primary.withAlpha(18),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppTheme.primary, size: 26),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: AppTheme.muted),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}
