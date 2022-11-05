import 'package:draw_your_image/draw_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final _drawingController = DrawController();
  late Color backgroundColor;
  late Color strokeColor;
  late double strokeWidth;
  late bool isErasing;

  @override
  void initState() {
    super.initState();
    backgroundColor = Colors.white;
    strokeColor = Colors.black;
    strokeWidth = 10;
    isErasing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                color: const Color(0xfff0f1f5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () => _drawingController.undo(),
                      icon: const FaIcon(FontAwesomeIcons.arrowLeft),
                    ),
                    IconButton(
                      onPressed: () => _drawingController.redo(),
                      icon: const FaIcon(FontAwesomeIcons.arrowRight),
                    ),
                    IconButton(
                      onPressed: () => _drawingController.clear(),
                      icon: const FaIcon(FontAwesomeIcons.xmark),
                    ),
                    IconButton(
                      onPressed: () => _drawingController.convertToImage(),
                      icon: const FaIcon(FontAwesomeIcons.solidFloppyDisk),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Draw(
                  controller: _drawingController,
                  backgroundColor: backgroundColor,
                  strokeColor: strokeColor,
                  strokeWidth: strokeWidth,
                  isErasing: isErasing,
                  onConvertImage: (imageData) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Column(
                            children: [
                              const SizedBox(height: 5),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  color: const Color(0xfff0f1f5),
                                  child: Image.memory(imageData),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff28282b),
                                ),
                                onPressed: () async {
                                  await ImageGallerySaver.saveImage(imageData);
                                  Future.delayed(
                                    Duration.zero,
                                    () => Navigator.pop(context),
                                  );
                                },
                                child: const Text('save'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                height: 100,
                padding: const EdgeInsets.all(16),
                color: const Color(0xfff0f1f5),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff28282b),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Background color'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('save'),
                                    ),
                                  ],
                                  content: BlockPicker(
                                    availableColors: const [
                                      Colors.white,
                                      Colors.black,
                                      Colors.blue,
                                      Colors.brown,
                                      Colors.green,
                                      Colors.grey,
                                      Colors.orange,
                                      Colors.pink,
                                      Colors.purple,
                                      Colors.red,
                                      Colors.yellow,
                                    ],
                                    pickerColor: backgroundColor,
                                    onColorChanged: (value) {
                                      setState(() {
                                        backgroundColor = value;
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                            icon: const FaIcon(
                              FontAwesomeIcons.fill,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Background',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Stroke color'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('save'),
                                    ),
                                  ],
                                  content: BlockPicker(
                                    availableColors: const [
                                      Colors.white,
                                      Colors.black,
                                      Colors.blue,
                                      Colors.brown,
                                      Colors.green,
                                      Colors.grey,
                                      Colors.orange,
                                      Colors.pink,
                                      Colors.purple,
                                      Colors.red,
                                      Colors.yellow,
                                    ],
                                    pickerColor: strokeColor,
                                    onColorChanged: (value) {
                                      setState(() {
                                        strokeColor = value;
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                            icon: const FaIcon(
                              FontAwesomeIcons.palette,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Stroke',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Stroke width'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('save'),
                                    ),
                                  ],
                                  scrollable: true,
                                  content: StatefulBuilder(
                                    builder: (context, setState) => Slider(
                                      activeColor: const Color(0xfff0f1f5),
                                      thumbColor: const Color(0xff28282b),
                                      value: strokeWidth,
                                      min: 1,
                                      max: 20,
                                      onChanged: (double value) {
                                        setState(() {
                                          strokeWidth = value;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                            ).then((value) {
                              setState(() {});
                            }),
                            icon: const FaIcon(
                              FontAwesomeIcons.ruler,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Width',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () => setState(() {
                              isErasing = !isErasing;
                            }),
                            icon: FaIcon(
                              FontAwesomeIcons.eraser,
                              color: isErasing ? Colors.grey : Colors.white,
                            ),
                          ),
                          const Text(
                            'Erase',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
