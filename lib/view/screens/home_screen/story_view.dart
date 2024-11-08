
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StoryViewer extends StatefulWidget {
  final String imageUrl;
  final VoidCallback onClose;

  const StoryViewer({super.key, required this.imageUrl, required this.onClose});

  @override
  _StoryViewerState createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> {
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_progressValue < 1.0) {
        setState(() {
          _progressValue += 0.02;
        });
        _startProgress();
      } else {
        widget.onClose();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
          widget.onClose(); // Close on downward swipe
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned.fill(
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 40,
              left: 10,
              right: 10,
              child: Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: _progressValue,
                      color: Colors.white,
                      backgroundColor: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: widget.onClose,
                  ),
                ],
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapUp: (details) {
                final screenWidth = MediaQuery.of(context).size.width;
                if (details.localPosition.dx < screenWidth / 2) {
                  // Handle previous story
                  Fluttertoast.showToast(msg: "Previous story");
                } else {
                  // Handle next story
                  Fluttertoast.showToast(msg: "Next story");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}