import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx_test/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:lyqx_test/utils/text_styles.dart';
import '../features/product/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

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
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(height: 30),
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
                  ],
                ),
                const SizedBox(width: 16),
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
                      const SizedBox(height: 8),
                      Text(product.category, style: AppTextStyles.bodyText),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.black),
                          const SizedBox(width: 4),
                          Text(
                            product.rating.toString(),
                            style: AppTextStyles.bodyText,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: AppTextStyles.bodyText,
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
