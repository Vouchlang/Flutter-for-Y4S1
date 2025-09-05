// Update this code in your void main()
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(userHiveBox);
  runApp(const MyApp());
}