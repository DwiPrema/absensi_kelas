import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OcrService {
  Future<String?> extractText(String path) async {
    final inputImage = InputImage.fromFilePath(path);

    final textRecognizer = TextRecognizer();

    final result = await textRecognizer.processImage(inputImage);

    final cleanedText = result.text
    .split('\n')
    .map((e) => e.trim())
    .where((e) => e.isNotEmpty)
    .join('\n');

    return cleanedText;
  }
}
