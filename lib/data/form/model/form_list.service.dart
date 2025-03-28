import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:datarunmobile/commons/identifiable.repository.dart';
import 'package:datarunmobile/data/form/model/form_version_model.dart';
import 'package:datarunmobile/data/form/repository/form_version_query_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class FormListService {
  FormListService(this._repository);

  final IdentifiableRepository<FormVersion> _repository;

  Future<Iterable<FormVersionModel>> get({FormVersionQueryModel? query}) async {
    final List<FormVersion> entities = await _repository.get(query: query);

    List<FormVersionModel> entityModels = [];
    for (final a in entities) {
      entityModels
          .add(FormVersionModel.fromIdentifiable(identifiableEntity: a));
    }
    return entityModels;
  }
}
