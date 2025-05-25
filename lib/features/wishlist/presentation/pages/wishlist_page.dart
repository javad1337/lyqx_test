import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lyqx_test/features/auth/presentation/bloc/auth_state.dart';
import 'package:lyqx_test/features/product/presentation/bloc/product_list_bloc.dart';
import 'package:lyqx_test/features/product/presentation/bloc/product_list_state.dart';
import 'package:lyqx_test/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:lyqx_test/widgets/custom_app_bar.dart';
import 'package:lyqx_test/widgets/wish_product_card.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.go('/welcome');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: CustomAppBar.text('Wishlist'),
        body: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, prodState) {
            if (prodState is ProductListLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (prodState is ProductListLoaded) {
              return BlocBuilder<WishlistCubit, WishlistState>(
                builder: (context, wlState) {
                  final favProducts =
                      prodState.products
                          .where((p) => wlState.favorites.contains(p.id))
                          .toList();

                  if (favProducts.isEmpty) {
                    return const Center(child: Text('No favorites yet'));
                  }

                  return Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: ListView.builder(
                      itemCount: favProducts.length,
                      itemBuilder: (ctx, i) {
                        final product = favProducts[i];
                        return WishProductCard(product: product);
                      },
                    ),
                  );
                },
              );
            }

            return prodState is ProductListError
                ? Center(child: Text(prodState.message))
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
