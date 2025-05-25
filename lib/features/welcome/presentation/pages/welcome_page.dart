import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx_test/utils/screen_utils.dart';
import 'package:lyqx_test/utils/text_styles.dart';
import 'package:lyqx_test/widgets/primary_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/welcome.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.5),

            SvgPicture.asset('assets/images/logo.svg'),
            SizedBox(height: screenHeight * 0.01),
            const Text('Fake Store', style: AppTextStyles.headline1),
            SizedBox(height: screenHeight * 0.01),
            PrimaryButton(
              label: 'Login',
              onPressed: () => context.push('/login'),
            ),
          ],
        ),
      ),
    );
  }
}
