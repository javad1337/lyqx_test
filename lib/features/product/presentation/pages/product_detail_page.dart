import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx_test/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:lyqx_test/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:lyqx_test/utils/text_styles.dart';
import '../../domain/entities/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (ctx, wlState) {
        final isFav = wlState.favorites.contains(product.id);
        return Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.pop(),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.black,
                ),
                onPressed: () {
                  context.read<WishlistCubit>().toggle(product.id);
                },
              ),
            ],
          ),

          body: Column(
            children: [
              Expanded(
                flex: 10,
                child: Center(
                  child: Image.network(product.image, fit: BoxFit.contain),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.title, style: AppTextStyles.headline2),
                      const SizedBox(height: 8),
                      Text(product.category, style: AppTextStyles.bodyText),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.black, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            product.rating.toStringAsFixed(2),
                            style: AppTextStyles.bodyText,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${product.reviewCount} reviews',

                            style: AppTextStyles.bodyText,
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                color: const Color(0xFFFFE8B2),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price', style: AppTextStyles.bodyText),
                          SizedBox(height: 4),
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: AppTextStyles.bodyText.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              context.read<CartCubit>().add(product.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Added to cart',
                                    style: AppTextStyles.button,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Add to cart',
                              style: AppTextStyles.button,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
