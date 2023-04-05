import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttercompareapp/common/presentation/app_sizes.dart';
import 'package:fluttercompareapp/common/presentation/widgets/text/body_text.dart';
import 'package:fluttercompareapp/features/photos/domain/entities/photo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PhotoListTile extends ConsumerWidget {
  const PhotoListTile({
    super.key,
    required this.photo,
  });

  final Photo photo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: CachedNetworkImage(
        height: AppSizes.mediumSpacing,
        width: AppSizes.mediumSpacing,
        imageUrl: photo.url,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      title: BodyText(photo.title),
    );
  }
}
