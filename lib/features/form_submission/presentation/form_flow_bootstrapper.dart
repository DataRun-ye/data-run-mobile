import 'package:datarunmobile/features/form_submission/application/form_flow_bootstrapper_controller.dart';
import 'package:datarunmobile/features/common_ui_element/common/ui_helpers.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class FormFlowBootstrapper extends StatefulWidget {
  const FormFlowBootstrapper({
    Key? key,
    this.submissionId,
    this.formId,
    this.versionId,
    this.assignmentId,
  }) : super(key: key);
  final String? formId;
  final String? versionId;
  final String? assignmentId;
  final String? submissionId;

  @override
  State<FormFlowBootstrapper> createState() => _FormFlowBootstrapperState();
}

class _FormFlowBootstrapperState extends State<FormFlowBootstrapper> {
  late final FormFlowBootstrapperController _controller =
      FormFlowBootstrapperController(
    formId: widget.formId,
    versionId: widget.versionId,
    assignmentId: widget.assignmentId,
  );
  Object? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _bootstrap();
    });
  }

  Future<void> _bootstrap() async {
    try {
      await _controller.bootstrapFlow(widget.submissionId);
    } catch (error) {
      if (mounted) {
        setState(() => _error = error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final message = widget.submissionId == null
        ? S.of(context).draftDataInstance
        : S.of(context).initializingDataInstance;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${message}...',
                overflow: TextOverflow.ellipsis,
              ),
              if (_error != null) Text('${_error.toString()}...'),
              const SizedBox(
                width: 2,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(S.of(context).checkingSession,
                      style: TextStyle(fontSize: 16, color: cs.surfaceDim)),
                  horizontalSpaceSmall,
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.orangeAccent[400]!),
                      strokeWidth: 6,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
