import 'package:flutter/material.dart';
import 'dart:async';
import 'screens/welcome_screen.dart';
import 'services/supabase_service.dart';
import 'services/department_service.dart';
import 'services/purpose_service.dart';
import 'services/course_service.dart';
import 'services/admin_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SupabaseService().initialize();
  await DepartmentService().initializeDefaultDepartments();
  await PurposeService().initializeDefaultPurposes();
  await CourseService().initializeDefaultCourses();
  AdminService().initializeDefaultAdmins();

  Timer.periodic(const Duration(minutes: 5), (timer) async {
    try {
      await SupabaseService().checkExpiredCountdowns();
      await SupabaseService().removeMissedEntriesFromLiveQueue();
      await SupabaseService().cleanupOldEntries();
    } catch (e) {
      print('Error in periodic cleanup: $e');
    }
  });

  runApp(const QueueManagementApp());
}

class QueueManagementApp extends StatelessWidget {
  const QueueManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Queue Management System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF263277),
          brightness: Brightness.light,
        ),
        fontFamily: 'Inter',
      ),
      home: const WelcomeScreen(),
    );
  }
}
