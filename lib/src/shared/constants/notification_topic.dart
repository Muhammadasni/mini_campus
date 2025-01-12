import 'package:mini_campus/src/shared/extensions/index.dart';

import '../models/profile/student.dart';

const String notifyMsgApiKey = '';

/// get all relevent student topic based on student profile
/// 
/// todo: consider adding student uni / tertiary name as topic too

/// proper topics
///
/// [
///   gender,
///   all
///   dptCode,
///   faculty,
///   enrollment year - part 1 part 2...
/// ]
///
class NotificationTopic {
  final Student student;

  late List<String> _topics;

  NotificationTopic({required this.student}) {
    _topics = [];
    _computeTopics();
  }

  List<String> get topics => _topics;

  void _computeTopics() {
    _topics = ['all'];

    _topics.add(student.departmentCode);

    _topics.add(student.gender!);

    _topics.add(student.faculty);

    _topics.add(student.studentNumber!.studentNumber.stringYear);
  }
}
