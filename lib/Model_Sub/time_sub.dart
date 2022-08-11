import 'dart:convert';

class TimeModify {
  final String shopid;
  final String open;
  final String close;
  final String choose;
  TimeModify({
    required this.shopid,
    required this.open,
    required this.close,
    required this.choose,
  });

  TimeModify copyWith({
    String? shopid,
    String? open,
    String? close,
    String? choose,
  }) {
    return TimeModify(
      shopid: shopid ?? this.shopid,
      open: open ?? this.open,
      close: close ?? this.close,
      choose: choose ?? this.choose,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopid': shopid,
      'open': open,
      'close': close,
      'choose': choose,
    };
  }

  factory TimeModify.fromMap(Map<String, dynamic> map) {
    return TimeModify(
      shopid: map['shopid'] ?? '',
      open: map['open'] ?? '',
      close: map['close'] ?? '',
      choose: map['choose'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeModify.fromJson(String source) => TimeModify.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubTimeModel(shopid: $shopid, open: $open, close: $close, choose: $choose)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TimeModify &&
      other.shopid == shopid &&
      other.open == open &&
      other.close == close &&
      other.choose == choose;
  }

  @override
  int get hashCode {
    return shopid.hashCode ^
      open.hashCode ^
      close.hashCode ^
      choose.hashCode;
  }
}
