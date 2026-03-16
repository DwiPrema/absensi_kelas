// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_class_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSchoolClassCollection on Isar {
  IsarCollection<SchoolClass> get schoolClass => this.collection();
}

const SchoolClassSchema = CollectionSchema(
  name: r'SchoolClass',
  id: -7752351258327029191,
  properties: {
    r'schClassName': PropertySchema(
      id: 0,
      name: r'schClassName',
      type: IsarType.string,
    )
  },
  estimateSize: _schoolClassEstimateSize,
  serialize: _schoolClassSerialize,
  deserialize: _schoolClassDeserialize,
  deserializeProp: _schoolClassDeserializeProp,
  idName: r'schoolClassId',
  indexes: {
    r'schClassName': IndexSchema(
      id: 6843488850948110395,
      name: r'schClassName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'schClassName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'students': LinkSchema(
      id: 5460448763725855399,
      name: r'students',
      target: r'Student',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _schoolClassGetId,
  getLinks: _schoolClassGetLinks,
  attach: _schoolClassAttach,
  version: '3.1.0+1',
);

int _schoolClassEstimateSize(
  SchoolClass object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.schClassName.length * 3;
  return bytesCount;
}

void _schoolClassSerialize(
  SchoolClass object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.schClassName);
}

SchoolClass _schoolClassDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SchoolClass();
  object.schClassName = reader.readString(offsets[0]);
  object.schoolClassId = id;
  return object;
}

P _schoolClassDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _schoolClassGetId(SchoolClass object) {
  return object.schoolClassId;
}

List<IsarLinkBase<dynamic>> _schoolClassGetLinks(SchoolClass object) {
  return [object.students];
}

void _schoolClassAttach(
    IsarCollection<dynamic> col, Id id, SchoolClass object) {
  object.schoolClassId = id;
  object.students.attach(col, col.isar.collection<Student>(), r'students', id);
}

extension SchoolClassQueryWhereSort
    on QueryBuilder<SchoolClass, SchoolClass, QWhere> {
  QueryBuilder<SchoolClass, SchoolClass, QAfterWhere> anySchoolClassId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SchoolClassQueryWhere
    on QueryBuilder<SchoolClass, SchoolClass, QWhereClause> {
  QueryBuilder<SchoolClass, SchoolClass, QAfterWhereClause>
      schoolClassIdEqualTo(Id schoolClassId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: schoolClassId,
        upper: schoolClassId,
      ));
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterWhereClause>
      schoolClassIdNotEqualTo(Id schoolClassId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: schoolClassId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: schoolClassId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: schoolClassId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: schoolClassId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterWhereClause>
      schoolClassIdGreaterThan(Id schoolClassId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: schoolClassId, includeLower: include),
      );
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterWhereClause>
      schoolClassIdLessThan(Id schoolClassId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: schoolClassId, includeUpper: include),
      );
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterWhereClause>
      schoolClassIdBetween(
    Id lowerSchoolClassId,
    Id upperSchoolClassId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerSchoolClassId,
        includeLower: includeLower,
        upper: upperSchoolClassId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterWhereClause> schClassNameEqualTo(
      String schClassName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'schClassName',
        value: [schClassName],
      ));
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterWhereClause>
      schClassNameNotEqualTo(String schClassName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'schClassName',
              lower: [],
              upper: [schClassName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'schClassName',
              lower: [schClassName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'schClassName',
              lower: [schClassName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'schClassName',
              lower: [],
              upper: [schClassName],
              includeUpper: false,
            ));
      }
    });
  }
}

extension SchoolClassQueryFilter
    on QueryBuilder<SchoolClass, SchoolClass, QFilterCondition> {
  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      schClassNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'schClassName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      schClassNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'schClassName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      schClassNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'schClassName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      schClassNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'schClassName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      schClassNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'schClassName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      schClassNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'schClassName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      schClassNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'schClassName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      schClassNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'schClassName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      schClassNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'schClassName',
        value: '',
      ));
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      schClassNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'schClassName',
        value: '',
      ));
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      schoolClassIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'schoolClassId',
        value: value,
      ));
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      schoolClassIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'schoolClassId',
        value: value,
      ));
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      schoolClassIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'schoolClassId',
        value: value,
      ));
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      schoolClassIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'schoolClassId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SchoolClassQueryObject
    on QueryBuilder<SchoolClass, SchoolClass, QFilterCondition> {}

extension SchoolClassQueryLinks
    on QueryBuilder<SchoolClass, SchoolClass, QFilterCondition> {
  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition> students(
      FilterQuery<Student> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'students');
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      studentsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'students', length, true, length, true);
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      studentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'students', 0, true, 0, true);
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      studentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'students', 0, false, 999999, true);
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      studentsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'students', 0, true, length, include);
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      studentsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'students', length, include, 999999, true);
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterFilterCondition>
      studentsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'students', lower, includeLower, upper, includeUpper);
    });
  }
}

extension SchoolClassQuerySortBy
    on QueryBuilder<SchoolClass, SchoolClass, QSortBy> {
  QueryBuilder<SchoolClass, SchoolClass, QAfterSortBy> sortBySchClassName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schClassName', Sort.asc);
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterSortBy>
      sortBySchClassNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schClassName', Sort.desc);
    });
  }
}

extension SchoolClassQuerySortThenBy
    on QueryBuilder<SchoolClass, SchoolClass, QSortThenBy> {
  QueryBuilder<SchoolClass, SchoolClass, QAfterSortBy> thenBySchClassName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schClassName', Sort.asc);
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterSortBy>
      thenBySchClassNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schClassName', Sort.desc);
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterSortBy> thenBySchoolClassId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schoolClassId', Sort.asc);
    });
  }

  QueryBuilder<SchoolClass, SchoolClass, QAfterSortBy>
      thenBySchoolClassIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schoolClassId', Sort.desc);
    });
  }
}

extension SchoolClassQueryWhereDistinct
    on QueryBuilder<SchoolClass, SchoolClass, QDistinct> {
  QueryBuilder<SchoolClass, SchoolClass, QDistinct> distinctBySchClassName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'schClassName', caseSensitive: caseSensitive);
    });
  }
}

extension SchoolClassQueryProperty
    on QueryBuilder<SchoolClass, SchoolClass, QQueryProperty> {
  QueryBuilder<SchoolClass, int, QQueryOperations> schoolClassIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'schoolClassId');
    });
  }

  QueryBuilder<SchoolClass, String, QQueryOperations> schClassNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'schClassName');
    });
  }
}
