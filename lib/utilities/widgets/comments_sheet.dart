import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommentPage extends StatelessWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.commentHeading),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(AppLocalizations.of(context)!.commentPageParagraph),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.yourNameHintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
              ),
              keyboardType: TextInputType.text,
              maxLines: 2,
              minLines: 1,
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.writeCommentText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
              ),
              keyboardType: TextInputType.text,
              maxLines: null,
              minLines: 1, 
            ),
            SizedBox(height: 20),
            // Gradient button
            Container(
              width: double.infinity, 
              height: 50.0, 
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), 
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Logic to handle comment submission
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, backgroundColor: Colors.transparent, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ), 
                  shadowColor: Colors.transparent, 
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
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
                    constraints: BoxConstraints(minWidth: double.infinity, minHeight: 50.0), 
                    child: Text(
                      AppLocalizations.of(context)!.commentPageSubmitButton,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
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
