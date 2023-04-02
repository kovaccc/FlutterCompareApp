import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DevicesPage extends ConsumerStatefulWidget {
  static const routeName = '/devices';

  const DevicesPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _DevicesPageState();
}

class _DevicesPageState extends ConsumerState<DevicesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(),
    );
  }
}
