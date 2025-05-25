import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx_test/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:lyqx_test/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:lyqx_test/utils/text_styles.dart';

import '../features/product/domain/entities/product.dart';

class WishProductCard extends StatelessWidget {
  final Product product;

  const WishProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (ctx, wlState) {
        final isFav = wlState.favorites.contains(product.id);
        return InkWell(
          onTap: () => context.push('/product', extra: product),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.01),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(
                    product.image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 16),

                // Music Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: AppTextStyles.bodyText.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),
                      Text(
                        '\$${product.price.toString()}',
                        style: AppTextStyles.bodyText,
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: TextButton(
                            onPressed: () {
                              context.read<CartCubit>().add(product.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Added to cart',
                                    style: AppTextStyles.button,
                                  ),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              elevation: 2,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Add to Cart',
                              style: AppTextStyles.bodyText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  icon:
                      isFav
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_outline),
                  color: isFav ? Colors.red : Colors.grey,
                  iconSize: 24,
                  onPressed: () {
                    context.read<WishlistCubit>().toggle(product.id);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
