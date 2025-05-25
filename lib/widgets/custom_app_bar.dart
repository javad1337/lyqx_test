import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyqx_test/utils/text_styles.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_event.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? titleWidget;
  final String? title;

  const CustomAppBar._({Key? key, this.title, this.titleWidget})
    : super(key: key);

  factory CustomAppBar.text(String title) => CustomAppBar._(title: title);

  factory CustomAppBar.widget(Widget titleWidget) =>
      CustomAppBar._(titleWidget: titleWidget);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,

      title: titleWidget ?? Text(title ?? '', style: AppTextStyles.headline1),

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 232, 178, 1),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.logout, color: Colors.black),
                  onPressed: () {
                    context.read<AuthBloc>().add(LoggedOut());
                  },
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Logout',
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
