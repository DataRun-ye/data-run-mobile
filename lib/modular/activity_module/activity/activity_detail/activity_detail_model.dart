import 'package:d2_remote/modules/metadatarun/activity/entities/d_activity.entity.dart';
import 'package:datarun/core/models/d_run_identifiable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ActivityDetail extends DRunIdentifiable<Activity> {
  ActivityDetail({
    required Activity identifiableEntity,
  }) : super(identifiableEntity: identifiableEntity);

  factory ActivityDetail.fromIdentifiable(
      {required Activity identifiableEntity}) {
    return ActivityDetail(identifiableEntity: identifiableEntity);
  }

  @override
  ActivityDetail copyWith({
    Activity? identifiableEntity,
  }) {
    return ActivityDetail(
        identifiableEntity: identifiableEntity ?? this.identifiableEntity);
  }

// @override
// List<Object?> get props => super.props;
}
