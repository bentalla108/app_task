// import 'dart:io';

// void generateReadme(String directory) {
//   File readmeFile = File('README.md');
//   StringBuffer readmeContent = StringBuffer();

//   readmeContent.writeln('# Structure du projet\n');

//   void traverseDirectory(Directory dir, [int level = 0]) {
//     String indent = ' ' * (level * 4);

//     readmeContent
//         .writeln('$indent* ${dir.path.split(Platform.pathSeparator).last}/');

//     List<FileSystemEntity> entities = dir.listSync();
//     for (var entity in entities) {
//       if (entity is File) {
//         readmeContent.writeln('$indent    * ${entity.uri.pathSegments.last}');
//       } else if (entity is Directory) {
//         traverseDirectory(entity, level + 1);
//       }
//     }
//   }

//   Directory rootDir = Directory(directory);
//   if (rootDir.existsSync()) {
//     traverseDirectory(rootDir);
//   } else {
//     print('Le répertoire spécifié n\'existe pas');
//     return;
//   }

//   readmeFile.writeAsStringSync(readmeContent.toString());
//   print('README.md généré avec succès!');
// }

// void main() {
//   generateReadme('.');
// }
