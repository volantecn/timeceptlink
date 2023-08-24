// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialogue_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDialogueCollection on Isar {
  IsarCollection<Dialogue> get dialogues => this.collection();
}

const DialogueSchema = CollectionSchema(
  name: r'Dialogue',
  id: -6924366106720770880,
  properties: {
    r'createDateTime': PropertySchema(
      id: 0,
      name: r'createDateTime',
      type: IsarType.dateTime,
    ),
    r'lastDateTime': PropertySchema(
      id: 1,
      name: r'lastDateTime',
      type: IsarType.dateTime,
    ),
    r'newMessage': PropertySchema(
      id: 2,
      name: r'newMessage',
      type: IsarType.bool,
    ),
    r'receiverId': PropertySchema(
      id: 3,
      name: r'receiverId',
      type: IsarType.string,
    ),
    r'sendLocation': PropertySchema(
      id: 4,
      name: r'sendLocation',
      type: IsarType.object,
      target: r'LocationThumbnail',
    ),
    r'shareLocation': PropertySchema(
      id: 5,
      name: r'shareLocation',
      type: IsarType.bool,
    )
  },
  estimateSize: _dialogueEstimateSize,
  serialize: _dialogueSerialize,
  deserialize: _dialogueDeserialize,
  deserializeProp: _dialogueDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'LocationThumbnail': LocationThumbnailSchema},
  getId: _dialogueGetId,
  getLinks: _dialogueGetLinks,
  attach: _dialogueAttach,
  version: '3.1.0+1',
);

int _dialogueEstimateSize(
  Dialogue object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.receiverId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sendLocation;
    if (value != null) {
      bytesCount += 3 +
          LocationThumbnailSchema.estimateSize(
              value, allOffsets[LocationThumbnail]!, allOffsets);
    }
  }
  return bytesCount;
}

void _dialogueSerialize(
  Dialogue object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createDateTime);
  writer.writeDateTime(offsets[1], object.lastDateTime);
  writer.writeBool(offsets[2], object.newMessage);
  writer.writeString(offsets[3], object.receiverId);
  writer.writeObject<LocationThumbnail>(
    offsets[4],
    allOffsets,
    LocationThumbnailSchema.serialize,
    object.sendLocation,
  );
  writer.writeBool(offsets[5], object.shareLocation);
}

Dialogue _dialogueDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Dialogue(
    lastDateTime: reader.readDateTimeOrNull(offsets[1]),
    newMessage: reader.readBoolOrNull(offsets[2]),
    receiverId: reader.readStringOrNull(offsets[3]),
    sendLocation: reader.readObjectOrNull<LocationThumbnail>(
      offsets[4],
      LocationThumbnailSchema.deserialize,
      allOffsets,
    ),
    shareLocation: reader.readBoolOrNull(offsets[5]),
  );
  object.id = id;
  return object;
}

P _dialogueDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readObjectOrNull<LocationThumbnail>(
        offset,
        LocationThumbnailSchema.deserialize,
        allOffsets,
      )) as P;
    case 5:
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dialogueGetId(Dialogue object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dialogueGetLinks(Dialogue object) {
  return [];
}

void _dialogueAttach(IsarCollection<dynamic> col, Id id, Dialogue object) {
  object.id = id;
}

extension DialogueQueryWhereSort on QueryBuilder<Dialogue, Dialogue, QWhere> {
  QueryBuilder<Dialogue, Dialogue, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DialogueQueryWhere on QueryBuilder<Dialogue, Dialogue, QWhereClause> {
  QueryBuilder<Dialogue, Dialogue, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DialogueQueryFilter
    on QueryBuilder<Dialogue, Dialogue, QFilterCondition> {
  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition>
      createDateTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createDateTime',
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition>
      createDateTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createDateTime',
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> createDateTimeEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition>
      createDateTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition>
      createDateTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> createDateTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createDateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> lastDateTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastDateTime',
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition>
      lastDateTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastDateTime',
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> lastDateTimeEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition>
      lastDateTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> lastDateTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> lastDateTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastDateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> newMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'newMessage',
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition>
      newMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'newMessage',
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> newMessageEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> receiverIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'receiverId',
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition>
      receiverIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'receiverId',
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> receiverIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'receiverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> receiverIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'receiverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> receiverIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'receiverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> receiverIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'receiverId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> receiverIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'receiverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> receiverIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'receiverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> receiverIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'receiverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> receiverIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'receiverId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> receiverIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'receiverId',
        value: '',
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition>
      receiverIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'receiverId',
        value: '',
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> sendLocationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sendLocation',
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition>
      sendLocationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sendLocation',
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition>
      shareLocationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shareLocation',
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition>
      shareLocationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shareLocation',
      ));
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> shareLocationEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shareLocation',
        value: value,
      ));
    });
  }
}

extension DialogueQueryObject
    on QueryBuilder<Dialogue, Dialogue, QFilterCondition> {
  QueryBuilder<Dialogue, Dialogue, QAfterFilterCondition> sendLocation(
      FilterQuery<LocationThumbnail> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'sendLocation');
    });
  }
}

extension DialogueQueryLinks
    on QueryBuilder<Dialogue, Dialogue, QFilterCondition> {}

extension DialogueQuerySortBy on QueryBuilder<Dialogue, Dialogue, QSortBy> {
  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> sortByCreateDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDateTime', Sort.asc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> sortByCreateDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDateTime', Sort.desc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> sortByLastDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDateTime', Sort.asc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> sortByLastDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDateTime', Sort.desc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> sortByNewMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessage', Sort.asc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> sortByNewMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessage', Sort.desc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> sortByReceiverId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiverId', Sort.asc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> sortByReceiverIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiverId', Sort.desc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> sortByShareLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shareLocation', Sort.asc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> sortByShareLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shareLocation', Sort.desc);
    });
  }
}

extension DialogueQuerySortThenBy
    on QueryBuilder<Dialogue, Dialogue, QSortThenBy> {
  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> thenByCreateDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDateTime', Sort.asc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> thenByCreateDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDateTime', Sort.desc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> thenByLastDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDateTime', Sort.asc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> thenByLastDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDateTime', Sort.desc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> thenByNewMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessage', Sort.asc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> thenByNewMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessage', Sort.desc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> thenByReceiverId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiverId', Sort.asc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> thenByReceiverIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiverId', Sort.desc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> thenByShareLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shareLocation', Sort.asc);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QAfterSortBy> thenByShareLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shareLocation', Sort.desc);
    });
  }
}

extension DialogueQueryWhereDistinct
    on QueryBuilder<Dialogue, Dialogue, QDistinct> {
  QueryBuilder<Dialogue, Dialogue, QDistinct> distinctByCreateDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createDateTime');
    });
  }

  QueryBuilder<Dialogue, Dialogue, QDistinct> distinctByLastDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastDateTime');
    });
  }

  QueryBuilder<Dialogue, Dialogue, QDistinct> distinctByNewMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'newMessage');
    });
  }

  QueryBuilder<Dialogue, Dialogue, QDistinct> distinctByReceiverId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'receiverId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Dialogue, Dialogue, QDistinct> distinctByShareLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shareLocation');
    });
  }
}

extension DialogueQueryProperty
    on QueryBuilder<Dialogue, Dialogue, QQueryProperty> {
  QueryBuilder<Dialogue, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Dialogue, DateTime?, QQueryOperations> createDateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createDateTime');
    });
  }

  QueryBuilder<Dialogue, DateTime?, QQueryOperations> lastDateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastDateTime');
    });
  }

  QueryBuilder<Dialogue, bool?, QQueryOperations> newMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'newMessage');
    });
  }

  QueryBuilder<Dialogue, String?, QQueryOperations> receiverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'receiverId');
    });
  }

  QueryBuilder<Dialogue, LocationThumbnail?, QQueryOperations>
      sendLocationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sendLocation');
    });
  }

  QueryBuilder<Dialogue, bool?, QQueryOperations> shareLocationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shareLocation');
    });
  }
}
