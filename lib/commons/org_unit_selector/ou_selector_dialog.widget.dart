import 'dart:async';

import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:d2_remote/modules/metadata/organisation_unit/entities/organisation_unit_level.entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

import '../../main/l10n/app_localizations.dart';
import '../custom_widgets/buttons/app_text_button.dart';
import '../custom_widgets/list_filter.dart';
import 'business_logic/org_unit_item.dart';
import 'chips_row.widget.dart';
import 'ou_selector_dialog.presenter.dart';
import 'ou_selector_list.widget.dart';

enum OUSelectionType { CAPTURE, SEARCH }

class OuSelectorDialog extends StatefulWidget {
  OuSelectorDialog(
      {super.key,
      required this.title,
      required this.selectedOrgUnit,
      required this.textChangedConsumer,
      required this.onDialogCancelled,
      required this.onClear,
      // required this.initialData,
      required this.ouSelectionType});

  final String title;

  final void Function(String, String) textChangedConsumer;
  final void Function() onDialogCancelled;
  final void Function() onClear;

  // private CompositeDisposable disposable;
  final String? selectedOrgUnit;
  late final List<OrgUnitItem> initialData;
  final OUSelectionType ouSelectionType;

  final RxList<OrganisationUnit> _orgUnits = <OrganisationUnit>[].obs;

  @override
  State<OuSelectorDialog> createState() => _OuSelectorDialogState();
}

class _OuSelectorDialogState extends State<OuSelectorDialog> {
  late final Future<List<OrgUnitItem>> _orgUnitItems;
  final OuSelectorDialogPresenter presenter =
      OuSelectorDialogPresenter.instance;

  @override
  Widget build(BuildContext context) {
    presenter.loadOrgUnitItems(widget.ouSelectionType);

    return Column(
      children: [
        Text(widget.title),
        const SizedBox(width: 10),
        ListFilter(
          filter: presenter.orgUnitSearchText.value,
          onFilterChanged: (String? value) {
            if (value != null) {
              presenter.lookUpOrgUnits(value);
            }
          },
        ),
        const SizedBox(width: 10),
        const Divider(height: 2),
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(() => ChipsRow(
                      orgUnits: presenter.orgUnits,
                      clickedItem: (OrganisationUnit ou) {
                        widget.textChangedConsumer
                            .call(ou.id!, ou.displayName!);
                        Navigator.pop(context);
                      })),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 2),
        const SizedBox(width: 10),
        StreamBuilder<List<OrgUnitItem>>(
            stream: presenter.orgUnitItemsStream,
            builder: (BuildContext context,
                AsyncSnapshot<List<OrgUnitItem>> snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return OuSelectorList(
                selectedOrgUnit: widget.selectedOrgUnit,
                items: snapshot.data!,
                selectionType: widget.ouSelectionType,
                onNewLevelSelected: (bool canBeSelected) {
                  if (canBeSelected) {
                    presenter.acceptButtonEnabled.value = true;
                  } else {
                    presenter.acceptButtonEnabled.value = false;
                  }
                },
              );
            }),
        const SizedBox(width: 20),
        _bottomBtnsRow()
      ],
    );
  }

  Widget _bottomBtnsRow() {
    final AppLocalization localization = AppLocalization.of(context)!;
    return Row(
      children: <Widget>[
        AppTextButton(
          label: localization.lookup('clear'),
          onPressed: () {
            // showChips([]);
            // setAdapter(initialData);
            presenter.orgUnitSearchText.value = null;
            presenter.orgUnits.assignAll([]);
            presenter.orgUnitItems.assignAll(widget.initialData);
            presenter.acceptButtonEnabled.value = false;
            widget.onClear();
            presenter.orgUnitSearchText.value = null;
            Navigator.pop(context);
          },
        ),
        AppTextButton(
          label: localization.lookup('cancel'),
          onPressed: () {
            widget.onDialogCancelled();
            presenter.orgUnitSearchText.value = null;
            Navigator.pop(context);
          },
        ),
        Obx(() => AppTextButton(
              label: localization.lookup('accept'),
              onPressed: presenter.acceptButtonEnabled.value
                  ? () async {
                      presenter.orgUnitSearchText.value = null;
                      // showChips([]);
                      final String? selectedOrgUnitUid =
                          presenter.getSelectedOrgUnit();
                      if (selectedOrgUnitUid != null) {
                        D2Remote.organisationUnitModule.organisationUnit
                            .getOne()
                            .then((OrganisationUnit? ou) {
                          widget.textChangedConsumer
                              .call(selectedOrgUnitUid, ou!.displayName!);
                          presenter.orgUnitSearchText.value = null;
                          Navigator.pop(context);
                        });
                      }
                    }
                  : null,
            )),
      ],
    );
  }

  @override
  Future<void> didChangeDependencies() async {
    /// This method is most used by subclasses in cases when network fetches
    /// need to take place following a dependancy change which would otherwise
    /// prove too expensive to do for every build.

    await presenter.loadOrgUnitItems(widget.ouSelectionType);
    super.didChangeDependencies();
  }
}
