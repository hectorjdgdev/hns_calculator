import 'package:flutter/material.dart';

class ItemRadio extends StatefulWidget {
  final String text;
  final bool isSelected;

  const ItemRadio({Key? key, required this.text, this.isSelected = false})
      : super(key: key);

  @override
  State<ItemRadio> createState() => _ItemRadioState();
}

class _ItemRadioState extends State<ItemRadio> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 8),
      padding: EdgeInsets.only(left: 16, right: 16),
      height: 56,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          border: Border.all(
            color: Color.fromRGBO(237, 243, 255, 1),
            width: 1,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 20,
                  color: widget.isSelected
                      ? Colors.black
                      : const Color.fromRGBO(158, 165, 178, 1),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Urbanist'),
            ),
          ),
          Radio(
              value: widget.isSelected,
              groupValue: widget.isSelected ? widget.isSelected : null,
              onChanged: (value) {})
        ],
      ),
    );
  }
}
