import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class AdminInitPage extends StatelessWidget {
  final String? error;
  final VoidCallback func;

  const AdminInitPage({super.key, this.error, required this.func});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: AppColors.lightGrey,
            thickness: 1,
          ),
        ),
        toolbarHeight: 80,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              "Users",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 16),
            Text(
              error ?? "An unexpected error occurred.",
              style: const TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: func,
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }
}
