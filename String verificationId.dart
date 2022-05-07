// String _verificationId = "";
// int? _resendToken;

// Future<bool> sendOTP({required String phone}) async {
//   await FirebaseAuth.instance.verifyPhoneNumber(
//     phoneNumber: phone,
//     verificationCompleted: (PhoneAuthCredential credential) {},
//     verificationFailed: (FirebaseAuthException e) {},
//     codeSent: (String verificationId, int? resendToken) async {
//       _verificationId = verificationId;
//       _resendToken = resendToken;
//     },
//     timeout: const Duration(seconds: 25),
//     forceResendingToken: _resendToken,
//     codeAutoRetrievalTimeout: (String verificationId) {
//       verificationId = _verificationId;
//     },
//   );
//   debugPrint("_verificationId: $_verificationId");
//   return true;
// }
