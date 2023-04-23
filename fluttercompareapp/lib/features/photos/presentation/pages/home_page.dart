import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:fluttercompareapp/common/domain/router/navigation_extensions.dart';
import 'package:fluttercompareapp/common/presentation/app_sizes.dart';
import 'package:fluttercompareapp/common/presentation/widgets/main_scaffold.dart';
import 'package:fluttercompareapp/common/presentation/widgets/text/body_text.dart';
import 'package:fluttercompareapp/features/auth/login/domain/notifiers/auth_notifier.dart';
import 'package:fluttercompareapp/features/auth/login/domain/providers/user_provider.dart';
import 'package:fluttercompareapp/features/map/presentation/map_page.dart';
import 'package:fluttercompareapp/features/photos/domain/notifiers/photos_notifier.dart';
import 'package:fluttercompareapp/features/photos/presentation/widgets/photo_list_tile.dart';
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
    ref.listen(
      authNotifierProvider,
          (_, state) {
        state.maybeMap(
          orElse: () {},
          data: (data) {
            if (!data.data) {
              Beamer.of(context).update();
            }
          },
        );
      },
    );
    return MainScaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: false,
        title:
            BodyText('Hi ${ref.read(userProvider)?.email?.split('@').first}'),
        actions: [
          InkWell(
            onTap: () => ref.read(authNotifierProvider.notifier).signOut(),
            child: const Icon(Icons.logout),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.normalSpacing),
            child: InkWell(
              onTap: () => ref.pushNamed(MapPage.routeName),
              child: const Icon(Icons.map),
            ),
          ),
        ],
      ),
      body: ref.watch(photosNotifierProvider).maybeWhen(
            orElse: () => const CircularProgressIndicator(),
            data: (data) => ListView.separated(
              itemBuilder: (context, index) =>
                  PhotoListTile(photo: data[index]),
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSizes.normalSpacing),
              itemCount: data.length,
            ),
          ),
    );
  }
}
