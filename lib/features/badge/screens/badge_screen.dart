import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reforzamiento/features/badge/badge.dart';

class BadgeScreen extends StatelessWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BadgeCubit badgeCubit = context.read<BadgeCubit>();
    final BadgeState badgeState = context.watch<BadgeCubit>().state;

    return Scaffold(
      appBar: AppBar(title: const Text('App Badge')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Badge(
              alignment: Alignment.lerp(
                Alignment.topRight,
                Alignment.bottomRight,
                0.1,
              ),
              label: Text('${badgeState.count}'),
              child: Text(
                '${badgeState.count}',
                style: const TextStyle(fontSize: 150),
              ),
            ),
            FilledButton(
              onPressed: () => badgeCubit.reset(),
              child: const Text('Borrar Badge'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => badgeCubit.increment(),
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}
