import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junkfood/data/comments_repository.dart';
import 'package:junkfood/ui/pages/acknowledge_comment_page.dart';
import 'package:junkfood/utilities/widgets/text_wrapper.dart';

final commentTextProvider = StateProvider<String>((ref) => '');

class CommentPage extends ConsumerWidget {
  CommentPage({super.key});

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSubmitEnabled = ref.watch(commentTextProvider).isNotEmpty;

    _commentController.addListener(() {
      ref.read(commentTextProvider.notifier).state = _commentController.text;
    });

    return AnimatedPadding(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        // Set the height constraint of the modal to 80% of screen height
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          AppBar(
            title: Text(AppLocalizations.of(context)!.commentHeading),
            automaticallyImplyLeading: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.commentPageParagraph,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.writeCommentText,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  keyboardType: TextInputType.text,
                  maxLength: 500,
                  maxLines: null,
                  minLines: 1,
                  autofocus: true,
                ),
                const SizedBox(height: 20),
                // Gradient button with opacity adjustment
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Opacity(
              opacity: isSubmitEnabled ? 1.0 : 0.5,
              child: SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton(
                  onPressed: isSubmitEnabled
                      ? () async {
                          final commentText = _commentController.text.trim();
                          await ref
                              .read(commentRepositoryProvider)
                              .postComment(commentText);
                          _commentController.clear();
                          ref.read(commentTextProvider.notifier).state = '';
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const AcknowledgeCommentPage()));
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadowColor: Colors.transparent,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFF935FA2),
                          Color(0xFFE52E42),
                          Color(0xFFF5A334),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(
                          minWidth: double.infinity, minHeight: 50.0),
                      child: ButtonText(
                        text: AppLocalizations.of(context)!
                            .commentPageSubmitButton,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
