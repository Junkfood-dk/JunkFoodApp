import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userapp/data/comments_repository.dart';

class CommentPage extends ConsumerWidget {
  CommentPage({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.commentHeading),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(AppLocalizations.of(context)!.commentPageParagraph),
            const SizedBox(height: 15),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.yourNameHintText,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
              keyboardType: TextInputType.text,
              maxLines: 2,
              minLines: 1,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.writeCommentText,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
              keyboardType: TextInputType.text,
              maxLines: null,
              minLines: 1,
            ),
            const SizedBox(height: 20),
            // Gradient button
            Container(
              width: double.infinity,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  final name = _nameController.text.trim();
                  final commentText = _commentController.text.trim();
                  if (name.isEmpty || commentText.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                      content: const Text(
                          "Both name and comment fields must be filled out"),
                      backgroundColor: Colors.redAccent,
                      action: SnackBarAction(
                        label: 'OK',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                      duration: const Duration(seconds: 3), 
                      behavior: SnackBarBehavior
                          .floating, 
                    ));
                  } else {
                    try {
                      await ref
                          .read(commentRepositoryProvider)
                          .postComment(commentText, name);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Comment posted successfully!"),
                        duration: Duration(seconds: 2),
                      ));
                      _nameController.clear();
                      _commentController.clear();
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Failed to post comment: $error"),
                        duration: const Duration(seconds: 3),
                      ));
                    }
                  }
                },
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
          ],
        ),
      ),
    );
  }
}
