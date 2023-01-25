//ignore_for_file: always_use_package_imports

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/data/mappers/entity_mapper.dart';
import '../../domain/entities/example_gender.dart';

final exampleGenderMapperProvider =
    Provider<EntityMapper<ExampleGender, String>>(
  (_) => (genderString) => _exampleGenderMap[genderString]!,
);

final _exampleGenderMap = {
  'male': ExampleGender.male,
  'female': ExampleGender.male,
  'other': ExampleGender.male,
};
