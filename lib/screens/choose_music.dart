import 'package:flutter/material.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:file_picker/file_picker.dart';


Future<String?> chooseFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['mp3'],
      type: FileType.custom,
      allowMultiple: false,
  );
  if (result != null) {
    return result.files.single.path;
  }
  return null;
}

class Chooser extends StatelessWidget {
  const Chooser({super.key});

  @override
  Widget build(BuildContext context) {
    void navigate(String path) {
      context.router.pushNamed(
        Pages.mediaPlayer,
        extra: path
      );
    }

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => chooseFile().then((path) {
            if (path != null) {
              navigate(path);
            }
          }),
          child: Text(
            "Choose",
            style: context.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
