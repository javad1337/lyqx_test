import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx_test/features/cart/data/cart_repository_impl.dart';
import 'package:lyqx_test/features/cart/domain/cart_repository.dart';
import 'package:lyqx_test/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:lyqx_test/features/cart/presentation/pages/cart_page.dart';
import 'package:lyqx_test/features/product/domain/entities/product.dart';
import 'package:lyqx_test/features/product/domain/product_repository.dart';
import 'package:lyqx_test/features/product/presentation/pages/product_detail_page.dart';
import 'package:lyqx_test/features/wishlist/data/wishlist_repository_impl.dart';
import 'package:lyqx_test/features/wishlist/domain/wishlist_repository.dart';
import 'package:lyqx_test/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:lyqx_test/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:lyqx_test/widgets/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/navigation/go_router_refresh_notifier.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/product/presentation/bloc/product_list_bloc.dart';
import 'features/product/presentation/bloc/product_list_event.dart';
import 'features/product/presentation/pages/home_page.dart';
import 'features/welcome/presentation/pages/welcome_page.dart';
import 'injection.dart';

@module
abstract class AppModule {
  @lazySingleton
  Dio get dio => Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com/'));

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  WishlistCubit get wishlistCubit {
    final c = WishlistCubit(getIt<WishlistRepository>());
    c.load();
    return c;
  }

  @lazySingleton
  CartRepository cartRepo(SharedPreferences prefs) => CartRepositoryImpl(prefs);

  @lazySingleton
  CartCubit get cartCubit {
    final c = CartCubit(getIt<CartRepository>());
    c.loadCart();
    return c;
  }

  @lazySingleton
  ProductListBloc get productListBloc {
    final b = ProductListBloc(getIt<ProductRepository>());
    b.add(FetchProducts());
    return b;
  }

  // Wishlist
  @lazySingleton
  WishlistRepository wishlistRepo(SharedPreferences prefs) =>
      WishlistRepositoryImpl(prefs);

  @lazySingleton
  GoRouterRefreshNotifier get refreshNotifier =>
      GoRouterRefreshNotifier(getIt<AuthBloc>().stream);

  @lazySingleton
  GoRouter get router {
    final bloc = getIt<AuthBloc>();

    return GoRouter(
      initialLocation: '/welcome',

      refreshListenable: getIt<GoRouterRefreshNotifier>(),

      routes: [
        GoRoute(path: '/welcome', builder: (_, __) => const WelcomePage()),
        GoRoute(path: '/login', builder: (_, __) => const LoginPage()),

        GoRoute(
          path: '/product',
          builder: (ctx, state) {
            final product = state.extra as Product;
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: getIt<WishlistCubit>()),
                BlocProvider.value(value: getIt<CartCubit>()),
              ],
              child: ProductDetailPage(product: product),
            );
          },
        ),

        ShellRoute(
          builder:
              (ctx, state, child) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: getIt<WishlistCubit>()),
                  BlocProvider.value(value: getIt<ProductListBloc>()),
                  BlocProvider.value(value: getIt<CartCubit>()),
                ],
                child: Scaffold(
                  body: child,
                  bottomNavigationBar: BottomNavBar(),
                ),
              ),

          routes: [
            GoRoute(path: '/home', builder: (_, __) => const HomePage()),
            GoRoute(
              path: '/wishlist',
              builder: (_, __) => const WishlistPage(),
            ),
            GoRoute(path: '/cart', builder: (_, __) => const CartPage()),
          ],
        ),
      ],

      redirect: (ctx, state) {
        final loggedIn = bloc.state is AuthAuthenticated;

        final goingToLogin = state.uri.path == '/login';
        final goingToWelcome = state.uri.path == '/welcome';

        if (!loggedIn && !goingToLogin && !goingToWelcome) {
          return '/welcome';
        }
        if (loggedIn && (goingToLogin || goingToWelcome)) {
          return '/home';
        }
        return null;
      },
    );
  }
}
