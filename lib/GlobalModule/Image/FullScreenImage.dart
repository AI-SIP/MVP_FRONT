import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FullScreenImage extends StatelessWidget {
  final String? imagePath;

  const FullScreenImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return InteractiveViewer(
              panEnabled: true,
              minScale: 1.0,
              maxScale: 3.0,
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imagePath == null
                        ? const AssetImage('assets/no_image.png')
                            as ImageProvider<Object>
                        : CachedNetworkImageProvider(imagePath!)
                            as ImageProvider<Object>,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
