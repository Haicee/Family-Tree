/// The kind of a directed relationship edge between two members.
enum RelationshipType {
  parent,
  child,
  spouse,
  sibling;

  static RelationshipType fromName(String value) =>
      RelationshipType.values.firstWhere(
        (e) => e.name == value,
        orElse: () => RelationshipType.parent,
      );
}

/// The kind of a family event.
enum FamilyEventType {
  reunion,
  birthday,
  wedding,
  anniversary,
  memorial,
  custom;

  static FamilyEventType fromName(String value) =>
      FamilyEventType.values.firstWhere(
        (e) => e.name == value,
        orElse: () => FamilyEventType.custom,
      );
}

/// A member's gender. Stored as a nullable string so trees imported from
/// other sources with free-form values still load.
enum Gender {
  male,
  female,
  other;

  static Gender? fromName(String? value) {
    if (value == null) return null;
    for (final g in Gender.values) {
      if (g.name == value) return g;
    }
    return null;
  }
}
