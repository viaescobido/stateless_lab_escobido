import 'package:flutter/material.dart';

void main() => runApp(const DirectoryApp());

// ---------------------------------------------------------------------------
// Data model
// ---------------------------------------------------------------------------

// Plain immutable data class: final fields + const constructor.
class Student {
  final String name;
  final String course;
  final int yearLevel;
  final String email;

  const Student({
    required this.name,
    required this.course,
    required this.yearLevel,
    required this.email,
  });
}

// Hard-coded sample data (replace with your own names if you like).
const List<Student> students = [
  Student(
    name: 'Via Escobido',
    course: 'BS Information Technology',
    yearLevel: 2,
    email: 'via.escobido@school.edu',
  ),
  Student(
    name: 'Vannesa Recio',
    course: 'BS Computer Science',
    yearLevel: 3,
    email: 'vannesa.recio@school.edu',
  ),
  Student(
    name: 'Djemnah Bagtasos',
    course: 'BS Information Systems',
    yearLevel: 1,
    email: 'djemnah.bagtasos@school.edu',
  ),
  Student(
    name: 'Julianna Paras',
    course: 'BS Computer Engineering',
    yearLevel: 4,
    email: 'julianna.paras@school.edu',
  ),
  Student(
    name: 'Ashley Ortiz',
    course: 'BS Information Technology',
    yearLevel: 2,
    email: 'ashley.ortiz@school.edu',
  ),
  Student(
    name: 'Fannie Dumpa',
    course: 'BS Data Science',
    yearLevel: 3,
    email: 'fannie.dumpa@school.edu',
  ),
];

// ---------------------------------------------------------------------------
// Widgets
// ---------------------------------------------------------------------------

// Stateless because the app only holds fixed settings (theme + home) and never changes by itself.
class DirectoryApp extends StatelessWidget {
  const DirectoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Directory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal, // CUSTOMIZATION 1: teal theme seed color
        useMaterial3: true,
      ),
      home: const DirectoryScreen(),
    );
  }
}

// Stateless because the screen just displays the hard-coded list; nothing on it changes.
class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Directory'),
        centerTitle: true, // CUSTOMIZATION 2: centered AppBar title
      ),
      body: ListView(
        padding: const EdgeInsets.all(
          16,
        ), // CUSTOMIZATION 3: roomier padding around the list
        children: [
          const SectionHeader(title: 'Students'),
          // One StudentCard per student in the list.
          for (final student in students) StudentCard(student: student),
        ],
      ),
    );
  }
}

// Stateless because it only displays the title it receives; a new title means the parent builds a new header.
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold, // bold heading
            color: Theme.of(context).colorScheme.primary, // colored heading
          ),
        ),
        const SizedBox(height: 4),
        const Divider(),
      ],
    );
  }
}

// Stateless because it only shows the Student passed in; if the data changes, the parent passes a new Student.
class StudentCard extends StatelessWidget {
  final Student student;

  const StudentCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16,
        ), // CUSTOMIZATION 4: rounded card corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor:
                  Colors.teal.shade700, // CUSTOMIZATION 5: custom avatar color
              foregroundColor: Colors.white,
              child: Text(
                student.name[0], // first letter of the name
                style: const TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(width: 16),
            // Expanded lets the text column use the remaining width (prevents overflow).
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight
                          .bold, // CUSTOMIZATION 6: bold, larger name style
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(student.course),
                  const SizedBox(height: 8),
                  InfoRow(
                    icon: Icons.school,
                    text: 'Year ${student.yearLevel}',
                  ),
                  const SizedBox(height: 4),
                  InfoRow(icon: Icons.email, text: student.email),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Stateless because it just draws the icon and text it is given and never changes on its own.
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 8), // small gap between icon and text
        Expanded(child: Text(text)), // Expanded avoids overflow on long emails
      ],
    );
  }
}
