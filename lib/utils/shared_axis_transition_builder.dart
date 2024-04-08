import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

sharedAxisTransitionBuilder(
  Widget Function(BuildContext context, GoRouterState state) pageBuilder,
) {
  return (
    BuildContext context,
    GoRouterState state,
  ) {
    final child = pageBuilder(context, state);

    return CustomTransitionPage<void>(
      child: child,
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        );
      },
    );
  };
}
