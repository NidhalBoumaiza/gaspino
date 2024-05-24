import 'package:client/features/authorisation/presentation%20layer/pages/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/navigation_with_transition.dart';

class Deconnecte extends StatelessWidget {
  const Deconnecte({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: const Text('Déconnecté'),
        subtitle: const Text('Vous êtes déconnecté'),
        trailing: const Icon(Icons.wifi_off),
        onTap: () =>
            navigateToAnotherScreenWithSlideTransitionFromRightToLeftPushReplacement(
              context,
              const SignInScreen(),
            ));
  }
}
