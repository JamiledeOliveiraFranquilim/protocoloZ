import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/theme/app_theme.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/expeditions/expeditions_screen.dart';
import 'screens/factions/faction_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/inventory/inventory_screen.dart';
import 'screens/map/shelter_map_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/shelters/shelter_detail_screen.dart';
import 'screens/shelters/shelter_list_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/trades/trade_detail_screen.dart';
import 'screens/trades/trade_screen.dart';

final _router = GoRouter(
  initialLocation: '/',
  refreshListenable: GoRouterRefreshStream(Supabase.instance.client.auth.onAuthStateChange),
  redirect: (context, state) {
    final session = Supabase.instance.client.auth.currentSession;
    final current = state.matchedLocation;
    final isAuthRoute = current == '/login' || current == '/register';

    if (session == null) {
      if (current == '/' || isAuthRoute) return null;
      return '/login';
    }

    if (current == '/') return '/home';

    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
    GoRoute(path: '/faction', builder: (_, __) => const FactionScreen()),
    GoRoute(path: '/trocas', builder: (_, __) => const TradeScreen()),
    GoRoute(
      path: '/trocas/:id',
      builder: (context, state) => TradeDetailScreen(
        tradeId: state.pathParameters['id'] ?? 'trade-101',
      ),
    ),
    GoRoute(path: '/abrigos', builder: (_, __) => const ShelterListScreen()),
    GoRoute(
      path: '/abrigos/:id',
      builder: (context, state) => ShelterDetailScreen(
        shelterId: state.pathParameters['id'] ?? 's-1',
      ),
    ),
    ShellRoute(
      builder: (_, state, child) => GameShell(location: state.matchedLocation, child: child),
      routes: [
        GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/inventory', builder: (_, __) => const InventoryScreen()),
        GoRoute(path: '/expeditions', builder: (_, __) => const ExpeditionsScreen()),
        GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
        GoRoute(path: '/map', builder: (_, __) => const ShelterMapScreen()),
      ],
    ),
  ],
);

class ProtocoloZApp extends StatelessWidget {
  const ProtocoloZApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'Protocolo Z',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        routerConfig: _router,
      );
}

class GameShell extends StatelessWidget {
  final String location;
  final Widget child;

  const GameShell({super.key, required this.location, required this.child});

  int get _index {
    if (location.startsWith('/inventory')) return 1;
    if (location.startsWith('/expeditions')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    const paths = ['/home', '/inventory', '/expeditions', '/profile'];
    const icons = [
      Icons.eco_rounded,
      Icons.backpack_rounded,
      Icons.explore_rounded,
      Icons.person_rounded,
    ];
    const labels = ['Base', 'Mochila', 'Expedições', 'Perfil'];

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(18),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: NavigationBar(
          height: 76,
          selectedIndex: _index,
          onDestinationSelected: (i) => context.go(paths[i]),
          destinations: List.generate(
            4,
            (i) => NavigationDestination(
              icon: Icon(icons[i]),
              label: labels[i],
            ),
          ),
        ),
      ),
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final dynamic _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
