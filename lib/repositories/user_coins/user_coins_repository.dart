import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCoinsRepository {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  Future<double> getCoinAmount(String coinCode) async {
    final userId = _userId;
    if (userId == null) return 0.0;

    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('coins')
        .doc(coinCode)
        .get();

    if (doc.exists) {
      return (doc.data()?['amount'] as num?)?.toDouble() ?? 0.0;
    }
    return 0.0;
  }

  Future<void> setCoinAmount(String coinCode, double amount) async {
    final userId = _userId;
    if (userId == null) return;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('coins')
        .doc(coinCode)
        .set({'amount': amount});
  }

  Stream<double> coinAmountStream(String coinCode) {
    final userId = _userId;
    if (userId == null) return Stream.value(0.0);

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('coins')
        .doc(coinCode)
        .snapshots()
        .map((doc) => (doc.data()?['amount'] as num?)?.toDouble() ?? 0.0);
  }
}
