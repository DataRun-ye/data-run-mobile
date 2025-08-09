import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/features/form_submission/application/submission_list.provider.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditActionIconCell extends ConsumerWidget {
  const EditActionIconCell({
    super.key,
    required this.submissionId,
    required this.onPressed,
  });

  final VoidCallback? onPressed;

  /// to check if editable
  final String submissionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CanEditAsync =
        ref.watch(submissionEditStatusProvider(submissionId: submissionId));
    return AsyncValueWidget(
      value: CanEditAsync,
      loadingBuilder: () => const Center(
        heightFactor: 5,
        widthFactor: 5,
        child: CircularProgressIndicator(),
      ),
      valueBuilder: (bool canEdit) {
        return canEdit
            ? IconButton(
                icon: Icon(Icons.edit_document),
                onPressed: onPressed,
                tooltip: S.of(context).edit,
              )
            : IconButton(
                icon: Icon(Icons.visibility),
                onPressed: onPressed,
                tooltip: S.of(context).view,
              );
      },
    );
  }
}
