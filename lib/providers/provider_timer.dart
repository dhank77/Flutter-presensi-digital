import 'package:flutter/foundation.dart';

class ProviderTimer with ChangeNotifier{
  String _time = '00:00:01';

  set timer (String timer){
    _time = timer;
    notifyListeners();
  }
  String get timer => _time;
}

