import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/features/form_submission/application/reference_field_service.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class ReferenceValueDisplay extends StatefulWidget {
  const ReferenceValueDisplay({
    super.key,
    required this.uid,
    this.orgUnitUid,
    this.assignmentUid,
    this.errorText,
    this.maxLines = 2,
  }) : assert(
          orgUnitUid != null || assignmentUid != null,
          'Reference display requires an org unit or assignment',
        );

  final String uid;
  final String? orgUnitUid;
  final String? assignmentUid;
  final String? errorText;
  final int maxLines;

  @override
  State<ReferenceValueDisplay> createState() => _ReferenceValueDisplayState();
}

class _ReferenceValueDisplayState extends State<ReferenceValueDisplay> {
  late final ReferenceFieldService _service;
  late Future<String?> _displayName;

  @override
  void initState() {
    super.initState();
    _service = ReferenceFieldService(appLocator<AppDatabase>());
    _displayName = _loadDisplayName();
  }

  @override
  void didUpdateWidget(covariant ReferenceValueDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.uid != widget.uid ||
        oldWidget.orgUnitUid != widget.orgUnitUid ||
        oldWidget.assignmentUid != widget.assignmentUid) {
      _displayName = _loadDisplayName();
    }
  }

  Future<String?> _loadDisplayName() async {
    final orgUnitUid = widget.orgUnitUid ??
        await _service.resolveOrgUnitUid(widget.assignmentUid);
    return (await _service.find(
      orgUnitUid: orgUnitUid,
      uid: widget.uid,
    ))
        ?.displayName;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _displayName,
      builder: (context, snapshot) {
        final text = snapshot.connectionState == ConnectionState.done
            ? snapshot.data ??
                '${S.of(context).referenceNameUnavailable} '
                    '(${_shortUid(widget.uid)})'
            : S.of(context).loading;
        final color = widget.errorText == null
            ? null
            : Theme.of(context).colorScheme.error;

        return Tooltip(
          message: [
            text,
            if (widget.errorText != null) widget.errorText!,
          ].join('\n'),
          child: Text(
            widget.errorText == null ? text : '$text! ${widget.errorText}',
            maxLines: widget.maxLines,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontWeight: widget.errorText == null ? null : FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  String _shortUid(String uid) {
    if (uid.length <= 8) {
      return uid;
    }
    return '${uid.substring(0, 4)}…${uid.substring(uid.length - 4)}';
  }
}
