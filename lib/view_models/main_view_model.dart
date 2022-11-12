import 'dart:io';

import 'package:develop_app_hoangnm/core/constants/constants.dart';
import 'package:develop_app_hoangnm/core/l10n/strings.dart';
import 'package:develop_app_hoangnm/core/plugin/file/logger_manager.dart';
import 'package:develop_app_hoangnm/core/plugin/file/zip_archive.dart';
import 'package:develop_app_hoangnm/core/utils/log_utils.dart';
import 'package:develop_app_hoangnm/ui/widgets/banners/flavor_config.dart';
import 'package:develop_app_hoangnm/view_models/base_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class MainViewModel extends BaseViewModel {
  Future<void> sendMailFeedback() async {
    final now = DateTime.now();
    String emailSubject =
        "[E - Learning][${DateFormat("yyyyMMdd-HHmmss").format(now)}] Feedback issues support.";
    String idFeedback =
        'ID Feedback [${DateFormat("yyyyMMdd-HHmmss").format(now)}]';
    String emailBody = idFeedback;
    final attachmentPaths = await _processZipFileLog();
    String emailSupport = FlavorConfig.instance!.supportMailAddress;
    String titleStr =
        '\n______________________________\nThis information will be used to respond for fix errors.\n______________________________\n\n';
    final Email email = Email(
      subject: emailSubject,
      body: '$titleStr$emailBody',
      recipients: [emailSupport],
      attachmentPaths: attachmentPaths.isEmpty ? [] : [attachmentPaths],
    );
    await FlutterEmailSender.send(email).catchError(
      (dynamic error) {
        LogUtils.d("Send mail error: $error");
        _onToastMessage();
      },
    );
  }

  Future<String> _processZipFileLog() async {
    List<String> paths = [];
    final errorLogFiles = await LoggerManager().getLogFiles(true);
    for (final file in errorLogFiles) {
      paths.add(file.path);
    }
    final debugLogFiles = await LoggerManager().getLogFiles(false);
    for (final file in debugLogFiles) {
      paths.add(file.path);
    }
    final libLogFiles = await LoggerManager().getLibLogFiles();
    for (final file in libLogFiles) {
      paths.add(file.path);
    }
    String zipPath = await _createZipPath();
    bool? isZip =
        await ZipArchie().zip(paths, zipPath).catchError((dynamic error) {
      LogUtils.d("[ERROR] zip failed $error");
    });
    if (isZip == null || !isZip) {
      return Constants.stringEmpty;
    }
    bool isFileExists = await File(zipPath).exists();
    if (isFileExists) {
      return zipPath;
    }
    return Constants.stringEmpty;
  }

  Future<String> _createZipPath() async {
    final appDirectory = await getApplicationSupportDirectory();
    final String path = appDirectory.path;
    final zipPath = await Directory('$path/${LoggerManager.folderALAP}')
        .create(recursive: true);
    String logDate = LoggerManager().getNowDate(LoggerManager.zipLogDateFormat);
    String zipFileName =
        '${LoggerManager.nameZipLogFile}$logDate${LoggerManager.zipExt}';
    return '${zipPath.path}/$zipFileName';
  }

  void _onToastMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(Strings.of(context)!.sendMailFailed),
      ),
    );
  }
}
