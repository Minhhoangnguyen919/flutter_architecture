import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:develop_app_hoangnm/core/enums/enums.dart';
import 'package:develop_app_hoangnm/core/utils/device_utils.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class LoggerManager {
  static const String folderALAP = "FolderElearning";
  static const String zipLogDateFormat = 'yyyyMMddHHmmss';
  static const String nameZipLogFile = "eLearningLog";
  static const String zipExt = ".zip";
  static const int maxFileNumbers = 3;
  static const int maxLibFileNumbers = 3;
  static const String errorLogFolder = "log";
  static const String debugLogFolder = "debug";
  static const String debugLogPrefix = "LOG_Debug_";
  static const String logFileDateFormat = "yyyyMMdd";
  static const String debugLogDateFormat = "yyyy-MM-dd HH:mm:ss.SSS";
  static const String logDateFormat = "yyyy/MM/dd HH:mm:ss";
  static const int errorLogFileLimit = (10 * 1024);
  static const int debugLogFileLimit = (1500 * 1024);
  static const int logFileNameLength = logFileDateFormat.length + '01'.length;
  static const int debugLogFileNameLength =
      debugLogPrefix.length + logFileNameLength;
  static const int maxFileNameNumbers = 99;
  static const String storageDirAndroidLib = 'ocl';
  static const String storageDirIosLib = 'consoleLog';

  static LoggerManager? _instance;

  const LoggerManager._();

  factory LoggerManager() => _instance ??= const LoggerManager._();

  void destroyInstance() {
    _instance = null;
  }

  void saveErrorLogFile({required String message}) {
    String logMessage = '${getNowDate(logDateFormat)}, [ERROR], $message';
    _saveLogFile(message: logMessage, isError: true);
  }

  void saveDebugLogFile({required String message}) {
    final debugLogDate = getNowDate(debugLogDateFormat);
    final logMessage = '$debugLogDate $message';
    _saveLogFile(message: logMessage, isError: false);
  }

  Future<void> _saveLogFile(
      {required String message, required bool isError}) async {
    Directory directory =
    await _createLogFolder(isError ? errorLogFolder : debugLogFolder);
    // ログフォルダが作成できない場合は、書き込まない
    File file = await _getLogFile(isError, directory, message);
    await _writeLogFile(file, message);
  }

  Future<File> _getLogFile(
      bool isErrorLog, Directory dir, String message) async {
    File? file;
    File? oldFile;
    final limitSizeFile = isErrorLog ? errorLogFileLimit : debugLogFileLimit;
    final List<File> files = await _filesInDirectory(dir);
    if (files.isEmpty) {
      file = File('${dir.path}/${_createFileName(isErrorLog, 1)}');
    } else {
      if (files.length < maxFileNumbers) {
        file = files[0];
      } else {
        File file1 = files[0];
        File file2 = files[1];
        final file1Name = _getNameFile(file1.path);
        final file2Name = _getNameFile(file2.path);
        final int startLength = isErrorLog ? 0 : debugLogPrefix.length;
        final int endLength =
        isErrorLog ? logFileNameLength : debugLogFileNameLength;
        int file1Num = int.parse(file1Name.substring(startLength, endLength));
        int file2Num = int.parse(file2Name.substring(startLength, endLength));
        if (file1Num >= file2Num) {
          if (file1Num == maxFileNameNumbers && file2Num == 1) {
            file = file2;
            oldFile = file1;
          } else {
            file = file1;
            oldFile = file2;
          }
        } else {
          if (file1Num == 1 && file2Num == maxFileNameNumbers) {
            file = file1;
            oldFile = file2;
          } else {
            file = file2;
            oldFile = file1;
          }
        }
      }

      String addString = '\n$message';
      int l = file.lengthSync() + addString.length;
      if (l > limitSizeFile) {
        if (oldFile != null && oldFile.existsSync()) {
          await oldFile.delete();
        }
        int newSeq = 1;
        final int startLength = isErrorLog ? 0 : debugLogPrefix.length;
        final int endLength = isErrorLog
            ? logFileDateFormat.length
            : debugLogPrefix.length + logFileDateFormat.length;
        if (_getNameFile(file.path).substring(startLength, endLength) ==
            getNowDate(logFileDateFormat)) {
          final int startLength = isErrorLog
              ? logFileDateFormat.length
              : debugLogPrefix.length + logFileDateFormat.length;
          final int endLength =
          isErrorLog ? logFileNameLength : debugLogFileNameLength;
          String seq =
          _getNameFile(file.path).substring(startLength, endLength);
          newSeq = int.parse(seq) + 1;
          if (newSeq > maxFileNameNumbers) {
            newSeq = 1;
          }
        }

        file = File('${dir.path}/${_createFileName(isErrorLog, newSeq)}');
      }
    }

    return file;
  }

  String _getNameFile(String path) {
    return path.split('/').last;
  }

  String _createFileName(bool isErrorLog, int seq) {
    String prefix = '';
    String fileExtension = '';
    if (isErrorLog) {
      fileExtension = '.txt';
    } else {
      prefix = debugLogPrefix;
      fileExtension = '.log';
    }
    return prefix +
        getNowDate(logFileDateFormat) +
        seq.toString().padLeft(2, '0') +
        fileExtension;
  }

  Future<List<File>> _filesInDirectory(Directory dir) async {
    List<File> files = <File>[];
    await for (FileSystemEntity entity
    in dir.list(recursive: true, followLinks: false)) {
      files.add(entity as File);
    }
    if (files.isNotEmpty && files.length > maxFileNumbers) {
      files.sort((file1, file2) =>
          _getNameFile(file2.path).compareTo(_getNameFile(file1.path)));
      files = files.sublist(0, maxFileNumbers);
    }
    return files;
  }

  Future<Directory> _createLogFolder(String folderName) async {
    final appDirectory = await getApplicationDocumentsDirectory();
    final String path = appDirectory.path;
    return await Directory('$path/$folderName').create(recursive: true);
  }

  Future<void> _writeLogFile(File file, String message) async {
    String logData = message;
    await file.exists().then((exists) {
      if (exists) logData = '\n$message';
    });
    List<int> logDataWithBom = [0xEF, 0xBB, 0xBF];
    logDataWithBom
        .addAll(Uint8List.fromList(const Utf8Encoder().convert(logData)));
    file.writeAsBytesSync(logDataWithBom, mode: FileMode.append);
  }

  String getNowDate(String format) {
    final formatter = DateFormat(format);
    return formatter.format(DateTime.now());
  }

  Future<List<FileSystemEntity>> getLogFiles(bool isErrorLog) async {
    Directory errorLogDirectory =
    await _createLogFolder(isErrorLog ? errorLogFolder : debugLogFolder);
    return _getFiles(errorLogDirectory, maxFileNumbers);
  }

  Future<List<FileSystemEntity>> getLibLogFiles() async {
    Directory appDirectory;
    if (DeviceUtils.currentBuildMode() == BuildMode.debug) {
      appDirectory = (Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory())!;
    } else {
      appDirectory = Platform.isAndroid
          ? await getApplicationSupportDirectory()
          : await getApplicationDocumentsDirectory();
    }
    String storageDirLib =
    Platform.isAndroid ? storageDirAndroidLib : storageDirIosLib;
    final Directory libraryLogFile =
    Directory('${appDirectory.path}/$storageDirLib');
    int fileNum = Platform.isAndroid ? maxLibFileNumbers : maxFileNumbers;
    return _getFiles(libraryLogFile, fileNum);
  }

  List<FileSystemEntity> _getFiles(Directory directory, int fileNum) {
    if (!directory.existsSync()) return [];
    List<FileSystemEntity> files = directory.listSync();
    if (files.length > fileNum) {
      files.sort(
              (f1, f2) => _getNameFile(f1.path).compareTo(_getNameFile(f2.path)));
      List<FileSystemEntity> fileOutput = [];
      for (int i = 0; i < fileNum; i++) {
        fileOutput.add(files[i]);
      }
      return fileOutput;
    }
    return files;
  }
}
