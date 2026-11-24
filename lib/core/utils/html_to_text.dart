abstract class HtmlToText {
  static String convert(String html) {
    if (html.isEmpty) return '';

    var text = html
        .replaceAll(RegExp(r'<\s*br\s*/?\s*>', caseSensitive: false), '\n')
        .replaceAll(
          RegExp(
            r'<\s*/\s*(p|div|li|ul|ol|h[1-6]|blockquote|pre|tr|td|th)\s*>',
            caseSensitive: false,
          ),
          '\n',
        )
        .replaceAll(RegExp(r'<[^>]+>'), '')
        .replaceAllMapped(
          RegExp(r'&#(\d+);'),
          (m) => String.fromCharCode(int.parse(m.group(1)!)),
        )
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&apos;', "'")
        .replaceAll(' ', ' ');

    return text
        .split('\n')
        .map((line) => line.trim())
        .join('\n')
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        .trim();
  }
}
