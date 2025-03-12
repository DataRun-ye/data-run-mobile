import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class TreeNode with EquatableMixin {
  TreeNode({
    required this.id,
    this.code,
    this.name,
    this.displayName,
    this.path,
    this.parent,
    List<TreeNode>? children,
    this.selectable = false,
  }) : children = children ?? [];

  final String? id;
  final String? code;
  final String? name;
  final String? displayName;
  final String? path;
  final String? parent;
  final bool selectable;
  final List<TreeNode> children;

  @override
  List<Object?> get props =>
      [id, code, name, displayName, path, parent, selectable, children];

  Map<String, dynamic> toJson() {
    return {
      'uid': id,
      'code': code,
      'name': name,
      'displayName': displayName,
      'path': path,
      'parent': parent,
      'selectable': selectable,
      'children': children.map((child) => child.toJson()).toList(),
    };
  }

  static TreeNode fromJson(Map<String, dynamic> json) {
    return TreeNode(
      id: json['uid'] as String?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      displayName: json['displayName'] as String?,
      path: json['path'] as String?,
      parent: json['parent'] as String?,
      selectable: json['selectable'] as bool? ?? false,
      children: (json['children'] as List<dynamic>?)
              ?.map((child) => TreeNode.fromJson(child as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class RestorableTreeNode extends RestorableValue<TreeNode?> {
  RestorableTreeNode(TreeNode? defaultValue) : _defaultValue = defaultValue;

  final TreeNode? _defaultValue;

  @override
  TreeNode? createDefaultValue() => _defaultValue;

  @override
  void didUpdateValue(TreeNode? oldValue) {
    notifyListeners();
  }

  @override
  TreeNode? fromPrimitives(Object? data) =>
      data != null ? TreeNode.fromJson(data as Map<String, dynamic>) : null;

  @override
  Object? toPrimitives() => value?.toJson();
}
