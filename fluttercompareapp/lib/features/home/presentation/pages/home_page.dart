import 'package:flutter/material.dart';
import 'package:fluttercompareapp/common/presentation/widgets/main_scaffold.dart';
import 'package:fluttercompareapp/common/presentation/widgets/text/body_text.dart';
import 'package:fluttercompareapp/features/auth/login/domain/notifiers/auth_notifier.dart';
import 'package:fluttercompareapp/features/auth/login/domain/providers/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  static const routeName = '/home';

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: false,
        title: BodyText('Hi ${ref.read(userProvider)?.email?.split('@').first}'),
        actions: [
          InkWell(
            onTap: () => ref.read(authNotifierProvider.notifier).signOut(),
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const SizedBox(),
    );
  }
}
