/// Generated file. Do not edit.
///
/// Locales: 3
/// Strings: 288 (96 per locale)
///
/// Built on 2023-07-30 at 03:07 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, _StringsEn> {
	en(languageCode: 'en', build: _StringsEn.build),
	zhHans(languageCode: 'zh', scriptCode: 'Hans', build: _StringsZhHans.build),
	zhHant(languageCode: 'zh', scriptCode: 'Hant', build: _StringsZhHant.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, _StringsEn> build;

	/// Gets current instance managed by [LocaleSettings].
	_StringsEn get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_StringsEn get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _StringsEn of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context).translations;
}

/// The provider for method B
class TranslationProvider extends BaseTranslationProvider<AppLocale, _StringsEn> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, _StringsEn> of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	_StringsEn get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, _StringsEn> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, _StringsEn> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class _StringsEn implements BaseTranslations<AppLocale, _StringsEn> {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final _StringsEn _root = this; // ignore: unused_field

	// Translations
	String get or => 'or';
	String get numberRegistered => 'This number is already registered, please use the number to log in';
	String get UserNotRegistered => 'No matching user information found, please check your input';
	String get PwsNotMatch => 'Incorrect password, please check and try again';
	String get contactIsBlocked => 'The user has been blacklisted by you and cannot be added now';
	String get contactExists => 'Contact already exists, no need to add';
	String get you => 'you';
	String get cancel => 'Cancel';
	String get ok => 'Ok';
	String get next => 'Next';
	String get skip => 'Skip';
	String get start => 'Start';
	late final _StringsWelcomeEn welcome = _StringsWelcomeEn._(_root);
	late final _StringsRegularEn regular = _StringsRegularEn._(_root);
	late final _StringsLoginEn login = _StringsLoginEn._(_root);
	late final _StringsErrorEn error = _StringsErrorEn._(_root);
	late final _StringsMessageEn message = _StringsMessageEn._(_root);
	late final _StringsContactEn contact = _StringsContactEn._(_root);
	late final _StringsAccountEn account = _StringsAccountEn._(_root);
	late final _StringsSettingEn setting = _StringsSettingEn._(_root);
	late final _StringsFlexSchemeEn FlexScheme = _StringsFlexSchemeEn._(_root);
}

// Path: welcome
class _StringsWelcomeEn {
	_StringsWelcomeEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get screen2 => 'Share the surrounding, Immerse yourself';
	String get screen3 => 'Message schedule, Contact anytime';
	String get addFriend => 'Add contacts';
	String get scanQrcode => 'Scan QRcode';
	String get rules => 'By clicking Register, you agree to accept our Terms of Service, Privacy Policy and Cookie Policy';
}

// Path: regular
class _StringsRegularEn {
	_StringsRegularEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get reStart => 'Restart';
	String get reStartRequire => 'App needs to be restarted';
	String get locationPermission => 'Permission to access location';
	String get locationPermissionDesc => 'TimeCept needs your consent to use the special location,App can help you  share your location with your chat partner, so that you can discover entertainment information around you.TimeCept respects the user\'s privacy and never save the user\'s location  at any time and anywhere';
	String get locationPermissionRefuse => 'If you decline, it means that in the chat, the shared location function will not be available';
}

// Path: login
class _StringsLoginEn {
	_StringsLoginEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get welcome => 'Hello friend,\nWelcome Back';
	String get makeAccount => 'Hello,friend,\nCreate Account';
	String get login => 'Log In';
	String get signUp => 'Sign Up';
	String get tel => 'Telephone number';
	String get name => 'Name';
	String get pws => 'Password';
	String get pwsAgain => 'Reenter password';
	String get haveAccount => 'Already have an account? ';
	String get noAccount => 'Don\'t have an account? ';
	String get forget => 'Forgot Password?';
	String get registerDone => 'Register successfully, you are welcome';
}

// Path: error
class _StringsErrorEn {
	_StringsErrorEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get invalidNumber => 'invalid mobile number';
	String get pwsNotMatch => 'The two entered passwords do not match,please check';
	String get invalidNameLegth => 'Name length should be between 2 and 24 characters';
	String get pwsIsTooSimple => 'Password should be longer than 8 characters, contain at least one letter and at least one digital';
}

// Path: message
class _StringsMessageEn {
	_StringsMessageEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get message => 'Message';
	String get contact => 'Contact';
	String get surrounding => 'Location';
	String get myself => 'Me';
	String get send => 'Send';
	String shareLocation({required Object person}) => '${person} got your location';
	String get notShareLocation => 'Disable share location';
	String get shareingLocation => 'is sharing his location with you';
	String get deleteLocal => 'Only delete message from your App';
	String get deleteAll => 'Delete this message from all users\' Apps';
	String delFrom({required Object from}) => 'Are you sure to delete the message from ${from}';
	String get confirmDel => 'Are you sure to delete the message';
	String get hello => 'The strange user is greeting you, this is his/her tel';
	String get forward => 'Select a chat to forward';
	String get chatList => 'Recent chats';
}

// Path: contact
class _StringsContactEn {
	_StringsContactEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get newContact => 'Add Contact';
	String get inputNumber => 'Please input contact phone number';
	String get add => 'Add to address book';
	String get block => 'Refuse';
	String get foundUser => 'Found user';
	String get done => 'Add successfully';
	String get message => 'Send Message';
	String get remove => 'Remove';
	String get addRequirement => 'The sender is not in your address book';
	String get deleteConfirm => 'Are you sure to delete this contact? This will delete all conversations between you at the same time';
}

// Path: account
class _StringsAccountEn {
	_StringsAccountEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get noDisturbSchedule => 'Do not disturb schedule';
	String get surrond => 'Nearby and location';
	String get setting => 'Setting';
}

// Path: setting
class _StringsSettingEn {
	_StringsSettingEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get theme => 'Select theme';
	String get language => 'Language';
	String get aboutUs => 'About application';
	String get exit => 'Log out';
	String get confirmToExit => 'Are you sure to quit? Couldn\'t receive any messages after logging out';
	String get unregister => 'Permanent cancellation (deregistration)';
	String get unregisterMessage => 'Delete all registration and user information related to me from the system';
	String get privateAndSafety => 'Privacy and security';
	String get cleanLocal => 'Clean up local data';
	String get cleanLocalExplan => 'Clean up the data saved on your phone and save only the last month\'s data';
	String get cleanLocalConfirm => 'Are you sure you want to delete locally saved data? This action cannot be undone';
	String get unregisterConfirm => 'Are you sure you want to sign out permanently? This action cannot be revoked, and if you choose OK, your registration and user information will be deleted within a maximum of 24 hours';
}

// Path: FlexScheme
class _StringsFlexSchemeEn {
	_StringsFlexSchemeEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get bahamaBlue => 'Bahama Blue';
	String get hippieBlue => 'Hippie Blue';
	String get money => 'Dollars Green';
	String get redWine => 'Red Wine';
	String get mango => 'Mango';
	String get greyLaw => 'Grey Law';
	String get shark => 'Shark';
	String get vesuviusBurn => 'Vesuvius Burn';
	String get deepPurple => 'Deep Purple';
	String get espresso => 'Espresso';
	String get deepBlue => 'Deep Blue Sea';
	String get jungle => 'Jungle';
	String get ebonyClay => 'Ebony Clay';
	String get brandBlue => 'Brand Blue';
	String get gold => 'Gold';
	String get indigo => 'Indigo Night';
	String get outerSpace => 'Outer Space';
	String get barossa => 'Barossa';
}

// Path: <root>
class _StringsZhHans implements _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsZhHans.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zhHans,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-Hans>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsZhHans _root = this; // ignore: unused_field

	// Translations
	@override String get or => '或者';
	@override String get numberRegistered => '此号码已经注册，请直接登录';
	@override String get UserNotRegistered => '未找到匹配的用户信息，请检查您的输入';
	@override String get PwsNotMatch => '密码错误，请核对后再试';
	@override String get contactIsBlocked => '该用户已经被你列入黑名单，暂时无法添加';
	@override String get contactExists => '联系人已存在，无需添加';
	@override String get you => '您';
	@override String get cancel => '放弃';
	@override String get ok => '确定';
	@override String get next => '下一步';
	@override String get skip => '跳过';
	@override String get start => '开始';
	@override late final _StringsWelcomeZhHans welcome = _StringsWelcomeZhHans._(_root);
	@override late final _StringsRegularZhHans regular = _StringsRegularZhHans._(_root);
	@override late final _StringsLoginZhHans login = _StringsLoginZhHans._(_root);
	@override late final _StringsErrorZhHans error = _StringsErrorZhHans._(_root);
	@override late final _StringsMessageZhHans message = _StringsMessageZhHans._(_root);
	@override late final _StringsContactZhHans contact = _StringsContactZhHans._(_root);
	@override late final _StringsAccountZhHans account = _StringsAccountZhHans._(_root);
	@override late final _StringsSettingZhHans setting = _StringsSettingZhHans._(_root);
	@override late final _StringsFlexSchemeZhHans FlexScheme = _StringsFlexSchemeZhHans._(_root);
}

// Path: welcome
class _StringsWelcomeZhHans implements _StringsWelcomeEn {
	_StringsWelcomeZhHans._(this._root);

	@override final _StringsZhHans _root; // ignore: unused_field

	// Translations
	@override String get screen2 => '共享周边，身临其境';
	@override String get screen3 => '预约发送，随时联系';
	@override String get addFriend => '新增联系人';
	@override String get scanQrcode => '扫码';
	@override String get rules => '点击注册，即表示你同意接受我们的服务条款、隐私政策和 Cookie 政策';
}

// Path: regular
class _StringsRegularZhHans implements _StringsRegularEn {
	_StringsRegularZhHans._(this._root);

	@override final _StringsZhHans _root; // ignore: unused_field

	// Translations
	@override String get reStart => '重启';
	@override String get reStartRequire => 'App需要重新启动';
	@override String get locationPermission => '获取位置信息权限许可';
	@override String get locationPermissionDesc => 'TimeCept希望你能同意使用特定的位置，TimeCept有一个核心功能可以与聊天对象共享位置,方便互相发现周边的娱乐信息。TimeCept尊重用户的隐私，不会在任何时候任何位置保存用户的位置信息';
	@override String get locationPermissionRefuse => '如果拒绝就意味着在聊天中，共享位置功能将不能使用，此功能可以再稍后再打开';
}

// Path: login
class _StringsLoginZhHans implements _StringsLoginEn {
	_StringsLoginZhHans._(this._root);

	@override final _StringsZhHans _root; // ignore: unused_field

	// Translations
	@override String get welcome => '朋友\n欢迎回来';
	@override String get makeAccount => '请创建你的账户\n开始使用timeCept';
	@override String get login => '登录';
	@override String get signUp => '注册';
	@override String get haveAccount => '已经注册过了? ';
	@override String get noAccount => '还没有注册? ';
	@override String get tel => '电话';
	@override String get name => '称呼';
	@override String get pws => '密码';
	@override String get forget => '忘记密码?';
	@override String get pwsAgain => '再次输入密码';
	@override String get registerDone => '注册成功，欢迎使用';
}

// Path: error
class _StringsErrorZhHans implements _StringsErrorEn {
	_StringsErrorZhHans._(this._root);

	@override final _StringsZhHans _root; // ignore: unused_field

	// Translations
	@override String get invalidNumber => '不正确的电话号码';
	@override String get pwsNotMatch => '两次输入的密码不一致，请检查';
	@override String get invalidNameLegth => '名称长度应该在2到24个字符之间';
	@override String get pwsIsTooSimple => '密码长度至少应该超过8位，包括至少一个数字和一个字母';
}

// Path: message
class _StringsMessageZhHans implements _StringsMessageEn {
	_StringsMessageZhHans._(this._root);

	@override final _StringsZhHans _root; // ignore: unused_field

	// Translations
	@override String get message => '消息';
	@override String get contact => '通讯录';
	@override String get surrounding => '周边与定位';
	@override String get myself => '我';
	@override String get send => '发送';
	@override String shareLocation({required Object person}) => '与${person}共享你的位置';
	@override String get notShareLocation => '停止分享';
	@override String get shareingLocation => '正在与您共享他的位置';
	@override String get deleteLocal => '仅删除您程序中的信息';
	@override String get deleteAll => '从所有用户App中删除这条信息';
	@override String delFrom({required Object from}) => '你确定要删除来自的${from}信息吗';
	@override String get confirmDel => '你确定要删除这条信息吗';
	@override String get hello => '陌生用户正在和你打招呼,他的电话是';
	@override String get forward => '选择一个聊天，转发消息';
	@override String get chatList => '最近的聊天';
}

// Path: contact
class _StringsContactZhHans implements _StringsContactEn {
	_StringsContactZhHans._(this._root);

	@override final _StringsZhHans _root; // ignore: unused_field

	// Translations
	@override String get newContact => '新增联系人';
	@override String get inputNumber => '请输入联系人电话';
	@override String get add => '添加到通讯录';
	@override String get block => '拒絕';
	@override String get foundUser => '找到用户';
	@override String get done => '添加完成';
	@override String get message => '发送信息';
	@override String get remove => '删除';
	@override String get addRequirement => '发送者不在您的通讯录内';
	@override String get deleteConfirm => '确定要删除此联络人吗？该操作将同时删除你们之间所有的对话';
}

// Path: account
class _StringsAccountZhHans implements _StringsAccountEn {
	_StringsAccountZhHans._(this._root);

	@override final _StringsZhHans _root; // ignore: unused_field

	// Translations
	@override String get noDisturbSchedule => '免打扰时间表设置';
	@override String get surrond => '周边与定位设置';
	@override String get setting => '系统设置';
}

// Path: setting
class _StringsSettingZhHans implements _StringsSettingEn {
	_StringsSettingZhHans._(this._root);

	@override final _StringsZhHans _root; // ignore: unused_field

	// Translations
	@override String get language => '语言';
	@override String get theme => '选择主题';
	@override String get aboutUs => '应用信息';
	@override String get exit => '退出';
	@override String get confirmToExit => '确定要退出吗？退出以后无法收到任何信息';
	@override String get unregister => '永久注销(取消注册)';
	@override String get unregisterMessage => '从系统中删除所有与我相关的注册及用户信息';
	@override String get privateAndSafety => '隐私与安全设置';
	@override String get cleanLocal => '清理本地数据';
	@override String get cleanLocalExplan => '清理手机上保存的数据，系统仅仅保存最近一个月的数据';
	@override String get cleanLocalConfirm => '确定要删除本地保存的数据吗？此操作不可以撤销';
	@override String get unregisterConfirm => '确定要永久注销吗？此操作不可以撤销,如果选择确定，您的注册及用户信息将在最多24小时内被删除';
}

// Path: FlexScheme
class _StringsFlexSchemeZhHans implements _StringsFlexSchemeEn {
	_StringsFlexSchemeZhHans._(this._root);

	@override final _StringsZhHans _root; // ignore: unused_field

	// Translations
	@override String get bahamaBlue => 'Bahama Blue';
	@override String get hippieBlue => 'Hippie Blue';
	@override String get money => 'Dollars Green';
	@override String get redWine => 'Red Wine';
	@override String get mango => 'Mango';
	@override String get greyLaw => 'Grey Law';
	@override String get shark => 'Shark';
	@override String get vesuviusBurn => 'Vesuvius Burn';
	@override String get deepPurple => 'Deep Purple';
	@override String get espresso => 'Espresso';
	@override String get deepBlue => 'Deep Blue Sea';
	@override String get jungle => 'Jungle';
	@override String get ebonyClay => 'Ebony Clay';
	@override String get brandBlue => 'Brand Blue';
	@override String get gold => 'Gold';
	@override String get indigo => 'Indigo Night';
	@override String get outerSpace => 'Outer Space';
	@override String get barossa => 'Barossa';
}

// Path: <root>
class _StringsZhHant implements _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsZhHant.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zhHant,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-Hant>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsZhHant _root = this; // ignore: unused_field

	// Translations
	@override String get or => '或者';
	@override String get numberRegistered => '此號碼已經註冊，請直接登錄';
	@override String get UserNotRegistered => '未找到匹配的用戶信息，請檢查您的輸入';
	@override String get PwsNotMatch => '密碼錯誤，請核對後再試';
	@override String get contactIsBlocked => '該用戶已經被你列入黑名單，暫時無法添加';
	@override String get contactExists => '聯繫人已存在，無需添加';
	@override String get you => '您';
	@override String get cancel => '放弃';
	@override String get ok => '确定';
	@override String get next => '下一步';
	@override String get skip => '跳過';
	@override String get start => '開始';
	@override late final _StringsRegularZhHant regular = _StringsRegularZhHant._(_root);
	@override late final _StringsWelcomeZhHant welcome = _StringsWelcomeZhHant._(_root);
	@override late final _StringsLoginZhHant login = _StringsLoginZhHant._(_root);
	@override late final _StringsErrorZhHant error = _StringsErrorZhHant._(_root);
	@override late final _StringsMessageZhHant message = _StringsMessageZhHant._(_root);
	@override late final _StringsContactZhHant contact = _StringsContactZhHant._(_root);
	@override late final _StringsAccountZhHant account = _StringsAccountZhHant._(_root);
	@override late final _StringsSettingZhHant setting = _StringsSettingZhHant._(_root);
	@override late final _StringsFlexSchemeZhHant FlexScheme = _StringsFlexSchemeZhHant._(_root);
}

// Path: regular
class _StringsRegularZhHant implements _StringsRegularEn {
	_StringsRegularZhHant._(this._root);

	@override final _StringsZhHant _root; // ignore: unused_field

	// Translations
	@override String get reStart => '重啟';
	@override String get reStartRequire => 'App需要重新啟動';
	@override String get locationPermission => '位置信息權限許可';
	@override String get locationPermissionDesc => 'TimeCept希望你能同意使用特定的位置，TimeCept有一個核心功能可以與聊天對象共用位置，方便互相發現周邊的娛樂資訊。 TimeCept尊重用戶的隱私，不會在任何時候任何位置保存使用者的位置資訊';
	@override String get locationPermissionRefuse => '如果拒絕就意味著在聊天中，共享位置功能將不能使用';
}

// Path: welcome
class _StringsWelcomeZhHant implements _StringsWelcomeEn {
	_StringsWelcomeZhHant._(this._root);

	@override final _StringsZhHant _root; // ignore: unused_field

	// Translations
	@override String get screen2 => '共用周邊，身臨其境';
	@override String get screen3 => '預約發送，隨時聯繫';
	@override String get addFriend => '新增聯繫人';
	@override String get scanQrcode => '掃碼';
	@override String get rules => '點擊注册，即表示你同意接受我們的條款、隱私權政策和 Cookie 政策';
}

// Path: login
class _StringsLoginZhHant implements _StringsLoginEn {
	_StringsLoginZhHant._(this._root);

	@override final _StringsZhHant _root; // ignore: unused_field

	// Translations
	@override String get welcome => '朋友\n歡迎回來';
	@override String get makeAccount => '請創建你的帳戶\n開始使用timeCept';
	@override String get login => '登錄';
	@override String get signUp => '註冊';
	@override String get haveAccount => '已經註冊過了? ';
	@override String get noAccount => '還沒有註冊? ';
	@override String get tel => '電話';
	@override String get name => '稱呼';
	@override String get pws => '密碼';
	@override String get pwsAgain => '再次輸入密碼';
	@override String get forget => '忘記密碼?';
	@override String get registerDone => '註冊成功，歡迎使用';
}

// Path: error
class _StringsErrorZhHant implements _StringsErrorEn {
	_StringsErrorZhHant._(this._root);

	@override final _StringsZhHant _root; // ignore: unused_field

	// Translations
	@override String get invalidNumber => '不正確的電話號碼';
	@override String get pwsNotMatch => '兩次輸入的密碼不一致，請檢查';
	@override String get invalidNameLegth => '名稱長度應該在2到24個字元之間';
	@override String get pwsIsTooSimple => '密碼長度至少應該超過8位元，包括至少一個數位和一個字母';
}

// Path: message
class _StringsMessageZhHant implements _StringsMessageEn {
	_StringsMessageZhHant._(this._root);

	@override final _StringsZhHant _root; // ignore: unused_field

	// Translations
	@override String get message => '消息';
	@override String get contact => '通訊錄';
	@override String get surrounding => '周邊与定位';
	@override String get myself => '我';
	@override String get send => '發送';
	@override String shareLocation({required Object person}) => '与${person}共享你的位置';
	@override String get notShareLocation => '停止共享';
	@override String get shareingLocation => '正在與您共享他的位置';
	@override String get deleteLocal => '僅刪除您程序中的信息';
	@override String get deleteAll => '從所有用戶App中刪除這條信息';
	@override String delFrom({required Object from}) => '你確定要刪除來自的${from}信息嗎';
	@override String get confirmDel => '你確定要刪除这条信息嗎';
	@override String get hello => '陌生使用者正在和你打招呼，他的电话是';
	@override String get forward => '選擇一個聊天轉發消息';
	@override String get chatList => '最近的聊天';
}

// Path: contact
class _StringsContactZhHant implements _StringsContactEn {
	_StringsContactZhHant._(this._root);

	@override final _StringsZhHant _root; // ignore: unused_field

	// Translations
	@override String get newContact => '新增連絡人';
	@override String get inputNumber => '請輸入聯繫人電話';
	@override String get add => '添加到通訊錄';
	@override String get block => '拒絕';
	@override String get foundUser => '找到用户';
	@override String get done => '添加完成';
	@override String get message => '發送信息';
	@override String get remove => '删除';
	@override String get addRequirement => '發送者不在您的通訊錄內';
	@override String get deleteConfirm => '确定要删除此联络人吗？ 该操作将同时删除你们之间所有的对话';
}

// Path: account
class _StringsAccountZhHant implements _StringsAccountEn {
	_StringsAccountZhHant._(this._root);

	@override final _StringsZhHant _root; // ignore: unused_field

	// Translations
	@override String get noDisturbSchedule => '免打擾時間表設置';
	@override String get surrond => '周邊與定位設置';
	@override String get setting => '系統設置';
}

// Path: setting
class _StringsSettingZhHant implements _StringsSettingEn {
	_StringsSettingZhHant._(this._root);

	@override final _StringsZhHant _root; // ignore: unused_field

	// Translations
	@override String get language => '語言';
	@override String get theme => '選擇主題';
	@override String get aboutUs => '應用信息';
	@override String get exit => '退出';
	@override String get confirmToExit => '確定要退出嗎？退出以後無法收到任何信息';
	@override String get unregister => '永久登出（取消註冊）';
	@override String get unregisterMessage => '從系統中刪除所有與我相關的註冊及用戶資訊';
	@override String get privateAndSafety => '隱私與安全設置';
	@override String get cleanLocal => '清理本地數據';
	@override String get cleanLocalExplan => '清理手機上保存的數據，僅保存最近一個月的';
	@override String get cleanLocalConfirm => '確定要刪除本地保存的數據嗎？ 此操作不可以撤銷';
	@override String get unregisterConfirm => '确定要永久注销吗？此操作不可以撤销,如果选择确定，您的注册及用户信息将在最多24小时内被删除';
}

// Path: FlexScheme
class _StringsFlexSchemeZhHant implements _StringsFlexSchemeEn {
	_StringsFlexSchemeZhHant._(this._root);

	@override final _StringsZhHant _root; // ignore: unused_field

	// Translations
	@override String get bahamaBlue => 'Bahama Blue';
	@override String get hippieBlue => 'Hippie Blue';
	@override String get money => 'Dollars Green';
	@override String get redWine => 'Red Wine';
	@override String get mango => 'Mango';
	@override String get greyLaw => 'Grey Law';
	@override String get shark => 'Shark';
	@override String get vesuviusBurn => 'Vesuvius Burn';
	@override String get deepPurple => 'Deep Purple';
	@override String get espresso => 'Espresso';
	@override String get deepBlue => 'Deep Blue Sea';
	@override String get jungle => 'Jungle';
	@override String get ebonyClay => 'Ebony Clay';
	@override String get brandBlue => 'Brand Blue';
	@override String get gold => 'Gold';
	@override String get indigo => 'Indigo Night';
	@override String get outerSpace => 'Outer Space';
	@override String get barossa => 'Barossa';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _StringsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'or': return 'or';
			case 'numberRegistered': return 'This number is already registered, please use the number to log in';
			case 'UserNotRegistered': return 'No matching user information found, please check your input';
			case 'PwsNotMatch': return 'Incorrect password, please check and try again';
			case 'contactIsBlocked': return 'The user has been blacklisted by you and cannot be added now';
			case 'contactExists': return 'Contact already exists, no need to add';
			case 'you': return 'you';
			case 'cancel': return 'Cancel';
			case 'ok': return 'Ok';
			case 'next': return 'Next';
			case 'skip': return 'Skip';
			case 'start': return 'Start';
			case 'welcome.screen2': return 'Share the surrounding, Immerse yourself';
			case 'welcome.screen3': return 'Message schedule, Contact anytime';
			case 'welcome.addFriend': return 'Add contacts';
			case 'welcome.scanQrcode': return 'Scan QRcode';
			case 'welcome.rules': return 'By clicking Register, you agree to accept our Terms of Service, Privacy Policy and Cookie Policy';
			case 'regular.reStart': return 'Restart';
			case 'regular.reStartRequire': return 'App needs to be restarted';
			case 'regular.locationPermission': return 'Permission to access location';
			case 'regular.locationPermissionDesc': return 'TimeCept needs your consent to use the special location,App can help you  share your location with your chat partner, so that you can discover entertainment information around you.TimeCept respects the user\'s privacy and never save the user\'s location  at any time and anywhere';
			case 'regular.locationPermissionRefuse': return 'If you decline, it means that in the chat, the shared location function will not be available';
			case 'login.welcome': return 'Hello friend,\nWelcome Back';
			case 'login.makeAccount': return 'Hello,friend,\nCreate Account';
			case 'login.login': return 'Log In';
			case 'login.signUp': return 'Sign Up';
			case 'login.tel': return 'Telephone number';
			case 'login.name': return 'Name';
			case 'login.pws': return 'Password';
			case 'login.pwsAgain': return 'Reenter password';
			case 'login.haveAccount': return 'Already have an account? ';
			case 'login.noAccount': return 'Don\'t have an account? ';
			case 'login.forget': return 'Forgot Password?';
			case 'login.registerDone': return 'Register successfully, you are welcome';
			case 'error.invalidNumber': return 'invalid mobile number';
			case 'error.pwsNotMatch': return 'The two entered passwords do not match,please check';
			case 'error.invalidNameLegth': return 'Name length should be between 2 and 24 characters';
			case 'error.pwsIsTooSimple': return 'Password should be longer than 8 characters, contain at least one letter and at least one digital';
			case 'message.message': return 'Message';
			case 'message.contact': return 'Contact';
			case 'message.surrounding': return 'Location';
			case 'message.myself': return 'Me';
			case 'message.send': return 'Send';
			case 'message.shareLocation': return ({required Object person}) => '${person} got your location';
			case 'message.notShareLocation': return 'Disable share location';
			case 'message.shareingLocation': return 'is sharing his location with you';
			case 'message.deleteLocal': return 'Only delete message from your App';
			case 'message.deleteAll': return 'Delete this message from all users\' Apps';
			case 'message.delFrom': return ({required Object from}) => 'Are you sure to delete the message from ${from}';
			case 'message.confirmDel': return 'Are you sure to delete the message';
			case 'message.hello': return 'The strange user is greeting you, this is his/her tel';
			case 'message.forward': return 'Select a chat to forward';
			case 'message.chatList': return 'Recent chats';
			case 'contact.newContact': return 'Add Contact';
			case 'contact.inputNumber': return 'Please input contact phone number';
			case 'contact.add': return 'Add to address book';
			case 'contact.block': return 'Refuse';
			case 'contact.foundUser': return 'Found user';
			case 'contact.done': return 'Add successfully';
			case 'contact.message': return 'Send Message';
			case 'contact.remove': return 'Remove';
			case 'contact.addRequirement': return 'The sender is not in your address book';
			case 'contact.deleteConfirm': return 'Are you sure to delete this contact? This will delete all conversations between you at the same time';
			case 'account.noDisturbSchedule': return 'Do not disturb schedule';
			case 'account.surrond': return 'Nearby and location';
			case 'account.setting': return 'Setting';
			case 'setting.theme': return 'Select theme';
			case 'setting.language': return 'Language';
			case 'setting.aboutUs': return 'About application';
			case 'setting.exit': return 'Log out';
			case 'setting.confirmToExit': return 'Are you sure to quit? Couldn\'t receive any messages after logging out';
			case 'setting.unregister': return 'Permanent cancellation (deregistration)';
			case 'setting.unregisterMessage': return 'Delete all registration and user information related to me from the system';
			case 'setting.privateAndSafety': return 'Privacy and security';
			case 'setting.cleanLocal': return 'Clean up local data';
			case 'setting.cleanLocalExplan': return 'Clean up the data saved on your phone and save only the last month\'s data';
			case 'setting.cleanLocalConfirm': return 'Are you sure you want to delete locally saved data? This action cannot be undone';
			case 'setting.unregisterConfirm': return 'Are you sure you want to sign out permanently? This action cannot be revoked, and if you choose OK, your registration and user information will be deleted within a maximum of 24 hours';
			case 'FlexScheme.bahamaBlue': return 'Bahama Blue';
			case 'FlexScheme.hippieBlue': return 'Hippie Blue';
			case 'FlexScheme.money': return 'Dollars Green';
			case 'FlexScheme.redWine': return 'Red Wine';
			case 'FlexScheme.mango': return 'Mango';
			case 'FlexScheme.greyLaw': return 'Grey Law';
			case 'FlexScheme.shark': return 'Shark';
			case 'FlexScheme.vesuviusBurn': return 'Vesuvius Burn';
			case 'FlexScheme.deepPurple': return 'Deep Purple';
			case 'FlexScheme.espresso': return 'Espresso';
			case 'FlexScheme.deepBlue': return 'Deep Blue Sea';
			case 'FlexScheme.jungle': return 'Jungle';
			case 'FlexScheme.ebonyClay': return 'Ebony Clay';
			case 'FlexScheme.brandBlue': return 'Brand Blue';
			case 'FlexScheme.gold': return 'Gold';
			case 'FlexScheme.indigo': return 'Indigo Night';
			case 'FlexScheme.outerSpace': return 'Outer Space';
			case 'FlexScheme.barossa': return 'Barossa';
			default: return null;
		}
	}
}

extension on _StringsZhHans {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'or': return '或者';
			case 'numberRegistered': return '此号码已经注册，请直接登录';
			case 'UserNotRegistered': return '未找到匹配的用户信息，请检查您的输入';
			case 'PwsNotMatch': return '密码错误，请核对后再试';
			case 'contactIsBlocked': return '该用户已经被你列入黑名单，暂时无法添加';
			case 'contactExists': return '联系人已存在，无需添加';
			case 'you': return '您';
			case 'cancel': return '放弃';
			case 'ok': return '确定';
			case 'next': return '下一步';
			case 'skip': return '跳过';
			case 'start': return '开始';
			case 'welcome.screen2': return '共享周边，身临其境';
			case 'welcome.screen3': return '预约发送，随时联系';
			case 'welcome.addFriend': return '新增联系人';
			case 'welcome.scanQrcode': return '扫码';
			case 'welcome.rules': return '点击注册，即表示你同意接受我们的服务条款、隐私政策和 Cookie 政策';
			case 'regular.reStart': return '重启';
			case 'regular.reStartRequire': return 'App需要重新启动';
			case 'regular.locationPermission': return '获取位置信息权限许可';
			case 'regular.locationPermissionDesc': return 'TimeCept希望你能同意使用特定的位置，TimeCept有一个核心功能可以与聊天对象共享位置,方便互相发现周边的娱乐信息。TimeCept尊重用户的隐私，不会在任何时候任何位置保存用户的位置信息';
			case 'regular.locationPermissionRefuse': return '如果拒绝就意味着在聊天中，共享位置功能将不能使用，此功能可以再稍后再打开';
			case 'login.welcome': return '朋友\n欢迎回来';
			case 'login.makeAccount': return '请创建你的账户\n开始使用timeCept';
			case 'login.login': return '登录';
			case 'login.signUp': return '注册';
			case 'login.haveAccount': return '已经注册过了? ';
			case 'login.noAccount': return '还没有注册? ';
			case 'login.tel': return '电话';
			case 'login.name': return '称呼';
			case 'login.pws': return '密码';
			case 'login.forget': return '忘记密码?';
			case 'login.pwsAgain': return '再次输入密码';
			case 'login.registerDone': return '注册成功，欢迎使用';
			case 'error.invalidNumber': return '不正确的电话号码';
			case 'error.pwsNotMatch': return '两次输入的密码不一致，请检查';
			case 'error.invalidNameLegth': return '名称长度应该在2到24个字符之间';
			case 'error.pwsIsTooSimple': return '密码长度至少应该超过8位，包括至少一个数字和一个字母';
			case 'message.message': return '消息';
			case 'message.contact': return '通讯录';
			case 'message.surrounding': return '周边与定位';
			case 'message.myself': return '我';
			case 'message.send': return '发送';
			case 'message.shareLocation': return ({required Object person}) => '与${person}共享你的位置';
			case 'message.notShareLocation': return '停止分享';
			case 'message.shareingLocation': return '正在与您共享他的位置';
			case 'message.deleteLocal': return '仅删除您程序中的信息';
			case 'message.deleteAll': return '从所有用户App中删除这条信息';
			case 'message.delFrom': return ({required Object from}) => '你确定要删除来自的${from}信息吗';
			case 'message.confirmDel': return '你确定要删除这条信息吗';
			case 'message.hello': return '陌生用户正在和你打招呼,他的电话是';
			case 'message.forward': return '选择一个聊天，转发消息';
			case 'message.chatList': return '最近的聊天';
			case 'contact.newContact': return '新增联系人';
			case 'contact.inputNumber': return '请输入联系人电话';
			case 'contact.add': return '添加到通讯录';
			case 'contact.block': return '拒絕';
			case 'contact.foundUser': return '找到用户';
			case 'contact.done': return '添加完成';
			case 'contact.message': return '发送信息';
			case 'contact.remove': return '删除';
			case 'contact.addRequirement': return '发送者不在您的通讯录内';
			case 'contact.deleteConfirm': return '确定要删除此联络人吗？该操作将同时删除你们之间所有的对话';
			case 'account.noDisturbSchedule': return '免打扰时间表设置';
			case 'account.surrond': return '周边与定位设置';
			case 'account.setting': return '系统设置';
			case 'setting.language': return '语言';
			case 'setting.theme': return '选择主题';
			case 'setting.aboutUs': return '应用信息';
			case 'setting.exit': return '退出';
			case 'setting.confirmToExit': return '确定要退出吗？退出以后无法收到任何信息';
			case 'setting.unregister': return '永久注销(取消注册)';
			case 'setting.unregisterMessage': return '从系统中删除所有与我相关的注册及用户信息';
			case 'setting.privateAndSafety': return '隐私与安全设置';
			case 'setting.cleanLocal': return '清理本地数据';
			case 'setting.cleanLocalExplan': return '清理手机上保存的数据，系统仅仅保存最近一个月的数据';
			case 'setting.cleanLocalConfirm': return '确定要删除本地保存的数据吗？此操作不可以撤销';
			case 'setting.unregisterConfirm': return '确定要永久注销吗？此操作不可以撤销,如果选择确定，您的注册及用户信息将在最多24小时内被删除';
			case 'FlexScheme.bahamaBlue': return 'Bahama Blue';
			case 'FlexScheme.hippieBlue': return 'Hippie Blue';
			case 'FlexScheme.money': return 'Dollars Green';
			case 'FlexScheme.redWine': return 'Red Wine';
			case 'FlexScheme.mango': return 'Mango';
			case 'FlexScheme.greyLaw': return 'Grey Law';
			case 'FlexScheme.shark': return 'Shark';
			case 'FlexScheme.vesuviusBurn': return 'Vesuvius Burn';
			case 'FlexScheme.deepPurple': return 'Deep Purple';
			case 'FlexScheme.espresso': return 'Espresso';
			case 'FlexScheme.deepBlue': return 'Deep Blue Sea';
			case 'FlexScheme.jungle': return 'Jungle';
			case 'FlexScheme.ebonyClay': return 'Ebony Clay';
			case 'FlexScheme.brandBlue': return 'Brand Blue';
			case 'FlexScheme.gold': return 'Gold';
			case 'FlexScheme.indigo': return 'Indigo Night';
			case 'FlexScheme.outerSpace': return 'Outer Space';
			case 'FlexScheme.barossa': return 'Barossa';
			default: return null;
		}
	}
}

extension on _StringsZhHant {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'or': return '或者';
			case 'numberRegistered': return '此號碼已經註冊，請直接登錄';
			case 'UserNotRegistered': return '未找到匹配的用戶信息，請檢查您的輸入';
			case 'PwsNotMatch': return '密碼錯誤，請核對後再試';
			case 'contactIsBlocked': return '該用戶已經被你列入黑名單，暫時無法添加';
			case 'contactExists': return '聯繫人已存在，無需添加';
			case 'you': return '您';
			case 'cancel': return '放弃';
			case 'ok': return '确定';
			case 'next': return '下一步';
			case 'skip': return '跳過';
			case 'start': return '開始';
			case 'regular.reStart': return '重啟';
			case 'regular.reStartRequire': return 'App需要重新啟動';
			case 'regular.locationPermission': return '位置信息權限許可';
			case 'regular.locationPermissionDesc': return 'TimeCept希望你能同意使用特定的位置，TimeCept有一個核心功能可以與聊天對象共用位置，方便互相發現周邊的娛樂資訊。 TimeCept尊重用戶的隱私，不會在任何時候任何位置保存使用者的位置資訊';
			case 'regular.locationPermissionRefuse': return '如果拒絕就意味著在聊天中，共享位置功能將不能使用';
			case 'welcome.screen2': return '共用周邊，身臨其境';
			case 'welcome.screen3': return '預約發送，隨時聯繫';
			case 'welcome.addFriend': return '新增聯繫人';
			case 'welcome.scanQrcode': return '掃碼';
			case 'welcome.rules': return '點擊注册，即表示你同意接受我們的條款、隱私權政策和 Cookie 政策';
			case 'login.welcome': return '朋友\n歡迎回來';
			case 'login.makeAccount': return '請創建你的帳戶\n開始使用timeCept';
			case 'login.login': return '登錄';
			case 'login.signUp': return '註冊';
			case 'login.haveAccount': return '已經註冊過了? ';
			case 'login.noAccount': return '還沒有註冊? ';
			case 'login.tel': return '電話';
			case 'login.name': return '稱呼';
			case 'login.pws': return '密碼';
			case 'login.pwsAgain': return '再次輸入密碼';
			case 'login.forget': return '忘記密碼?';
			case 'login.registerDone': return '註冊成功，歡迎使用';
			case 'error.invalidNumber': return '不正確的電話號碼';
			case 'error.pwsNotMatch': return '兩次輸入的密碼不一致，請檢查';
			case 'error.invalidNameLegth': return '名稱長度應該在2到24個字元之間';
			case 'error.pwsIsTooSimple': return '密碼長度至少應該超過8位元，包括至少一個數位和一個字母';
			case 'message.message': return '消息';
			case 'message.contact': return '通訊錄';
			case 'message.surrounding': return '周邊与定位';
			case 'message.myself': return '我';
			case 'message.send': return '發送';
			case 'message.shareLocation': return ({required Object person}) => '与${person}共享你的位置';
			case 'message.notShareLocation': return '停止共享';
			case 'message.shareingLocation': return '正在與您共享他的位置';
			case 'message.deleteLocal': return '僅刪除您程序中的信息';
			case 'message.deleteAll': return '從所有用戶App中刪除這條信息';
			case 'message.delFrom': return ({required Object from}) => '你確定要刪除來自的${from}信息嗎';
			case 'message.confirmDel': return '你確定要刪除这条信息嗎';
			case 'message.hello': return '陌生使用者正在和你打招呼，他的电话是';
			case 'message.forward': return '選擇一個聊天轉發消息';
			case 'message.chatList': return '最近的聊天';
			case 'contact.newContact': return '新增連絡人';
			case 'contact.inputNumber': return '請輸入聯繫人電話';
			case 'contact.add': return '添加到通訊錄';
			case 'contact.block': return '拒絕';
			case 'contact.foundUser': return '找到用户';
			case 'contact.done': return '添加完成';
			case 'contact.message': return '發送信息';
			case 'contact.remove': return '删除';
			case 'contact.addRequirement': return '發送者不在您的通訊錄內';
			case 'contact.deleteConfirm': return '确定要删除此联络人吗？ 该操作将同时删除你们之间所有的对话';
			case 'account.noDisturbSchedule': return '免打擾時間表設置';
			case 'account.surrond': return '周邊與定位設置';
			case 'account.setting': return '系統設置';
			case 'setting.language': return '語言';
			case 'setting.theme': return '選擇主題';
			case 'setting.aboutUs': return '應用信息';
			case 'setting.exit': return '退出';
			case 'setting.confirmToExit': return '確定要退出嗎？退出以後無法收到任何信息';
			case 'setting.unregister': return '永久登出（取消註冊）';
			case 'setting.unregisterMessage': return '從系統中刪除所有與我相關的註冊及用戶資訊';
			case 'setting.privateAndSafety': return '隱私與安全設置';
			case 'setting.cleanLocal': return '清理本地數據';
			case 'setting.cleanLocalExplan': return '清理手機上保存的數據，僅保存最近一個月的';
			case 'setting.cleanLocalConfirm': return '確定要刪除本地保存的數據嗎？ 此操作不可以撤銷';
			case 'setting.unregisterConfirm': return '确定要永久注销吗？此操作不可以撤销,如果选择确定，您的注册及用户信息将在最多24小时内被删除';
			case 'FlexScheme.bahamaBlue': return 'Bahama Blue';
			case 'FlexScheme.hippieBlue': return 'Hippie Blue';
			case 'FlexScheme.money': return 'Dollars Green';
			case 'FlexScheme.redWine': return 'Red Wine';
			case 'FlexScheme.mango': return 'Mango';
			case 'FlexScheme.greyLaw': return 'Grey Law';
			case 'FlexScheme.shark': return 'Shark';
			case 'FlexScheme.vesuviusBurn': return 'Vesuvius Burn';
			case 'FlexScheme.deepPurple': return 'Deep Purple';
			case 'FlexScheme.espresso': return 'Espresso';
			case 'FlexScheme.deepBlue': return 'Deep Blue Sea';
			case 'FlexScheme.jungle': return 'Jungle';
			case 'FlexScheme.ebonyClay': return 'Ebony Clay';
			case 'FlexScheme.brandBlue': return 'Brand Blue';
			case 'FlexScheme.gold': return 'Gold';
			case 'FlexScheme.indigo': return 'Indigo Night';
			case 'FlexScheme.outerSpace': return 'Outer Space';
			case 'FlexScheme.barossa': return 'Barossa';
			default: return null;
		}
	}
}
