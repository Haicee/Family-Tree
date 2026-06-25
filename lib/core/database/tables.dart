import 'package:drift/drift.dart';

/// A family tree. A user can maintain multiple independent trees.
class Trees extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 120)();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// A person belonging to a [Trees] entry.
class Members extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get treeId =>
      integer().references(Trees, #id, onDelete: KeyAction.cascade)();
  TextColumn get fullName => text().withLength(min: 1, max: 200)();
  TextColumn get nickname => text().nullable()();
  TextColumn get gender => text().nullable()();
  DateTimeColumn get dateOfBirth => dateTime().nullable()();
  DateTimeColumn get dateOfDeath => dateTime().nullable()();
  TextColumn get placeOfBirth => text().nullable()();
  TextColumn get biography => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// A directed relationship edge between two [Members].
///
/// The relationship kind is stored in [type] using the names of
/// `RelationshipType`. Modeling relationships as edges keeps the tree
/// visualization and the future "relationship finder" flexible.
class Relationships extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get treeId =>
      integer().references(Trees, #id, onDelete: KeyAction.cascade)();
  @ReferenceName('outgoingRelationships')
  IntColumn get fromMemberId =>
      integer().references(Members, #id, onDelete: KeyAction.cascade)();
  @ReferenceName('incomingRelationships')
  IntColumn get toMemberId =>
      integer().references(Members, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// A locally-stored photograph, optionally tied to a member.
class Photos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get treeId =>
      integer().references(Trees, #id, onDelete: KeyAction.cascade)();
  IntColumn get memberId =>
      integer().nullable().references(Members, #id, onDelete: KeyAction.setNull)();
  TextColumn get filePath => text()();
  TextColumn get caption => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// A family story or historical record, optionally tied to a member.
class Stories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get treeId =>
      integer().references(Trees, #id, onDelete: KeyAction.cascade)();
  IntColumn get memberId =>
      integer().nullable().references(Members, #id, onDelete: KeyAction.setNull)();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// A family event (reunion, birthday, wedding, etc.).
///
/// The event kind is stored in [type] using the names of `FamilyEventType`.
class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get treeId =>
      integer().references(Trees, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get type => text()();
  DateTimeColumn get date => dateTime().nullable()();
  TextColumn get location => text().nullable()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
