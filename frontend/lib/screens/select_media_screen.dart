import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'select_music_screen.dart';

class SelectMediaScreen extends StatefulWidget {
  const SelectMediaScreen({super.key});

  @override
  State<SelectMediaScreen> createState() => _SelectMediaScreenState();
}

class _SelectMediaScreenState extends State<SelectMediaScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  Uint8List? _croppedImage;

  final GlobalKey _repaintKey = GlobalKey();
  Rect _cropRect = Rect.zero;
  Rect _imageBounds = Rect.zero;

  bool _isDraggingBox = false;
  Offset? _dragStart;
  bool _isResizing = false;
  String? _activeHandle;

  /// ✅ Pick image from gallery
  Future<void> _pickSinglePhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _croppedImage = null;
      });
    }
  }

  /// ✅ Crop and navigate to music screen
  Future<void> _chooseImage() async {
    final RenderRepaintBoundary boundary =
        _repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      final Uint8List fullImageData = byteData.buffer.asUint8List();
      final ui.Image fullImage = await decodeImageFromList(fullImageData);

      final double scaleX = fullImage.width / boundary.size.width;
      final double scaleY = fullImage.height / boundary.size.height;

      final Rect scaledCrop = Rect.fromLTWH(
        _cropRect.left * scaleX,
        _cropRect.top * scaleY,
        _cropRect.width * scaleX,
        _cropRect.height * scaleY,
      );

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      final paint = Paint();

      canvas.drawImageRect(
        fullImage,
        scaledCrop,
        Rect.fromLTWH(0, 0, _cropRect.width, _cropRect.height),
        paint,
      );

      final croppedImage = await recorder
          .endRecording()
          .toImage(_cropRect.width.toInt(), _cropRect.height.toInt());
      final croppedData =
          await croppedImage.toByteData(format: ui.ImageByteFormat.png);

      final croppedBytes = croppedData!.buffer.asUint8List();
      setState(() {
        _croppedImage = croppedBytes;
      });

      // ✅ Navigate to SelectMusicScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectMusicScreen(
            selectedImage: croppedBytes,
            onBack: () {
              // Keep crop tool active
              setState(() {});
            },
          ),
        ),
      );
    }
  }

  /// ✅ Crop interaction handlers
  void _onPanStart(DragStartDetails details) {
    const handleSize = 30.0;
    if ((details.localPosition - _cropRect.topLeft).distance < handleSize) {
      _isResizing = true;
      _activeHandle = "topLeft";
    } else if ((details.localPosition - _cropRect.topRight).distance < handleSize) {
      _isResizing = true;
      _activeHandle = "topRight";
    } else if ((details.localPosition - _cropRect.bottomLeft).distance < handleSize) {
      _isResizing = true;
      _activeHandle = "bottomLeft";
    } else if ((details.localPosition - _cropRect.bottomRight).distance < handleSize) {
      _isResizing = true;
      _activeHandle = "bottomRight";
    } else if (_cropRect.contains(details.localPosition)) {
      _isDraggingBox = true;
      _dragStart = details.localPosition;
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_isDraggingBox && _dragStart != null) {
      Offset delta = details.localPosition - _dragStart!;
      Rect moved = _cropRect.shift(delta);

      moved = Rect.fromLTWH(
        moved.left.clamp(_imageBounds.left, _imageBounds.right - moved.width),
        moved.top.clamp(_imageBounds.top, _imageBounds.bottom - moved.height),
        moved.width,
        moved.height,
      );

      setState(() {
        _cropRect = moved;
        _dragStart = details.localPosition;
      });
    } else if (_isResizing && _activeHandle != null) {
      Rect newRect = _cropRect;
      switch (_activeHandle) {
        case "topLeft":
          newRect = Rect.fromPoints(details.localPosition, _cropRect.bottomRight);
          break;
        case "topRight":
          newRect = Rect.fromPoints(
              Offset(_cropRect.left, details.localPosition.dy),
              Offset(details.localPosition.dx, _cropRect.bottom));
          break;
        case "bottomLeft":
          newRect = Rect.fromPoints(
              Offset(details.localPosition.dx, _cropRect.top),
              Offset(_cropRect.right, _cropRect.bottom));
          break;
        case "bottomRight":
          newRect = Rect.fromPoints(_cropRect.topLeft, details.localPosition);
          break;
      }

      if (_imageBounds.contains(newRect.topLeft) &&
          _imageBounds.contains(newRect.bottomRight)) {
        setState(() => _cropRect = newRect);
      }
    }
  }

  void _onPanEnd(DragEndDetails details) {
    _isDraggingBox = false;
    _isResizing = false;
    _activeHandle = null;
  }

  /// ✅ Back navigation behavior
  Future<bool> _onWillPop() async {
    if (_selectedImage != null) {
      setState(() => _croppedImage = null); // Stay in crop mode
      return true;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final buttonHeight = 70.0;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Select Media"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              if (await _onWillPop()) Navigator.pop(context);
            },
          ),
        ),
        body: _selectedImage == null
            ? Center(
                child: ElevatedButton(
                  onPressed: _pickSinglePhoto,
                  child: const Text("Pick Photo from Library"),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        _imageBounds =
                            Rect.fromLTWH(0, 0, constraints.maxWidth, constraints.maxHeight);

                        if (_cropRect == Rect.zero) {
                          _cropRect = _imageBounds; // Start crop full size
                        }

                        return Stack(
                          children: [
                            RepaintBoundary(
                              key: _repaintKey,
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            GestureDetector(
                              onPanStart: _onPanStart,
                              onPanUpdate: _onPanUpdate,
                              onPanEnd: _onPanEnd,
                              child: CustomPaint(
                                size: Size.infinite,
                                painter: _CropOverlayPainter(_cropRect),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  /// ✅ Buttons Row
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _pickSinglePhoto,
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, buttonHeight),
                              backgroundColor: const ui.Color.fromARGB(255, 255, 187, 109),
                              foregroundColor: Colors.black,
                            ),
                            child: const Text("Select Media"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _chooseImage,
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, buttonHeight),
                              backgroundColor: const ui.Color.fromARGB(255, 189, 130, 203),
                              foregroundColor: Colors.black,
                            ),
                            child: const Text("Choose"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _CropOverlayPainter extends CustomPainter {
  final Rect cropRect;
  _CropOverlayPainter(this.cropRect);

  @override
  void paint(Canvas canvas, Size size) {
    final overlayPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final path = Path.combine(
      PathOperation.difference,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
      Path()..addRect(cropRect),
    );
    canvas.drawPath(path, overlayPaint);

    final borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    canvas.drawRect(cropRect, borderPaint);

    // ✅ Grid lines
    final guidePaint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..strokeWidth = 1;
    final dx = cropRect.width / 3;
    final dy = cropRect.height / 3;
    for (int i = 1; i < 3; i++) {
      canvas.drawLine(
        Offset(cropRect.left + dx * i, cropRect.top),
        Offset(cropRect.left + dx * i, cropRect.bottom),
        guidePaint,
      );
      canvas.drawLine(
        Offset(cropRect.left, cropRect.top + dy * i),
        Offset(cropRect.right, cropRect.top + dy * i),
        guidePaint,
      );
    }

    // ✅ Corner handles
    const handleSize = 16.0;
    final handleBorder = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    final handleFill = Paint()..color = Colors.white;

    for (var corner in [
      cropRect.topLeft,
      cropRect.topRight,
      cropRect.bottomLeft,
      cropRect.bottomRight,
    ]) {
      canvas.drawCircle(corner, handleSize / 2, handleFill);
      canvas.drawCircle(corner, handleSize / 2, handleBorder);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

