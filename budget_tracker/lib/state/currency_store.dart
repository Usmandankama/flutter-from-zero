import 'package:flutter/foundation.dart';

import '../services/rates_service.dart';
import '../utils/format.dart';

// Remembers whether to show naira or dollars, and today's rate.
class CurrencyStore extends ChangeNotifier {
  CurrencyStore(this._rates);

  final RatesService _rates;
  bool _showDollars = false;
  bool _isLoading = false;
  double? _nairaToDollar;

  bool get showDollars => _showDollars;
  bool get isLoading => _isLoading;

  // Every amount on screen goes through here, so one switch changes them all.
  String format(int naira) {
    final rate = _nairaToDollar;
    if (_showDollars && rate != null) {
      return formatDollars(naira * rate);
    }
    return formatNaira(naira);
  }

  // Switches currency. Returns false if today's rate couldn't be fetched.
  Future<bool> toggle() async {
    if (_showDollars) {
      _showDollars = false;
      notifyListeners();
      return true;
    }

    _isLoading = true;
    notifyListeners();
    try {
      _nairaToDollar = await _rates.nairaToDollar();
      _showDollars = true;
      return true;
    } catch (error) {
      // No internet, server down, or a reply we didn't expect.
      debugPrint('Could not fetch the exchange rate: $error');
      return false;
    } finally {
      // finally runs whether it worked or not.
      _isLoading = false;
      notifyListeners();
    }
  }
}
