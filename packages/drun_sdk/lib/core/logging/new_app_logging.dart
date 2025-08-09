import 'dart:developer' as developer;

import 'package:d_sdk/core/exception/exception.dart';
import 'package:flutter/foundation.dart';

typedef LogWriterCallback = void Function(String message,
    {bool isError,
    required LogLevel level,
    Map<String, dynamic>? data,
    StackTrace? stackTrace,
    Object? source});

enum LogLevel { debug, info, error, warning }

/// Abstract logger interface for flexibility
abstract class LoggerInterface {
  bool isLogEnabled = kDebugMode;
  LogWriterCallback logWriter = defaultLogWriterCallback;

  void logDebug(String message,
      {Map<String, dynamic>? data, Object? source, StackTrace? stackTrace}) {
    _log(message,
        level: LogLevel.debug,
        data: data,
        source: source,
        stackTrace: stackTrace);
  }

  void logInfo(String message,
      {Map<String, dynamic>? data, Object? source, StackTrace? stackTrace}) {
    _log(message,
        level: LogLevel.info,
        data: data,
        source: source,
        stackTrace: stackTrace);
  }

  void logError(String message,
      {Map<String, dynamic>? data, Object? source, StackTrace? stackTrace}) {
    _log(message,
        level: LogLevel.error,
        isError: true,
        data: data,
        source: source,
        stackTrace: stackTrace);
  }

  void logWarning(String message,
      {Map<String, dynamic>? data, Object? source, StackTrace? stackTrace}) {
    _log(message,
        level: LogLevel.warning,
        data: data,
        source: source,
        stackTrace: stackTrace);
  }

  void _log(String message,
      {bool isError = false,
      required LogLevel level,
      Map<String, dynamic>? data,
      StackTrace? stackTrace,
      Object? source}) {
    if (isLogEnabled || level == LogLevel.error) {
      logWriter(message,
          isError: isError,
          level: level,
          data: data,
          stackTrace: stackTrace,
          source: source); // Pass structured data if available
    }
  }
}

/// Implementation of the logger
class AppLogger extends LoggerInterface {}

// Singleton logger instance
final AppLogger logger = AppLogger();

/// Default log writer using `developer.log`
void defaultLogWriterCallback(String message,
    {bool isError = false,
    required LogLevel level,
    Map<String, dynamic>? data,
    StackTrace? stackTrace,
    Object? source}) {
  final logMessage = StringBuffer()
    ..write(message)
    ..write(data != null ? ' | Data: ${data.toString()}' : '')
    ..write(source != null ? ' | Source: ${source.runtimeType}' : '');

  developer.log(logMessage.toString(),
      level: _mapLogLevelToDeveloperLevel(level),
      name: 'Datarun',
      stackTrace: stackTrace,
      error: isError ? source : null);
}

/// Maps custom LogLevel to `developer.log` levels
int _mapLogLevelToDeveloperLevel(LogLevel level) {
  switch (level) {
    case LogLevel.debug:
      return 500; // Fine-grained debug messages
    case LogLevel.info:
      return 800; // Informational messages
    case LogLevel.error:
      return 1000; // Error conditions
    default:
      return 0;
  }
}

/// Convenience methods for logging
void logDebug(String message,
    {Map<String, dynamic>? data, Object? source, StackTrace? stackTrace}) {
  logger.logDebug(message, data: data, source: source, stackTrace: stackTrace);
}

void logInfo(String message,
    {Map<String, dynamic>? data, Object? source, StackTrace? stackTrace}) {
  logger.logInfo(message, data: data, source: source, stackTrace: stackTrace);
}

void logError(String message,
    {Map<String, dynamic>? data, Object? source, StackTrace? stackTrace}) {
  logger.logError(message, data: data, source: source, stackTrace: stackTrace);
}

void logWarning(String message,
    {Map<String, dynamic>? data, Object? source, StackTrace? stackTrace}) {
  logger.logWarning(message,
      data: data, source: source, stackTrace: stackTrace);
}

void logException(DException exception,
    {Object? source, StackTrace? stackTrace}) {
  logger.logError(
    'Exception: ${exception.message}',
    data: {'error': exception.cause},
    source: source,
    stackTrace: stackTrace,
  );
}
