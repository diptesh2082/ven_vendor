import 'package:flutter/material.dart';

buildPrimaryButton(callBack, String title,
        {Color? color, bool? isWatchNow = false}) =>
    TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          color ?? const Color(0xffFFCA00),
        ),
      ),
      onPressed: callBack,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 65),
        child: isWatchNow!
            ? Row(
                children: [
                  const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )
                ],
              )
            : Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
              ),
      ),
    );
