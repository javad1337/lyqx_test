// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:injectable/injectable.dart' as _i526;
import 'package:lyqx_test/app_module.dart' as _i874;
import 'package:lyqx_test/core/navigation/go_router_refresh_notifier.dart'
    as _i647;
import 'package:lyqx_test/features/auth/data/auth_repository_impl.dart'
    as _i161;
import 'package:lyqx_test/features/auth/domain/auth_repository.dart' as _i858;
import 'package:lyqx_test/features/auth/presentation/bloc/auth_bloc.dart'
    as _i102;
import 'package:lyqx_test/features/cart/domain/cart_repository.dart' as _i106;
import 'package:lyqx_test/features/cart/presentation/cubit/cart_cubit.dart'
    as _i45;
import 'package:lyqx_test/features/product/data/product_repository_impl.dart'
    as _i760;
import 'package:lyqx_test/features/product/domain/product_repository.dart'
    as _i915;
import 'package:lyqx_test/features/product/presentation/bloc/product_list_bloc.dart'
    as _i535;
import 'package:lyqx_test/features/wishlist/domain/wishlist_repository.dart'
    as _i458;
import 'package:lyqx_test/features/wishlist/presentation/cubit/wishlist_cubit.dart'
    as _i512;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.lazySingleton<_i512.WishlistCubit>(() => appModule.wishlistCubit);
    gh.lazySingleton<_i45.CartCubit>(() => appModule.cartCubit);
    gh.lazySingleton<_i535.ProductListBloc>(() => appModule.productListBloc);
    gh.lazySingleton<_i647.GoRouterRefreshNotifier>(
      () => appModule.refreshNotifier,
    );
    gh.lazySingleton<_i583.GoRouter>(() => appModule.router);
    gh.lazySingleton<_i106.CartRepository>(
      () => appModule.cartRepo(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i458.WishlistRepository>(
      () => appModule.wishlistRepo(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i915.ProductRepository>(
      () => _i760.ProductRepositoryImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i858.AuthRepository>(
      () => _i161.AuthRepositoryImpl(
        gh<_i361.Dio>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i102.AuthBloc>(
      () => _i102.AuthBloc(gh<_i858.AuthRepository>()),
    );
    return this;
  }
}

class _$AppModule extends _i874.AppModule {}
