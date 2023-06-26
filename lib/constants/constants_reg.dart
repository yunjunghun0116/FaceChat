RegExp kPhoneRegExp = RegExp('^(010|011|016|017|018|019)([0-9]{3,4})([0-9]{4})');
RegExp kPhoneDashRegExp = RegExp('^(010|011|016|017|018|019)-([0-9]{3,4})-([0-9]{4})');
RegExp kNickNameRegExp = RegExp(r'[ㄱ-ㅎ가-힣a-zA-Z]+$');
RegExp kPasswordRegExp = RegExp(r'[0-9a-zA-Z]{8}$');
RegExp kEmailRegExp = RegExp(
    r'[0-9a-z]([\-.\w]*[0-9a-z\-_+])*@([0-9a-z][\-\w]*[0-9a-z]\.)+[a-z]{2,9}');
RegExp kDomainRegExp = RegExp(
    '(http(s)?://)([a-z0-9w]+.*)+[a-z0-9]{2,4}/gi');
RegExp kBlankRegExp = RegExp('\n{2,}');
RegExp kMultiBlankRegExp = RegExp('\n{3,}');
