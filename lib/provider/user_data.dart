part of './provider.dart';

class UserData extends ChangeNotifier {
  String? _userId;
  UserClass? _data;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? get id => _userId;
  UserClass? get data => _data;

  set userId(String value) {
    _userId = value;
    notifyListeners();
  }

  Future<void> addUserToFirestore(String id, String email, String nama) async {
    try {
      CollectionReference users = _firestore.collection('users');
      DocumentReference documentReference = users.doc(id);

      Map<String, dynamic> data = {
        'email': email,
        'nama': nama,
        'favorite': [],
      };

      await documentReference.set(data);
      debugPrint('Added user with ID: $id');
    } catch (e) {
      debugPrint('Error adding user: $e');
    }
  }

  Future<void> updateField(String fieldName, dynamic newValue) async {
    try {
      // Reference to the document you want to update
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('users').doc(id);

      // Update the specified field with the new value
      await documentReference.update({fieldName: newValue});

      debugPrint('Document field updated successfully.');
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating document field: $e');
    }
  }

  Future<void> changePassword(String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      debugPrint('password has been changed');
      await user.updatePassword(newPassword);
    } else {
      debugPrint("password hasnt been changed");
      // No user is signed in.
    }
  }

  Future<void> getData() async {
    Map<String, dynamic>? userData = await _getDocumentData();
    _data = UserClass(
        nama: userData?['nama'],
        email: userData?['email'],
        favorite: List.from(userData?['favorite'] ?? []));
  }

  Future<Map<String, dynamic>?> _getDocumentData() async {
    try {
      // Reference to the Firestore collection
      CollectionReference<Map<String, dynamic>> collection =
          _firestore.collection('users');

      // Get the document snapshot
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await collection.doc(_userId).get();

      if (documentSnapshot.exists) {
        return documentSnapshot.data();
      } else {
        return null;
      }
    } catch (e) {
      // Handle errors
      debugPrint('Error getting document: $e');
      return null;
    }
  }

  void disposeVar() {
    _userId = null;
    _data = null;
  }
}
