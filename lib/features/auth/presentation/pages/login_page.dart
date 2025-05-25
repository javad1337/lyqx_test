import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx_test/utils/text_styles.dart';
import 'package:lyqx_test/widgets/primary_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameCtl;
  late final TextEditingController _passwordCtl;
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _usernameCtl = TextEditingController();
    _passwordCtl = TextEditingController();
  }

  @override
  void dispose() {
    _usernameCtl.dispose();
    _passwordCtl.dispose();
    super.dispose();
  }

  void _onLoginTap() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        LoginRequested(_usernameCtl.text.trim(), _passwordCtl.text.trim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: BackButton(onPressed: () => GoRouter.of(context).pop()),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Check your credentials!",
                  style: AppTextStyles.button,
                ),
              ),
            );
          }
          if (state is AuthAuthenticated) {
            context.go('/home');
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      'Welcome back! Glad to see you, Again!',
                      style: AppTextStyles.headline1,
                    ),
                    const SizedBox(height: 32),

                    TextFormField(
                      controller: _usernameCtl,
                      decoration: InputDecoration(
                        hintText: 'Enter your username',
                        hintStyle: AppTextStyles.bodyText,
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator:
                          (v) => (v == null || v.isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _passwordCtl,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        hintStyle: AppTextStyles.bodyText,
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscure ? Icons.visibility_off : Icons.visibility,
                            color: Colors.blueGrey,
                          ),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      validator:
                          (v) => (v == null || v.isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 32),

                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : PrimaryButton(
                          label: 'Login',
                          onPressed: () {
                            _onLoginTap();
                          },
                        ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
