import 'package:flutter/foundation.dart';

bool isAllDigits(String value) {
  return value.replaceAll(RegExp(r'[^\d]'), '') == value;
}

/// snakecase('foo_bar') // => "foo_bar"
String toSnakeCase(String? value) {
  if ((value ?? '').isEmpty) {
    return '';
  }

  return value!.replaceAllMapped(
      RegExp(r'[A-Z]'), (Match match) => '_${match[0]?.toLowerCase()}');
}

/// camelcase('foo_bar') // => "fooBar"
String toCamelCase(String? subject) {
  if ((subject ?? '').isEmpty) {
    return '';
  }

  final List<String> splittedString = subject!.split('_');

  if (splittedString.isEmpty) {
    return '';
  }

  final String firstWord = splittedString[0].toLowerCase();
  final List<String> restWords = splittedString
      .sublist(1)
      .map((String word) => toTitleCase(word))
      .toList();

  return firstWord + restWords.join('');
}

/// spacecase('foo_bar') // => "foo bar"
String toSpaceCase(String? value) {
  if ((value ?? '').isEmpty) {
    return '';
  }

  return value!.replaceAllMapped(
      RegExp(r'[A-Z]'), (Match match) => ' ${match[0]?.toLowerCase()}');
}

/// titlecase('foo_bar') // => "Foo Bar"
String toTitleCase(String? text) {
  if ((text ?? '').isEmpty) {
    return '';
  }

  if (text!.length <= 1) {
    return text.toUpperCase();
  }

  text = toSpaceCase(text);
  final List<String> words = text.split(' ');
  final Iterable<String> capitalized = words.map((String word) {
    if (word == 'url') {
      return 'URL';
    }

    final String first = word.substring(0, 1).toUpperCase();
    final String rest = word.substring(1);
    return '$first$rest';
  });

  return capitalized.join(' ');
}

String getFirstName(String value) {
  final List<String> parts = value.split(' ');
  if (parts.length > 1) {
    parts.removeLast();
  }
  return parts.join(' ');
}

String getLastName(String value) {
  final List<String> parts = value.split(' ');
  if (parts.length <= 1) {
    return '';
  }
  return parts.last;
}

bool isValidDate(String input) {
  try {
    DateTime.parse(input);
    return true;
  } catch (e) {
    return false;
  }
}

void printWrapped(String text) {
  if (text.length > 20000) {
    text = text.substring(0, 20000);
  }

  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern
      .allMatches(text)
      .forEach((RegExpMatch match) => debugPrint(match.group(0)));
}

bool matchesStrings({
  required List<String> haystacks,
  String? needle,
}) {
  if (needle == null || needle.isEmpty) {
    return true;
  }

  bool isMatch = false;
  haystacks.forEach((String haystack) {
    if (matchesString(
      haystack: haystack,
      needle: needle,
    )) {
      isMatch = true;
    }
  });
  return isMatch;
}

bool matchesString(
    {required String haystack,
    String? needle,
    bool enableFlexibleSearch = false}) {
  if (needle == null || needle.isEmpty) {
    return true;
  }

  if (enableFlexibleSearch) {
    String regExp = '';
    needle.toLowerCase().runes.forEach((int rune) {
      final String character = RegExp.escape(String.fromCharCode(rune));
      regExp += '$character.*?';
    });
    return RegExp(regExp).hasMatch(haystack.toLowerCase());
  } else {
    return haystack.toLowerCase().contains(needle.toLowerCase());
  }
}

String? matchesStringsValue({
  required List<String> haystacks,
  String? needle,
}) {
  if (needle == null || needle.isEmpty) {
    return null;
  }

  String? match;
  haystacks.forEach((String haystack) {
    final String? value = matchesStringValue(
      haystack: haystack,
      needle: needle,
    );
    if (value != null) {
      match = value;
    }
  });
  return match;
}

String? matchesStringValue({required String haystack, String? needle}) {
  if (needle == null || needle.isEmpty) {
    return null;
  }

  if (haystack.toLowerCase().contains(needle.toLowerCase())) {
    return haystack;
  } else {
    return null;
  }

  /*
  String regExp = '';
  needle.toLowerCase().runes.forEach((int rune) {
    final character = RegExp.escape(String.fromCharCode(rune));
    regExp += character + '.*?';
  });

  if (RegExp(regExp).hasMatch(haystack.toLowerCase())) {
    return haystack;
  } else {
    return null;
  }
  */
}

int secondToLastIndexOf(String string, String pattern) {
  string = string.substring(0, string.lastIndexOf(pattern));

  return string.lastIndexOf(pattern);
}

String trimUrl(String url) {
  url = url.replaceFirst('http://', '').replaceFirst('https://', '');

  if (url.startsWith('www.')) {
    url = url.replaceFirst('www.', '');
  }

  return url;
}
