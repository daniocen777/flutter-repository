import 'package:flutter/material.dart';

class RequestFailed extends StatelessWidget {
  const RequestFailed({super.key, required this.onRetry, this.text});

  final VoidCallback onRetry;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Image.asset('assets/images/error-404.png')),
          Text(text ?? 'Request Failed'),
          const SizedBox(height: 10.0),
          MaterialButton(
            onPressed: onRetry,
            color: Colors.blueAccent,
            child: const Text('Retry'),
          ),
          const SizedBox(height: 10.0)
        ],
      ),
    );
  }
}
