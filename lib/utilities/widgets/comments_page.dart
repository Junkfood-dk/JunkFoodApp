import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junkfood/data/comments_repository.dart';
import 'package:junkfood/ui/pages/acknowledge_comment_page.dart';
import 'package:junkfood/utilities/widgets/gradiant_button_widget.dart';
import 'package:junkfood/utilities/widgets/text_wrapper.dart';

final commentTextProvider = StateProvider<String>((ref) => '');

class CommentsPage extends ConsumerWidget {
  CommentsPage({super.key});

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSubmitEnabled = ref.watch(commentTextProvider).isNotEmpty;

    _commentController.addListener(() {
      ref.read(commentTextProvider.notifier).state = _commentController.text;
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBar(
                title: TitleLargeText(
                  text: AppLocalizations.of(context)!.commentHeading,
                ),
                automaticallyImplyLeading: false,
              ),
              BodyText(
                text: AppLocalizations.of(context)!.commentPageParagraph,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.writeCommentText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                keyboardType: TextInputType.text,
                maxLength: 500,
                maxLines: 10,
                minLines: 5,
                autofocus: true,
              ),
              Opacity(
                opacity: isSubmitEnabled ? 1.0 : 0.5,
                child: SizedBox(
                  width: double.infinity,
                  height: 48.0,
                  child: GradiantButton(
                    onPressed: isSubmitEnabled
                        ? () async {
                            final commentText = _commentController.text.trim();
                            final navigator = Navigator.of(context);
                            await ref
                                .read(commentRepositoryProvider)
                                .postComment(commentText);
                            _commentController.clear();
                            ref.read(commentTextProvider.notifier).state = '';
                            navigator.push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AcknowledgeCommentPage(),
                              ),
                            );
                          }
                        : null,
                    child: ButtonText(
                      text:
                          AppLocalizations.of(context)!.commentPageSubmitButton,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
