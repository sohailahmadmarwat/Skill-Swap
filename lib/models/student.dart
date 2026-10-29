// Map (const, key -> value): skill name -> category. Used for filter chips and search.
// Dart Maps & const collection
const Map<String, String> skillCategories = {
  'Flutter': 'Coding',
  'Python': 'Coding',
  'JavaScript': 'Coding',
  'Web Development': 'Coding',
  'ML/AI Developer': 'Coding',
  'Data Science': 'Coding',
  'Data Structures': 'Coding',
  'Graphic Design': 'Design',
  'UI/UX Design': 'Design',
  'Figma': 'Design',
  'English': 'Languages',
  'English Speaking': 'Languages',
  'Spanish': 'Languages',
  'Guitar': 'Music',
  'Piano': 'Music',
  'Sports': 'Sports',
  'Academic': 'Academic',
};

// Function: finds the category of a skill (case-insensitive), or 'Others'.
// Dart Functions, while loop, conditional operator
String categoryOf(String skill) {
  final wanted = skill.trim().toLowerCase();
  final entries = skillCategories.entries.toList();
  var i = 0;
  while (i < entries.length) {
    if (entries[i].key.toLowerCase() == wanted) return entries[i].value;
    i++;
  }
  return 'Others';
}

// Class: Model representing a student
// Dart Classes, final fields, data types (String, double, int, nullable String?)
class Student {
  final String name;
  final String department;
  final String teaches;
  final String wants;
  final double rating;
  final int reviews;
  final List<String> teachSkills;
  final List<String> learnSkills;
  final String bio;

  // Asset path of the avatar (nullable String?).
  // If null or empty, avatar displays the first letter of their name dynamically!
  final String? image;

  // const constructor with named and required parameters
  const Student({
    required this.name,
    required this.department,
    required this.teaches,
    required this.wants,
    required this.rating,
    this.reviews = 0,
    this.teachSkills = const [],
    this.learnSkills = const [],
    this.bio = 'Love coding, tech and learning new things. Let\'s exchange skills! 🚀',
    this.image,
  });

  // Getter: Extracts the first letter of the student's name for avatar fallback
  // Dart String indexing, toUpperCase(), conditional operator
  String get firstLetter =>
      name.trim().isNotEmpty ? name.trim()[0].toUpperCase() : '?';

  // Getter with arrow function (=>): category of the skill this student teaches
  String get category => categoryOf(teaches);

  // Record: both skills of a swap bundled in one value (Dart Records)
  (String, String) get skillPair => (teaches, wants);

  // Conditional operator: brand-new students show 'New', otherwise rating string
  String get ratingLabel => rating == 0 ? 'New' : '$rating';
}

