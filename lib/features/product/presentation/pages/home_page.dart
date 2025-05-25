import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx_test/features/product/presentation/bloc/product_list_event.dart';
import 'package:lyqx_test/utils/text_styles.dart';
import 'package:lyqx_test/widgets/custom_app_bar.dart';
import 'package:lyqx_test/widgets/product_card.dart';
import '../bloc/product_list_bloc.dart';
import '../bloc/product_list_state.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/bloc/auth_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username(AuthState s) {
    return (s is AuthAuthenticated) ? s.username : '';
  }

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<ProductListBloc>().add(FetchProducts());
  }

  void _onScroll() {
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<ProductListBloc>().add(FetchMoreProducts());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
        appBar: CustomAppBar.widget(
          BlocBuilder<AuthBloc, AuthState>(
            builder: (_, state) => Text('Welcome,\n${_username(state)}'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Fake Store', style: AppTextStyles.headline2),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<ProductListBloc, ProductListState>(
                  builder: (_, state) {
                    if (state is ProductListLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is ProductListLoaded) {
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount:
                            state.products.length +
                            (state.hasReachedMax ? 0 : 1),
                        itemBuilder: (_, i) {
                          if (i >= state.products.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          return ProductCard(product: state.products[i]);
                        },
                      );
                    }
                    if (state is ProductListError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
