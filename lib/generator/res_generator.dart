import 'dart:io';
import 'package:analyzer/dart/element/element.dart';
import 'package:flutter_res/annotation/res_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
/*
   * @auther Yuanshuai
   * @created at 5/29/21 1:30 PM
   * @desc 创建资源类
   */
class ImagesGenerator extends GeneratorForAnnotation<ImagesPath> {
  String _codeContent = '';
  String _pubspecContent = '';

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {

    var pubspecFile = File('pubspec.yaml');
    for (String pubspecLine in pubspecFile.readAsLinesSync()) {
      if (pubspecLine.trim() == 'assets:') continue;
      if (pubspecLine.trim().toUpperCase().endsWith('.PNG')) continue;
      if (pubspecLine.trim().toUpperCase().endsWith('.JPEG')) continue;
      if (pubspecLine.trim().toUpperCase().endsWith('.SVG')) continue;
      if (pubspecLine.trim().toUpperCase().endsWith('.JPG')) continue;
      _pubspecContent = "$_pubspecContent\n$pubspecLine";
    }

    _pubspecContent = '${_pubspecContent.trim()}\n\n  assets:';

    var imagePath = annotation.peek('path')?.stringValue;
    if (imagePath!.endsWith('/')) {
      imagePath = '$imagePath/';
    }

    var newClassName = annotation.peek('fileName')?.stringValue;

    handleFile(imagePath);

    pubspecFile.writeAsString(_pubspecContent);

    return '\nclass $newClassName{\n'
        '    $newClassName._();\n'
        '    $_codeContent\n'
        '}';
  }

  /*
   * @auther Yuanshuai
   * @created at 5/29/21 1:51 PM
   * @desc 扫描资源
   */
  void handleFile(String path) {
    var directory = Directory(path);

    for (var file in directory.listSync()) {
      var type = file.statSync().type;
      if (type == FileSystemEntityType.directory) {
        handleFile('${file.path}/');
      } else if (type == FileSystemEntityType.file) {
        var filePath = file.path;

        var keyName = filePath.trim().toUpperCase();
        if (!keyName.endsWith('.PNG') &&
            !keyName.endsWith('.JPEG') &&
            !keyName.endsWith('.GIF') &&
            !keyName.endsWith('.SVG') &&
            !keyName.endsWith('.JPG')) continue;

        var key = filePath
            .trim()
            .replaceAll(RegExp(path), '')
            .replaceAll(RegExp('.PNG'), '')
            .replaceAll(RegExp('.GIF'), '')
            .replaceAll(RegExp('.JPEG'), '')
            .replaceAll(RegExp('.SVG'), '')
            .replaceAll(RegExp('.JPG'), '')
            .replaceAll(RegExp('.png'), '')
            .replaceAll(RegExp('.gif'), '')
            .replaceAll(RegExp('.jpeg'), '')
            .replaceAll(RegExp('.svg'), '')
            .replaceAll(RegExp('.jpg'), '');

        key = variant(path, key);

        _codeContent =
            '$_codeContent\n\t\t\t\tstatic const $key = \'$filePath\';';

        _pubspecContent = '$_pubspecContent\n    - $filePath';
      }
    }
  }

  /*
   * @auther Yuanshuai
   * @created at 5/29/21 2:18 PM
   * 处理资源变体参考：
   * https://flutterchina.club/assets-and-images/
   * https://flutter.dev/docs/development/ui/assets-and-images
   */
  String variant(String path, String key) {
    if (path.contains('2.0x')) {
      key = key + '_xx';
    } else if (path.contains('3.0x')) {
      key = key + '_xxx';
    }else{
      key= key.replaceAll('/', '');
    }
    return key;
  }
}
