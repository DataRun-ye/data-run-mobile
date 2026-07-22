import 'package:datarunmobile/features/common_ui_element/common/app_colors.dart';
import 'package:datarunmobile/features/common_ui_element/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class NoticeSheet extends StatelessWidget {
  const NoticeSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);
  final Function(SheetResponse<dynamic>)? completer;
  final SheetRequest<dynamic> request;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title!,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          verticalSpaceTiny,
          Text(
            request.description!,
            style: const TextStyle(fontSize: 14, color: kcMediumGrey),
            maxLines: 3,
            softWrap: true,
          ),
          verticalSpaceLarge,
        ],
      ),
    );
  }
}
