class MyFunction {
  String cutWord10(String name) {
    String result = name;
    if (result.length > 13) {
      result = result.substring(0, 10);
      result = '$result...';
    }
    return result;
  }
}
