import 'package:datarunmobile/data/metadata_submission_update.dart';
import 'package:datarunmobile/data_run/screens/form_module/form/code_generator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddMetadataSubmissionForm extends StatefulHookConsumerWidget {
  const AddMetadataSubmissionForm({
    super.key,
    required this.onSubmit,
    this.initialData,
    required this.submissionId,
    required this.resourceId,
  });

  final Function(MetadataSubmissionUpdate) onSubmit;

  // orgUnit
  final String resourceId;
  final String submissionId;
  final MetadataSubmissionUpdate? initialData;

  @override
  _AddMetadataSubmissionFormState createState() =>
      _AddMetadataSubmissionFormState();
}

class _AddMetadataSubmissionFormState
    extends ConsumerState<AddMetadataSubmissionForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _householdNameController;
  late TextEditingController _serialNumberController;

  @override
  void initState() {
    super.initState();
    _householdNameController = TextEditingController(
      text: widget.initialData?.householdName ?? '',
    );
    _serialNumberController = TextEditingController(
      text: widget.initialData?.householdHeadSerialNumber?.toString() ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _householdNameController,
                decoration: const InputDecoration(labelText: 'Household Name'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Household name is required'
                    : null,
              ),
              TextFormField(
                controller: _serialNumberController,
                decoration: const InputDecoration(labelText: 'Serial Number'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || int.tryParse(value) == null
                        ? 'Valid serial number is required'
                        : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    widget.onSubmit(
                      MetadataSubmissionUpdate(
                        id: widget.initialData?.id ??
                            CodeGenerator.generateCode(16),
                        formData: {
                          'householdName': _householdNameController.text,
                          'householdHeadSerialNumber': int.tryParse(
                            _serialNumberController.text,
                          ),
                        },

                        created: widget.initialData == null,
                        // New entry
                        updated: widget.initialData != null,
                        resourceType: null,
                        metadataSubmission: null,
                        resourceId: widget.resourceId,
                        submissionId: widget.submissionId,
                      ),
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: Text(widget.initialData == null ? 'Add' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
