import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:junkfood/l10n/app_localizations.dart';
import 'package:junkfood/providers/date_provider.dart';
import 'package:junkfood/providers/desktop_web_provider.dart';
import 'package:junkfood/ui/controllers/dish_controller.dart';
import 'package:junkfood/ui/controllers/dish_of_the_day_controller.dart';
import 'package:junkfood/ui/widgets/dish_display_widget.dart';
import 'package:junkfood/ui/widgets/language_dropdown_widget.dart';
import 'package:junkfood/ui/widgets/rating_widget.dart';
import 'package:junkfood/ui/pages/comments_page.dart';
import 'package:junkfood/utilities/widgets/datetime/date_bar_small.dart';
import 'package:junkfood/utilities/widgets/gradiant_button_widget.dart';
import 'package:junkfood/utilities/widgets/text_wrapper.dart';

import '../../domain/model/dish_model.dart';

class DishOfTheDayPage extends ConsumerStatefulWidget {
  const DishOfTheDayPage({super.key});

  @override
  ConsumerState<DishOfTheDayPage> createState() => _DishOfTheDayPageState();
}

class _DishOfTheDayPageState extends ConsumerState<DishOfTheDayPage>
    with TickerProviderStateMixin {
  TabController? tabController;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final time = ref.watch(dateProviderProvider);
    final formattedDanish = DateFormat('EEEE \nd. MMMM', 'da_DK').format(time);
    final formattedEnglish = DateFormat('EEEE \nd. MMMM').format(time);

    final dishOfTheDayState = ref.watch(dishOfTheDayControllerProvider);
    final isWeb = ref.read(isDesktopWebProvider);

    tabController?.dispose();

    tabController = TabController(
      length: dishOfTheDayState.value?.length ?? 0,
      vsync: this,
    );

    return Scaffold(
      appBar: AppBar(
        title: isWeb
            ? const DateBarSmall()
            : ButtonText(
                text: AppLocalizations.of(context)!.localeHelper == 'da'
                    ? formattedDanish.substring(0, 1).toUpperCase() +
                        formattedDanish.substring(1)
                    : formattedEnglish,
              ),
        actions: [
          IconButton(
            icon: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.chat_bubble_outline,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            onPressed: () async {
              final navigator = Navigator.of(context);
              await navigator.push(
                MaterialPageRoute(
                  builder: (context) => CommentsPage(),
                ),
              );
            },
          ),
          const LanguageDropdownWidget(),
        ],
        automaticallyImplyLeading: false,
        bottom: dishOfTheDayState.value!.length > 1
            ? PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: Column(
                  children: [
                    Center(
                      child: TabBar(
                        controller: tabController,
                        dividerColor: Colors.transparent,
                        dividerHeight: 0.0,
                        indicator: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFE52E42),
                        ),
                        tabs: dishOfTheDayState.value!.map((DishModel dish) {
                          return Tab(
                            child: SizedBox(
                              width: 8.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              )
            : null,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600.0,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: dishOfTheDayState.value!.length == 1 ? 16.0 : 0.0,
              bottom: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: dishOfTheDayState.value!.map((DishModel dish) {
                      return DishDisplayWidget(
                        dish: dish,
                      );
                    }).toList(),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 24.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: GradiantButton(
                      child: ButtonText(
                        text: AppLocalizations.of(context)!.rateButtonText,
                      ),
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            final dish = ref.watch(
                              dishControllerProvider,
                            );
                            return SingleChildScrollView(
                              child: dish != null
                                  ? RatingWidget(
                                      dish: dish,
                                    )
                                  : const SizedBox.shrink(),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }
}
