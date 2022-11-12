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
  // 最大ファイル個数
  static const int maxFileNumbers = 3;
  static const int maxLibFileNumbers = 3;

  // エラーログファイル保存フォルダ
  static const String errorLogFolder = "log";
  // デバッグログファイル保存フォルダ
  static const String debugLogFolder = "debug";

  // デバッグログラベル
  static const String debugLogPrefix = "ALAPDebug_";
  // ログファイル名日付フォーマット
  static const String logFileDateFormat = "yyyyMMdd";
  // デバッグログ日付フォーマット
  static const String debugLogDateFormat = "yyyy-MM-dd HH:mm:ss.SSS";

  // ログ発生日付フォーマット
  static const String logDateFormat = "yyyy/MM/dd HH:mm:ss";

  // エラーログ1ファイルのリミットサイズ
  static const int errorLogFileLimit = (10 * 1024);
  // デバッグログ1ファイルのリミットサイズ
  static const int debugLogFileLimit = (1500 * 1024);

  // ログファイル名長
  static const int logFileNameLength = logFileDateFormat.length + '01'.length;

  // デバッグログファイル名長
  static const int debugLogFileNameLength =
      debugLogPrefix.length + logFileNameLength;

  // ファイル認識番号最大数
  static const int maxFileNameNumbers = 99;
  static const String storageDirAndroidLib = 'ocl';
  static const String storageDirIosLib = 'consoleLog';

  static LoggerManager? _instance;

  const LoggerManager._();

  factory LoggerManager() => _instance ??= const LoggerManager._();

  void destroyInstance() {
    //インスタンス破棄
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
      // 初回ログファイル作成
      file = File('${dir.path}/${_createFileName(isErrorLog, 1)}');
    } else {
      if (files.length < maxFileNumbers) {
        // 1ファイルある場合
        file = files[0];
      } else {
        // 2ファイルある場合
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
      // リミットを超える場合
      if (l > limitSizeFile) {
        if (oldFile != null && oldFile.existsSync()) {
          // 2ファイルある場合は古いファイルを削除する
          await oldFile.delete();
        }
        // 新規ログファイル作成
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
    // 何らかの理由で消せないファイルが出てきた場合に最新ログ2ファイルを取得する
    if (files.isNotEmpty && files.length > maxFileNumbers) {
      // ファイル名降順ソート
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

  /// ログファイル書き込み
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
