import 'package:flutter/material.dart';

import 'package:bee_note_application/pages/collaborator_page.dart';
import 'package:bee_note_application/pages/task_page.dart';
import 'package:bee_note_application/pages/home_page.dart';
import 'package:bee_note_application/pages/login_page.dart';
import 'package:bee_note_application/pages/project_page.dart';
import 'package:bee_note_application/pages/register_page_pt1.dart';
import 'package:bee_note_application/pages/register_page_pt2.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'login': ( _ ) => const LoginPage(),
  'register1': ( _ ) => const RegisterPage1(),
  'register2': ( _ ) => const RegisterPage2(),
  'home': ( _ ) => const HomePage(),
  'project': ( _ ) => const ProjectScreen(),
  'task': ( _ ) => const TaskPage(),
  'collaborator': ( _ ) => const CollaboratorPage(),
};