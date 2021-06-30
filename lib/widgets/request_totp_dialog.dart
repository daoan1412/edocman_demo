import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class _TotpInput extends StatelessWidget {
  final String label;
  final ValueChanged<String> onSubmitTotp;

  _TotpInput({
    Key? key,
    required this.label,
    required this.onSubmitTotp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.black54),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 6,
        ),
        TextFormField(
          autofocus: true,
          keyboardType: TextInputType.number,
          inputFormatters: [
            new LengthLimitingTextInputFormatter(6),
          ],
          onSaved: (value) {
            onSubmitTotp.call(value ?? "");
          },
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.black45),
            isDense: true,
            contentPadding:
                const EdgeInsets.only(bottom: 4, top: 5, left: 0, right: 0),
          ),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return "Không được để trống.";
            }
            return null;
          },
        ),
      ],
    );
  }
}

class TOTPInputDialog extends StatefulWidget {
  final String label;

  TOTPInputDialog({required this.label});

  @override
  _TOTPInputDialogState createState() => _TOTPInputDialogState();
}

class _TOTPInputDialogState extends State<TOTPInputDialog> {
  final formState = GlobalKey<FormState>();
  String? totp;

  contentBox(context) {
    final defaultSize = 20.0;
    return Container(
      padding: EdgeInsets.only(
          left: defaultSize * 1.5,
          top: defaultSize * 2,
          right: defaultSize * 1.5,
          bottom: defaultSize * 0.7),
      margin: EdgeInsets.only(top: 1.5 * defaultSize),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: formState,
            child: _TotpInput(
              label: widget.label,
              onSubmitTotp: (String value) {
                  totp = value;
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: Text("Đồng ý"),
                onPressed: () {
                  if (formState.currentState!.validate()) {
                    formState.currentState!.save();
                    Get.back(result: totp);
                  }
                },
              ),
              SizedBox(
                width: 16,
              ),
              TextButton(
                child: Text("Thoát"),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
}
