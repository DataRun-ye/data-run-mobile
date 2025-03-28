import 'package:d2_remote/modules/metadatarun/activity/entities/d_activity.entity.dart';
import 'package:datarunmobile/core/models/d_run_identifiable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ActivityDetail extends DRunIdentifiable<Activity> {
  ActivityDetail._({
    required Activity identifiableEntity,
  }) : super(identifiableEntity: identifiableEntity);

  factory ActivityDetail.fromIdentifiable(
      {required Activity identifiableEntity}) {
    return ActivityDetail._(identifiableEntity: identifiableEntity);
  }

  @override
  ActivityDetail copyWith({
    Activity? identifiableEntity,
  }) {
    return ActivityDetail.fromIdentifiable(
        identifiableEntity: identifiableEntity ?? this.identifiableEntity);
  }
}
