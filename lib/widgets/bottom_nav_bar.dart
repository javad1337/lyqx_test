import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = GoRouter.of(context).routeInformationProvider.value.uri.path;

    int getCurrentIndex(String path) {
      if (path == '/home' || path == '/') return 0;
      if (path == '/wishlist') return 1;
      if (path == '/cart') return 2;
      return 0;
    }

    final currentIndex = getCurrentIndex(loc);

    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (i) {
        switch (i) {
          case 0:
            context.go('/home');
            break;
          case 1:
            context.go('/wishlist');
            break;
          case 2:
            context.go('/cart');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, size: 30),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border, size: 30),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined, size: 30),
          label: 'Cart',
        ),
      ],
    );
  }
}
