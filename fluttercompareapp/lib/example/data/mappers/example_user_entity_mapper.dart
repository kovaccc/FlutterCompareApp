// ignore_for_file: always_use_package_imports

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/data/mappers/entity_mapper.dart';
import '../../domain/entities/example_user.dart';
import '../models/example_user_response.dart';
import 'example_gender_mapper.dart';

final exampleUserEntityMapperProvider =
    Provider<EntityMapper<ExampleUser, ExampleUserResponse>>(
  (ref) => (response) => ExampleUser(
        response.firstName,
        response.lastName,
        response.birthday,
        ref.read(exampleGenderMapperProvider)(response.gender),
      ),
);
