
class ZBSafe {


  static String getSafeString(Map map, String key, String defaultValue) {
    String val = map[key].toString();

    if (val.isEmpty) {
      if (defaultValue.isNotEmpty) {
        return defaultValue;
      }
      return "";
    }
    return val;
  }
}
