import 'dart:convert';
import 'package:shared_preferences.dart';
import '../models/exam.dart';

class ExamService {
  static const String _storageKey = 'exams';
  final SharedPreferences _prefs;

  ExamService(this._prefs);

  Future<List<Exam>> getExams() async {
    final String? examsJson = _prefs.getString(_storageKey);
    if (examsJson == null) return [];

    final List<dynamic> examsList = json.decode(examsJson);
    return examsList.map((e) => Exam.fromJson(e)).toList();
  }

  Future<void> saveExam(Exam exam) async {
    final exams = await getExams();
    exams.add(exam);
    await _saveExams(exams);
  }

  Future<void> deleteExam(String id) async {
    final exams = await getExams();
    exams.removeWhere((exam) => exam.id == id);
    await _saveExams(exams);
  }

  Future<void> _saveExams(List<Exam> exams) async {
    final String examsJson = json.encode(
      exams.map((e) => e.toJson()).toList(),
    );
    await _prefs.setString(_storageKey, examsJson);
  }
}