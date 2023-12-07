part of './service.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> regis(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Extract the user ID from the userCredential
      String userId = userCredential.user?.uid ?? '';

      // Return a map with 'success' and 'userId' keys
      return {'success': true, 'userId': userId};
    } catch (e) {
      // Return a map with 'success' key set to false
      return {'success': false};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      final userId = user?.uid;

      debugPrint("Login Success");
      return {'success': true, 'userId': userId};
    } catch (e) {
      debugPrint("Login Failed");
      return {'success': false, 'userId': null};
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> deleteAccount(BuildContext context) async {
    // Show the confirmation dialog
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        ColorScheme scheme = Theme.of(context).colorScheme;
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          backgroundColor: scheme.background,
          shadowColor: scheme.onBackground,
          content: const Text("Are you sure you want to delete your account?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm deletion
              },
              child: const Text("Delete"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel deletion
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      // Create the controller outside the dialog
      TextEditingController inputController = TextEditingController();
      AuthCredential? credential;

      if (!context.mounted) return false;
      bool? continueDeletion = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          ColorScheme scheme = Theme.of(context).colorScheme;

          return AlertDialog(
            title: const Text("Confirm Deletion"),
            backgroundColor: scheme.background,
            shadowColor: scheme.onBackground,
            content: Column(
              children: [
                const Text("To proceed, enter your account Password :"),
                TextField(
                  controller: inputController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirmation",
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Cancel deletion
                  Navigator.of(context).pop(false);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  // Capture the credential for re-authentication
                  credential = EmailAuthProvider.credential(
                    email: _auth.currentUser?.email ?? '',
                    password: inputController.text,
                  );
                  Navigator.of(context).pop(true); // Continue deletion
                },
                child: const Text("Continue"),
              ),
            ],
          );
        },
      );

      if (continueDeletion == true) {
        try {
          if (!context.mounted) return false;
          UserData userData = Provider.of<UserData>(context, listen: false);
          try {
            await _auth.currentUser?.reauthenticateWithCredential(credential!);
          } on Exception catch (e) {
            debugPrint(e.toString());
            return false;
          }
          await _auth.currentUser?.delete();
          await signOut();
          if (!context.mounted) return false;
          userData.deleteDocument(documentId: userData.id!);
          userData.disposeVar();
          return true; // Return true if deleted successfully
        } catch (e) {
          // Handle errors during account deletion or re-authentication
          debugPrint("Account deletion failed: $e");
          rethrow;
        }
      } else {
        return false; // Return false if canceled
      }
    }

    return false; // Return false if canceled
  }
}
