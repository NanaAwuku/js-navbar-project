import 'package:flutter/material.dart';


enum DialogsAction { yes, cancel }

class AlertDialogs {
  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    Icon icon,
    String body,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: icon,
            content: Text(body),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pop(DialogsAction.cancel),
                child: Text(
                  'Cancel',
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                 
              ),
              ),
              ElevatedButton (
                onPressed: () => Navigator.of(context).pop(DialogsAction.yes),
                child: Text(
                  'Confirm',
                ),
                 style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  
              ),
              ),
            ],

          );
      
        },
        
        );
        return (action != null) ? action : DialogsAction.cancel;
  }
}

// Future<void> _showMyDialog() async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('AlertDialog Title'),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: const <Widget>[
//               Text('This is a demo alert dialog.'),
//               Text('Would you like to approve of this message?'),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Approve'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }