enum DErrorComponent { Server, SDK, Database }

enum DRunErrorCode {
  // Network-related errors
  networkTimeout, // Timeout error for config requests
  networkConnectionFailed, // Connection failure (e.g., no internet connection)

  // http errors
  badResponse,
  badRequest,
  notFound,
  serverError,
  unauthorized,
  forbidden,
  invalidData,
  badCertificate,
  // Authentication|Account errors
  invalidCredentials, // Invalid credentials provided
  sessionExpired, // User session has expired
  noLoggedInUser,
  noUserDetailsFetchedFromServer,
  // noLoggedInUserOffline,
  accountDisabled,

  // Database-related errors
  noActiveDatabaseInstance, // Failed to connect to the database
  databaseConnectionFailed, // Failed to connect to the database
  databaseQueryFailed, // Database query failed
  databaseInternalError, // Internal database error
  // Generic errors
  unexpected, // General unknown error

  // Other potential categories can be added
  validationError, // Form validation error
  syncError, // Form validation error
  systemFileError, // Form validation error
  apiError, // Error during API interaction
}
