import 'package:flutter/material.dart';

class IconSelectionDialog extends StatelessWidget {
  final List<String> icons;
  final ValueChanged<int> onIconSelected;

  const IconSelectionDialog(
      {required this.icons, required this.onIconSelected});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Chọn một biểu tượng', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 16.0),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
              ),
              itemCount: icons.length,
              itemBuilder: (context, index) {
                final iconPath = icons[index];
                return GestureDetector(
                  onTap: () {
                    onIconSelected(index);
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(iconPath),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
