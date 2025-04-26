import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bookmarked_news_controller.dart';

class BookmarkedNewsView extends GetView<BookmarkedNewsController> {
  const BookmarkedNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookmarkedNewsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BookmarkedNewsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
