import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userapp/data/comments_repository.dart';
import 'package:userapp/ui/pages/acknowledge_comment_page.dart';

final commentTextProvider = StateProvider<String>((ref) => '');

class CommentPage extends ConsumerWidget {
  CommentPage({Key? key}) : super(key: key);

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSubmitEnabled = ref.watch(commentTextProvider).isNotEmpty;

    _commentController.addListener(() {
      ref.read(commentTextProvider.notifier).state = _commentController.text;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.commentHeading),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(AppLocalizations.of(context)!.commentPageParagraph),
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
              ),
              const SizedBox(height: 20),
              // Gradient button with opacity adjustment
              Opacity(
                opacity: isSubmitEnabled ? 1.0 : 0.5,
                child: Container(
                  width: double.infinity,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
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
                        child: Text(
                          AppLocalizations.of(context)!.commentPageSubmitButton,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
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