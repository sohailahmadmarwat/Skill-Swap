// Model class representing a student in the Skill-Swap app
class Student {
  final String name;
  final String department;
  final String teaches;
  final String wants;
  final double rating;
  final String image;

  const Student({
    required this.name,
    required this.department,
    required this.teaches,
    required this.wants,
    required this.rating,
    required this.image,
  });
}
