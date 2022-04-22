import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_campus/src/shared/services/log_console.dart';

import '../services/storage_service.dart';

class ItemImage extends ConsumerWidget {
  const ItemImage(
      {Key? key,
      this.img,
      this.size = 60.0,
      this.radius = 8.0,
      this.isNetwork = false})
      : super(key: key);

  final String? img;

  final double size;

  final double radius;

  final bool isNetwork;

  // 'assets/images/lost_n_found.png'
  final String dummyImg = 'assets/images/profile.png';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api = ref.read(lostFoundStorageProvider);

    return SizedBox(
      height: size,
      width: size,
      child: img == null
          ? Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(dummyImg),
                  fit: BoxFit.contain,
                  scale: 0.3,
                ),
              ),
            )
          : FutureBuilder(
              future: api.downloadItemImageFuture(img!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Uint8List? data = snapshot.data as Uint8List?;

                  return data == null
                      ? Container(
                          height: size,
                          width: size,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              color: Colors.white,
                              image: DecorationImage(
                                image: AssetImage(dummyImg),
                                fit: BoxFit.contain,
                                scale: 0.3,
                              )),
                        )
                      : Container(
                          height: size,
                          width: size,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius),
                            color: Colors.white,
                            image: DecorationImage(
                              image: MemoryImage(data),
                              fit: BoxFit.cover,
                              scale: 0.3,
                            ),
                          ),
                        );
                }

                if (snapshot.hasError) {
                  debugLogger('error loading LF item image');
                  return Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage(dummyImg),
                          fit: BoxFit.contain,
                          scale: 0.3,
                        )),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }
}
