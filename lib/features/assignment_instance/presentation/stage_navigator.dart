import 'package:d_sdk/database/database.dart';
import 'package:datarunmobile/features/assignment_instance/presentation/stage_form_content.dart';
import 'package:flutter/material.dart';

class StageNavigator extends StatefulWidget {
  const StageNavigator({super.key, required this.assignment});

  final Assignment assignment;

  @override
  State<StageNavigator> createState() => _StageNavigatorState();
}

class _StageNavigatorState extends State<StageNavigator>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: widget.assignment.flowType.stages.length,
      vsync: this,
    );
  }

  @override
  Widget build(_) {
    final stages = widget.assignment.flowType.stages;
    return Column(
      children: [
        TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: stages.map((s) => Tab(text: s.name)).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: stages.map((s) {
              return StageFormContent(
                assignment: widget.assignment,
                stage: s,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
