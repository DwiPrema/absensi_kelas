// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAttendanceCollection on Isar {
  IsarCollection<Attendance> get attendances => this.collection();
}

const AttendanceSchema = CollectionSchema(
  name: r'Attendance',
  id: 4618409064190326501,
  properties: {
    r'classId': PropertySchema(
      id: 0,
      name: r'classId',
      type: IsarType.long,
    ),
    r'dateTime': PropertySchema(
      id: 1,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'details': PropertySchema(
      id: 2,
      name: r'details',
      type: IsarType.objectList,
      target: r'AttendanceDetail',
    )
  },
  estimateSize: _attendanceEstimateSize,
  serialize: _attendanceSerialize,
  deserialize: _attendanceDeserialize,
  deserializeProp: _attendanceDeserializeProp,
  idName: r'attendanceId',
  indexes: {
    r'classId': IndexSchema(
      id: 5352960816261817663,
      name: r'classId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'classId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'dateTime': IndexSchema(
      id: -138851979697481250,
      name: r'dateTime',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dateTime',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'AttendanceDetail': AttendanceDetailSchema},
  getId: _attendanceGetId,
  getLinks: _attendanceGetLinks,
  attach: _attendanceAttach,
  version: '3.1.0+1',
);

int _attendanceEstimateSize(
  Attendance object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.details.length * 3;
  {
    final offsets = allOffsets[AttendanceDetail]!;
    for (var i = 0; i < object.details.length; i++) {
      final value = object.details[i];
      bytesCount +=
          AttendanceDetailSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _attendanceSerialize(
  Attendance object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.classId);
  writer.writeDateTime(offsets[1], object.dateTime);
  writer.writeObjectList<AttendanceDetail>(
    offsets[2],
    allOffsets,
    AttendanceDetailSchema.serialize,
    object.details,
  );
}

Attendance _attendanceDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Attendance();
  object.attendanceId = id;
  object.classId = reader.readLong(offsets[0]);
  object.dateTime = reader.readDateTime(offsets[1]);
  object.details = reader.readObjectList<AttendanceDetail>(
        offsets[2],
        AttendanceDetailSchema.deserialize,
        allOffsets,
        AttendanceDetail(),
      ) ??
      [];
  return object;
}

P _attendanceDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readObjectList<AttendanceDetail>(
            offset,
            AttendanceDetailSchema.deserialize,
            allOffsets,
            AttendanceDetail(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _attendanceGetId(Attendance object) {
  return object.attendanceId;
}

List<IsarLinkBase<dynamic>> _attendanceGetLinks(Attendance object) {
  return [];
}

void _attendanceAttach(IsarCollection<dynamic> col, Id id, Attendance object) {
  object.attendanceId = id;
}

extension AttendanceQueryWhereSort
    on QueryBuilder<Attendance, Attendance, QWhere> {
  QueryBuilder<Attendance, Attendance, QAfterWhere> anyAttendanceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterWhere> anyClassId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'classId'),
      );
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterWhere> anyDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dateTime'),
      );
    });
  }
}

extension AttendanceQueryWhere
    on QueryBuilder<Attendance, Attendance, QWhereClause> {
  QueryBuilder<Attendance, Attendance, QAfterWhereClause> attendanceIdEqualTo(
      Id attendanceId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: attendanceId,
        upper: attendanceId,
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterWhereClause>
      attendanceIdNotEqualTo(Id attendanceId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: attendanceId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: attendanceId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: attendanceId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: attendanceId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterWhereClause>
      attendanceIdGreaterThan(Id attendanceId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: attendanceId, includeLower: include),
      );
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterWhereClause> attendanceIdLessThan(
      Id attendanceId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: attendanceId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterWhereClause> attendanceIdBetween(
    Id lowerAttendanceId,
    Id upperAttendanceId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerAttendanceId,
        includeLower: includeLower,
        upper: upperAttendanceId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterWhereClause> classIdEqualTo(
      int classId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'classId',
        value: [classId],
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterWhereClause> classIdNotEqualTo(
      int classId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'classId',
              lower: [],
              upper: [classId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'classId',
              lower: [classId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'classId',
              lower: [classId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'classId',
              lower: [],
              upper: [classId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterWhereClause> classIdGreaterThan(
    int classId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'classId',
        lower: [classId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterWhereClause> classIdLessThan(
    int classId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'classId',
        lower: [],
        upper: [classId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterWhereClause> classIdBetween(
    int lowerClassId,
    int upperClassId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'classId',
        lower: [lowerClassId],
        includeLower: includeLower,
        upper: [upperClassId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterWhereClause> dateTimeEqualTo(
      DateTime dateTime) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dateTime',
        value: [dateTime],
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterWhereClause> dateTimeNotEqualTo(
      DateTime dateTime) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [],
              upper: [dateTime],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [dateTime],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [dateTime],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [],
              upper: [dateTime],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterWhereClause> dateTimeGreaterThan(
    DateTime dateTime, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateTime',
        lower: [dateTime],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterWhereClause> dateTimeLessThan(
    DateTime dateTime, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateTime',
        lower: [],
        upper: [dateTime],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterWhereClause> dateTimeBetween(
    DateTime lowerDateTime,
    DateTime upperDateTime, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateTime',
        lower: [lowerDateTime],
        includeLower: includeLower,
        upper: [upperDateTime],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AttendanceQueryFilter
    on QueryBuilder<Attendance, Attendance, QFilterCondition> {
  QueryBuilder<Attendance, Attendance, QAfterFilterCondition>
      attendanceIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'attendanceId',
        value: value,
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterFilterCondition>
      attendanceIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'attendanceId',
        value: value,
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterFilterCondition>
      attendanceIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'attendanceId',
        value: value,
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterFilterCondition>
      attendanceIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'attendanceId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterFilterCondition> classIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'classId',
        value: value,
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterFilterCondition>
      classIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'classId',
        value: value,
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterFilterCondition> classIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'classId',
        value: value,
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterFilterCondition> classIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'classId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterFilterCondition> dateTimeEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterFilterCondition>
      dateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterFilterCondition> dateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterFilterCondition> dateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterFilterCondition>
      detailsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'details',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterFilterCondition> detailsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'details',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterFilterCondition>
      detailsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'details',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterFilterCondition>
      detailsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'details',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterFilterCondition>
      detailsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'details',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterFilterCondition>
      detailsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'details',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension AttendanceQueryObject
    on QueryBuilder<Attendance, Attendance, QFilterCondition> {
  QueryBuilder<Attendance, Attendance, QAfterFilterCondition> detailsElement(
      FilterQuery<AttendanceDetail> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'details');
    });
  }
}

extension AttendanceQueryLinks
    on QueryBuilder<Attendance, Attendance, QFilterCondition> {}

extension AttendanceQuerySortBy
    on QueryBuilder<Attendance, Attendance, QSortBy> {
  QueryBuilder<Attendance, Attendance, QAfterSortBy> sortByClassId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'classId', Sort.asc);
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterSortBy> sortByClassIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'classId', Sort.desc);
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterSortBy> sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterSortBy> sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }
}

extension AttendanceQuerySortThenBy
    on QueryBuilder<Attendance, Attendance, QSortThenBy> {
  QueryBuilder<Attendance, Attendance, QAfterSortBy> thenByAttendanceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attendanceId', Sort.asc);
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterSortBy> thenByAttendanceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attendanceId', Sort.desc);
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterSortBy> thenByClassId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'classId', Sort.asc);
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterSortBy> thenByClassIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'classId', Sort.desc);
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterSortBy> thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<Attendance, Attendance, QAfterSortBy> thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }
}

extension AttendanceQueryWhereDistinct
    on QueryBuilder<Attendance, Attendance, QDistinct> {
  QueryBuilder<Attendance, Attendance, QDistinct> distinctByClassId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'classId');
    });
  }

  QueryBuilder<Attendance, Attendance, QDistinct> distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }
}

extension AttendanceQueryProperty
    on QueryBuilder<Attendance, Attendance, QQueryProperty> {
  QueryBuilder<Attendance, int, QQueryOperations> attendanceIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'attendanceId');
    });
  }

  QueryBuilder<Attendance, int, QQueryOperations> classIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'classId');
    });
  }

  QueryBuilder<Attendance, DateTime, QQueryOperations> dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<Attendance, List<AttendanceDetail>, QQueryOperations>
      detailsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'details');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const AttendanceDetailSchema = Schema(
  name: r'AttendanceDetail',
  id: 1998897336995708324,
  properties: {
    r'status': PropertySchema(
      id: 0,
      name: r'status',
      type: IsarType.byte,
      enumMap: _AttendanceDetailstatusEnumValueMap,
    ),
    r'studentId': PropertySchema(
      id: 1,
      name: r'studentId',
      type: IsarType.long,
    )
  },
  estimateSize: _attendanceDetailEstimateSize,
  serialize: _attendanceDetailSerialize,
  deserialize: _attendanceDetailDeserialize,
  deserializeProp: _attendanceDetailDeserializeProp,
);

int _attendanceDetailEstimateSize(
  AttendanceDetail object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _attendanceDetailSerialize(
  AttendanceDetail object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.status.index);
  writer.writeLong(offsets[1], object.studentId);
}

AttendanceDetail _attendanceDetailDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AttendanceDetail();
  object.status =
      _AttendanceDetailstatusValueEnumMap[reader.readByteOrNull(offsets[0])] ??
          StatusKehadiran.hadir;
  object.studentId = reader.readLong(offsets[1]);
  return object;
}

P _attendanceDetailDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_AttendanceDetailstatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          StatusKehadiran.hadir) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AttendanceDetailstatusEnumValueMap = {
  'hadir': 0,
  'sakit': 1,
  'alpha': 2,
  'izin': 3,
};
const _AttendanceDetailstatusValueEnumMap = {
  0: StatusKehadiran.hadir,
  1: StatusKehadiran.sakit,
  2: StatusKehadiran.alpha,
  3: StatusKehadiran.izin,
};

extension AttendanceDetailQueryFilter
    on QueryBuilder<AttendanceDetail, AttendanceDetail, QFilterCondition> {
  QueryBuilder<AttendanceDetail, AttendanceDetail, QAfterFilterCondition>
      statusEqualTo(StatusKehadiran value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceDetail, AttendanceDetail, QAfterFilterCondition>
      statusGreaterThan(
    StatusKehadiran value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceDetail, AttendanceDetail, QAfterFilterCondition>
      statusLessThan(
    StatusKehadiran value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceDetail, AttendanceDetail, QAfterFilterCondition>
      statusBetween(
    StatusKehadiran lower,
    StatusKehadiran upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AttendanceDetail, AttendanceDetail, QAfterFilterCondition>
      studentIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'studentId',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceDetail, AttendanceDetail, QAfterFilterCondition>
      studentIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'studentId',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceDetail, AttendanceDetail, QAfterFilterCondition>
      studentIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'studentId',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceDetail, AttendanceDetail, QAfterFilterCondition>
      studentIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'studentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AttendanceDetailQueryObject
    on QueryBuilder<AttendanceDetail, AttendanceDetail, QFilterCondition> {}
