import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lyqx_test/features/auth/presentation/bloc/auth_state.dart';
import 'package:lyqx_test/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:lyqx_test/features/product/domain/entities/product.dart';
import 'package:lyqx_test/features/product/presentation/bloc/product_list_bloc.dart';
import 'package:lyqx_test/features/product/presentation/bloc/product_list_state.dart';
import 'package:lyqx_test/utils/text_styles.dart';
import 'package:lyqx_test/widgets/custom_app_bar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  double _total(List<Product> all, Map<int, int> items) {
    return items.entries.fold(0.0, (sum, e) {
      final prod = all.firstWhere((p) => p.id == e.key);
      return sum + prod.price * e.value;
    });
  }

  void showAnimatedCheckoutPopup(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation1, curve: Curves.elasticOut),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 600),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 50,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    textAlign: TextAlign.center,
                    'Order Placed Successfully!',
                    style: AppTextStyles.headline2,
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.go('/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Continue Shopping',
                        style: AppTextStyles.button,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          // Navigate only when the bloc actually transitions
          context.go('/welcome');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar.text('Cart'),

        body: Column(
          children: [
            BlocBuilder<ProductListBloc, ProductListState>(
              builder: (ctx, prodState) {
                if (prodState is ProductListLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (prodState is ProductListError) {
                  return Center(child: Text(prodState.message));
                }
                if (prodState is ProductListLoaded) {
                  return BlocBuilder<CartCubit, CartState>(
                    builder: (ctx, cartState) {
                      final items = cartState.items;
                      if (items.isEmpty) {
                        return const Center(child: Text('Your cart is empty'
                        ,style: AppTextStyles.bodyText,));
                      }
                      // build each row with swipe-to-delete
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: items.length,
                          itemBuilder: (_, i) {
                            final entry = items.entries.elementAt(i);
                            final prod = prodState.products.firstWhere(
                              (p) => p.id == entry.key,
                            );
                            final qty = entry.value;

                            return Dismissible(
                              key: ValueKey(prod.id),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 16),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              onDismissed: (_) => cartCubit.remove(prod.id),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: Row(
                                  children: [
                                    // thumbnail
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        prod.image,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // title + quantity controls
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            prod.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 8),

                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Decrease button
                                              Container(
                                                width: 32,
                                                height: 32,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey.shade400,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed:
                                                      () => cartCubit.update(
                                                        prod.id,
                                                        qty - 1,
                                                      ),
                                                  icon: Icon(
                                                    Icons.remove_circle_outline,
                                                    size: 20,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),

                                              // Quantity display
                                              Container(
                                                width: 50,
                                                height: 32,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(
                                                      color:
                                                          Colors.grey.shade400,
                                                    ),
                                                    bottom: BorderSide(
                                                      color:
                                                          Colors.grey.shade400,
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  qty.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),

                                              // Increase button
                                              Container(
                                                width: 32,
                                                height: 32,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey.shade400,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed:
                                                      () => cartCubit.update(
                                                        prod.id,
                                                        qty + 1,
                                                      ),
                                                  icon: const Icon(
                                                    Icons.add_circle_outline,
                                                    size: 20,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // line‐total
                                    Text(
                                      '\$${(prod.price * qty).toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            Spacer(),
            Divider(height: 1, color: Colors.grey[300]),
            BlocBuilder<ProductListBloc, ProductListState>(
              builder: (ctx, prodState) {
                if (prodState is! ProductListLoaded) return const SizedBox();
                return BlocBuilder<CartCubit, CartState>(
                  builder: (ctx, cartState) {
                    final total = _total(prodState.products, cartState.items);
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),

                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Row(
                          children: [
                            Text(
                              'Cart total\n\$${total.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 16),
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
                                    showAnimatedCheckoutPopup(ctx);
                                  },
                                  child: const Text(
                                    'Checkout',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),

        // bottom bar with total + checkout
      ),
    );
  }
}
