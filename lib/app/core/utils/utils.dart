import 'dart:convert';
import 'dart:io';

import 'package:dictionary/app/models/payload.dart';

class Utils {
  Utils._();

  static String getLocaleFromPlatform() => Platform.localeName.toString();

  static Payload readJwtPayload(String jwt) {
    var explodedJwt = jwt.split(".");
    var payload = jsonDecode(
      utf8.decode(
        base64.decode(
          base64.normalize(
            explodedJwt[1],
          ),
        ),
      ),
    );
    return Payload(
      id: payload['id'],
      username: payload['username'],
      iat: payload['iat'],
      exp: payload['exp'],
    );
  }

  static final listOptions = <Map<String, dynamic>>[
    {
      'label': 'All',
      'value': '',
    },
    {
      'label': 'A',
      'value': 'a',
    },
    {
      'label': 'B',
      'value': 'b',
    },
    {
      'label': 'C',
      'value': 'c',
    },
    {
      'label': 'D',
      'value': 'd',
    },
    {
      'label': 'E',
      'value': 'e',
    },
    {
      'label': 'F',
      'value': 'f',
    },
    {
      'label': 'G',
      'value': 'g',
    },
    {
      'label': 'H',
      'value': 'h',
    },
    {
      'label': 'I',
      'value': 'i',
    },
    {
      'label': 'J',
      'value': 'j',
    },
    {
      'label': 'K',
      'value': 'k',
    },
    {
      'label': 'L',
      'value': 'l',
    },
    {
      'label': 'M',
      'value': 'm',
    },
    {
      'label': 'N',
      'value': 'n',
    },
    {
      'label': 'O',
      'value': 'o',
    },
    {
      'label': 'P',
      'value': 'p',
    },
    {
      'label': 'Q',
      'value': 'q',
    },
    {
      'label': 'R',
      'value': 'r',
    },
    {
      'label': 'S',
      'value': 's',
    },
    {
      'label': 'T',
      'value': 't',
    },
    {
      'label': 'U',
      'value': 'u',
    },
    {
      'label': 'V',
      'value': 'v',
    },
    {
      'label': 'W',
      'value': 'w',
    },
    {
      'label': 'X',
      'value': 'x',
    },
    {
      'label': 'Y',
      'value': 'y',
    },
    {
      'label': 'Z',
      'value': 'z',
    },
  ];
}
