enum ResetPasswordResponse {
  ok,
  networkRequestFailed,
  userDisabled,
  userNotFound,
  tooManyRequests,
  unknown
}

ResetPasswordResponse stringToResetPasswordResponse(String code) {
  switch (code) {
    case 'user-disabled':
      return ResetPasswordResponse.userDisabled;
    case 'user-not-found':
      return ResetPasswordResponse.userNotFound;
    case 'network-request-failed':
      return ResetPasswordResponse.networkRequestFailed;
    case 'internal-error':
      return ResetPasswordResponse.tooManyRequests;
    default:
      return ResetPasswordResponse.unknown;
  }
}
