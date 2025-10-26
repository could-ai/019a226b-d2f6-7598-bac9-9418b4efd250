import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/video_call_widget.dart';
import '../widgets/chat_widget.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  bool _isVideoOn = false;
  bool _isAudioOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consultation')),
      body: Column(
        children: [
          Expanded(
            child: _isVideoOn ? const VideoCallWidget() : const Center(child: Text('Video call placeholder')),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(_isVideoOn ? Icons.videocam : Icons.videocam_off),
                  onPressed: () => setState(() => _isVideoOn = !_isVideoOn),
                ),
                IconButton(
                  icon: Icon(_isAudioOn ? Icons.mic : Icons.mic_off),
                  onPressed: () => setState(() => _isAudioOn = !_isAudioOn),
                ),
                ElevatedButton(
                  onPressed: () => context.go('/feedback'),
                  child: const Text('End Call'),
                ),
              ],
            ),
          ),
          const Expanded(child: ChatWidget()),
        ],
      ),
    );
  }
}
