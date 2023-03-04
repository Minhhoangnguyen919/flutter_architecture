import 'package:develop_app_hoangnm/core/enums/enums.dart';
import 'package:develop_app_hoangnm/core/plugin/file/logger_manager.dart';

class LogUtils {

  static const bool logMode = true;

  LogUtils();

  static void methodIn({String message = ""}) {
    _outputLog(Level.trace, '[S]${_outputMessage(message)}', null);
  }

  static void methodOut({String message = ""}) {
    _outputLog(Level.trace, '[N]${_outputMessage(message)}', null);
  }

  static void d(String msg, {Exception? ex}) {
    _outputLog(Level.debug, _outputMessage(msg), ex);
  }

  static void i(String msg) {
    _outputLog(Level.info, _outputMessage(msg), null);
  }

  static void w(String msg) {
    _outputLog(Level.warn, _outputMessage(msg), null);
  }

  static void e(String msg) {
    _outputLog(Level.error, _outputMessage(msg), null);
  }

  static void _outputLog(Level level, String msg, Exception? ex) {
    String msgOut = msg;
    switch (level) {
      case Level.error:
        msgOut = 'E/$msg';
        break;
      case Level.warn:
        msgOut = 'W/$msg';
        break;
      case Level.info:
        msgOut = 'I/$msg';
        break;
      case Level.debug:
        msgOut = 'D/$msg';
        break;
      case Level.trace:
        msgOut = msg;
        break;
      default:
        break;
    }

    // TODO FIX Product
    // if (FlavorConfig.isDevelopment()) {
      // ignore: avoid_print
      print(msgOut);
    // }
    outputFileLog(level, msgOut);
  }

  static String _outputMessage(String msg) {
    String stackTrace = StackTrace.current.toString();
    String topStack = stackTrace.split("#2")[1];
    String fileInfo = topStack
        .substring(topStack.indexOf("package"), topStack.indexOf(")"))
        .trim();
    String methodName = topStack.substring(0, topStack.indexOf("(")).trim();
    return '[$methodName]::$msg  <$fileInfo>';
  }

  static void outputFileLog(Level level, String msg) {
    switch (level) {
      case Level.error:
      case Level.warn:
      case Level.info:
      case Level.debug:
        LoggerManager().saveDebugLogFile(message: msg);
        break;
      case Level.trace:
        break;
      default:
        break;
    }
  }
}
