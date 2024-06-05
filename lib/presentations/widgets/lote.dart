import 'package:flutter/material.dart';

class LoteButton extends StatelessWidget {
  final String identificador;
  final bool isSelected;
  final Function()? onPressed;

  LoteButton({
    super.key,
    required this.identificador,
    required this.isSelected,
    required this.onPressed,
  });

  String getId(){
    return identificador;
  }


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isSelected ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.red[400] : Colors.green[300]
      ),
      child:  Text(identificador, style: const TextStyle(color: Colors.white),),
      
    );
  }
}