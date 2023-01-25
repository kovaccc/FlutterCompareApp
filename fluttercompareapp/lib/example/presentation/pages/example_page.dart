// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/domain/router/navigation_extensions.dart';
import '../../../common/utils/q_logger.dart';
import '../../domain/notifiers/example_cache_notifier/example_cache_state_notifier.dart';
import '../../domain/notifiers/example_notifier/example_state_notifier.dart';
import '../../domain/notifiers/example_simple_notifier/example_simple_state_notifier.dart';
import 'form_example_page.dart';

class ExamplePage extends ConsumerWidget {
  static const routeName = '/';

  const ExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(exampleNotifierProvider);
    final exampleCacheNotifierState = ref.watch(exampleCacheNotifierProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              state.when(
                data: (sentence) => sentence,
                loading: () => 'Loading',
                initial: () => 'Initial',
                error: (failure) => failure.toString(),
              ),
            ),

            TextButton(
              onPressed: ref
                  .read(exampleNotifierProvider.notifier)
                  .getSomeStringFullExample,
              child: const Text('Get string'),
            ),
            TextButton(
              onPressed: ref
                  .read(exampleNotifierProvider.notifier)
                  .getSomeStringGlobalLoading,
              child: const Text('Global loading example'),
            ),
            TextButton(
              onPressed: ref
                  .read(exampleNotifierProvider.notifier)
                  .getSomeStringsStreamed,
              child: const Text('Cache + Network loading example'),
            ),
            const SizedBox(height: 20),
            Text(
              exampleCacheNotifierState.when(
                data: (result) {
                  if (result.isNetwork) {
                    return '${result.data} (network)';
                  }

                  if (result.isCache) {
                    return '${result.data} (cache)';
                  }

                  return result.data;
                },
                loading: () => 'Loading',
                initial: () => 'Initial',
                error: (failure) => failure.toString(),
              ),
            ),
            TextButton(
              onPressed: ref
                  .read(exampleCacheNotifierProvider.notifier)
                  .getSomeStringsStreamed,
              child:
                  const Text('Cache + Network loading example (with metadata)'),
            ),
            TextButton(
              onPressed: () => QLogger.showLogger(context),
              child: const Text('Show log'),
            ),
            //Navigation example
            TextButton(
              onPressed: () => ref.pushNamed(ExampleSimplePage.routeName),
              child: const Text('Navigate'),
            ),
            TextButton(
              onPressed: () => ref.pushNamed(FormExamplePage.routeName),
              child: const Text('Go to form example'),
            ),
          ],
        ),
      ),
    );
  }
}

class ExampleSimplePage extends ConsumerStatefulWidget {
  static const routeName = '/simple-page';

  const ExampleSimplePage({super.key});

  @override
  ConsumerState<ExampleSimplePage> createState() => _ExampleSimplePageState();
}

class _ExampleSimplePageState extends ConsumerState<ExampleSimplePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(exampleSimpleStateNotifierProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            state.when(
              initial: () => 'Initial',
              empty: () => 'Empty',
              fetching: () => 'Fetching',
              success: (string) => string,
              error: (failure) => failure.title,
            ),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: ref
                .read(exampleSimpleStateNotifierProvider.notifier)
                .getSomeStringSimpleExample,
            child: const Text('Simple state example'),
          ),
          TextButton(
            onPressed: ref
                .read(exampleSimpleStateNotifierProvider.notifier)
                .getSomeStringSimpleExampleGlobalLoading,
            child: const Text('Global loading example'),
          ),
          ElevatedButton(
            onPressed: ref.pop,
            child: const Text('Go back!'),
          ),
          TextButton(
            onPressed: () => ref.pushNamed(ExamplePage3.routeName),
            child: const Text('Navigate'),
          ),
        ],
      ),
    );
  }
}

class ExamplePage3 extends ConsumerWidget {
  static const routeName = '${ExampleSimplePage.routeName}/page3';

  const ExamplePage3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigate back to the second screen by popping the current route
              // off the stack.
              ref.pop();
            },
            child: const Text('Go back!'),
          ),
        ],
      ),
    );
  }
}
