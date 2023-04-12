import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttercompareapp/common/domain/router/navigation_extensions.dart';
import 'package:fluttercompareapp/common/presentation/widgets/main_scaffold.dart';
import 'package:fluttercompareapp/common/presentation/widgets/text/body_text.dart';
import 'package:fluttercompareapp/generated/l10n.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PhotoDetailPage extends ConsumerWidget {
  static const routeName = '/photo_detail';

  const PhotoDetailPage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MainScaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            ref.pop();
          },
          child: const BackButtonIcon(),
        ),
        centerTitle: false,
        title: BodyText(S.current.photo_detail),
      ),
      body: CachedNetworkImage(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        imageUrl: imageUrl,
      ),
    );
  }
}
