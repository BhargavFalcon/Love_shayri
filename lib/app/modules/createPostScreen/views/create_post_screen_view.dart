import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_post_screen_controller.dart';

class CreatePostScreenView extends GetView<CreatePostScreenController> {
  const CreatePostScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreatePostScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CreatePostScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
