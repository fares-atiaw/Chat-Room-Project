import 'package:flutter/material.dart';

class Category {
  static const String studyId = 'studyId';
  static const String examId = 'examId';
  static const String projectId = 'projectId';
  static const String entertainmentId = 'entertainmentId';
  static const String musicId = 'musicId';
  static const String movieId = 'movieId';
  static const String agreementId = 'agreementId';

  late String id;
  late IconData icon;
  late String title;

  Category(this.id, this.icon, this.title);

  Category.fromId(String c_id) {
    switch (c_id) {
      case studyId:
        id = studyId;
        icon = Icons.menu_book_sharp;
        title = 'Studying';
        break;
      case examId:
        id = examId;
        icon = Icons.paste_outlined;
        title = 'Exam';
        break;
      case projectId:
        id = projectId;
        icon = Icons.settings_applications_outlined;
        title = 'Project';
        break;
      case entertainmentId:
        id = entertainmentId;
        icon = Icons.palette_outlined;
        title = 'Entertainment';
        break;
      case musicId:
        id = musicId;
        icon = Icons.music_note_sharp;
        title = 'Music';
        break;
      case movieId:
        id = movieId;
        icon = Icons.movie_outlined;
        title = 'Movie';
        break;
      default:
        id = agreementId;
        icon = Icons.blur_circular_sharp;
        title = 'Agreement';
    }
  }

  static List<Category> getCategories() {
    return [
      Category.fromId(studyId),
      Category.fromId(examId),
      Category.fromId(projectId),
      Category.fromId(entertainmentId),
      Category.fromId(musicId),
      Category.fromId(movieId),
      Category.fromId(agreementId),
    ];
  }
}
