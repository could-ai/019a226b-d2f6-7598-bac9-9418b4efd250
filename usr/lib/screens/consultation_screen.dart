import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/video_call_widget.dart';
import '../widgets/chat_widget.dart';
import '../providers/consultation_provider.dart';
import 'package:provider/provider.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  bool _isVideoOn = true;
  bool _isAudioOn = true;
  bool _isChatExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultation'),
        actions: [
          IconButton(
            icon: Icon(_isChatExpanded ? Icons.chat_bubble : Icons.chat_bubble_outline),
            onPressed: () => setState(() => _isChatExpanded = !_isChatExpanded),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: _isChatExpanded ? 2 : 3,
            child: _isVideoOn 
              ? const VideoCallWidget() 
              : Container(
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      'Video Off',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlButton(
                  icon: _isVideoOn ? Icons.videocam : Icons.videocam_off,
                  onPressed: () => setState(() => _isVideoOn = !_isVideoOn),
                  label: _isVideoOn ? 'Video On' : 'Video Off',
                ),
                _buildControlButton(
                  icon: _isAudioOn ? Icons.mic : Icons.mic_off,
                  onPressed: () => setState(() => _isAudioOn = !_isAudioOn),
                  label: _isAudioOn ? 'Mic On' : 'Mic Off',
                ),
                _buildControlButton(
                  icon: Icons.screen_share,
                  onPressed: () {},
                  label: 'Share Screen',
                ),
                ElevatedButton(
                  onPressed: () => context.go('/feedback'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('End Call'),
                ),
              ],
            ),
          ),
          if (_isChatExpanded) ...[
            const Divider(height: 1),
            Expanded(
              child: const ChatWidget(),
            ),
          ] else ...[
            SizedBox(
              height: 200,
              child: const ChatWidget(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, size: 32),
          onPressed: onPressed,
          tooltip: label,
        ),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}
