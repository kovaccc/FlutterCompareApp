// ignore_for_file: always_use_package_imports

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation/widgets/base_loading_indicator.dart';
import '../../presentation/widgets/base_widget.dart';

///[globalLoadingProvider] can be used to show the loading indicator without updating [BaseStateNotifier]
///state. The entire app is wrapped in [BaseWidget] and [BaseLoadingIndicator] can be shown above entire
///app by simply calling [showGlobalLoading]. To hide [BaseLoadingIndicator] simply call [clearGlobalLoading]
final globalLoadingProvider = StateProvider<bool>((_) => false);
