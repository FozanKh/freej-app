class Enums {
  Enums._();
  static T? fromString<T>(Iterable<T> values, String value) {
    return values.firstWhere(
      (type) => type.toString().split(".").last == value.replaceAll(' ', '_'),
      orElse: () => (null as T),
    );
  }

  static String valueString<T>(T enumValue) {
    return enumValue.toString().split(".")[1].replaceAll("_", " ");
  }

  static List<String> toList<T>(Iterable<T> values) {
    List<String> list = [];
    // ignore: avoid_function_literals_in_foreach_calls
    values.forEach((element) => list.add(valueString(element)));

    return list;
  }
}
