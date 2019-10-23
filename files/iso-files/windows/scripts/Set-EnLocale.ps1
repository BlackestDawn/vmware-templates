$OldList = Get-WinUserLanguageList;
$OldList.Add("en-US");
$OldList.Add("sv-SE");
Set-WinUserLanguageList -LanguageList $OldList -Force;

Set-Culture en-US;
Set-WinSystemLocale en-US;
Set-WinHomeLocation 0xDD;
Set-WinUILanguageOverride en-US;
