import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import '../models/exam.dart';
import '../services/exam_service.dart';
import 'add_exam_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Exam> _exams = [];

  @override
  void initState() {
    super.initState();
    _loadExams();
  }

  Future<void> _loadExams() async {
    final examService = Provider.of<ExamService>(context, listen: false);
    final exams = await examService.getExams();
    setState(() {
      _exams = exams;
    });
  }

  List<Exam> _getExamsForDay(DateTime day) {
    return _exams.where((exam) {
      return exam.dateTime.year == day.year &&
          exam.dateTime.month == day.month &&
          exam.dateTime.day == day.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Schedule'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            eventLoader: _getExamsForDay,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedDay != null
                  ? _getExamsForDay(_selectedDay!).length
                  : 0,
              itemBuilder: (context, index) {
                final exam = _getExamsForDay(_selectedDay!)[index];
                return ListTile(
                  title: Text(exam.subject),
                  subtitle: Text(
                    '${exam.dateTime.toString()} - ${exam.location}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddExamScreen(),
            ),
          );
          _loadExams();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}