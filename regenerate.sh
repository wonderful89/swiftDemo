echo "in regenerate sh"

cd flutter_module
flutter build  ios-framework --debug
# 不能指定目录，否则添加 plugin后无法导出成功
# flutter build  ios-framework --output=../buildFramework
# --debug 好像不起作用

sourceFrameworkDir=build/ios/framework/Debug/
outFrameworksDir=../flutterFrameworks/frameworks
rm -rf $outFrameworksDir
mkdir $outFrameworksDir
cp -r  $sourceFrameworkDir  $outFrameworksDir

echo "in regenerate end......"
