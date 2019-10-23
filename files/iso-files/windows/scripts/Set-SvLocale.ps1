$OldList = Get-WinUserLanguageList;
$OldList.Add("en-US");
$OldList.Add("sv-SE");
Set-WinUserLanguageList -LanguageList $OldList -Force;

Set-Culture sv-SE;
Set-WinSystemLocale sv-SE;
Set-WinHomeLocation 0xDD;
Set-WinUILanguageOverride sv-SE;
