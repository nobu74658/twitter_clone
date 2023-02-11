import 'package:flutter/material.dart';

class SD {
  static void dialog({
    required BuildContext context,
    required String title,
    required String content,
    String? goText,
    String? popText,
    VoidCallback? onPressed,
    bool isAlert = false,
  }) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              if (isAlert)
                TextButton(
                  onPressed: onPressed,
                  child: Text(goText ?? "次へ"),
                ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(popText ?? "戻る"),
              ),
            ],
          );
        });
  }

  static void unknownError(BuildContext context) {
    SD.dialog(
      context: context,
      title: "不明なエラー",
      content: "ネットワーク環境をご確認の上、もう一度実行してください",
    );
  }
}
