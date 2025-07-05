import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junkfood/providers/date_provider.dart';
import 'package:junkfood/utilities/widgets/datetime/date.dart';
import 'package:junkfood/extensions/sized_box_ext.dart';

class DateBarSmall extends ConsumerWidget {
  const DateBarSmall({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appDate = ref.watch(dateProviderProvider);

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, size: 18.0),
          onPressed: () {
            ref.read(dateProviderProvider.notifier).previousDay();
          },
        ),
        SizedBoxExt.sizedBoxWidth16,
        Date.small(date: appDate),
        SizedBoxExt.sizedBoxWidth8,
        IconButton(
          icon: const Icon(Icons.arrow_forward, size: 18.0),
          onPressed: () {
            ref.read(dateProviderProvider.notifier).nextDay();
          },
        ),
      ],
    );
  }
}
