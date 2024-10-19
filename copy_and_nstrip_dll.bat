@echo off
setlocal enableDelayedExpansion

echo Copy all dll from the game so we can work and modify them
xcopy /f /y "C:\Program Files (x86)\Steam\steamapps\common\ChilloutVR\MelonLoader\net35\0Harmony.dll" "%0\..\ManagedLibs"
xcopy /f /y "C:\Program Files (x86)\Steam\steamapps\common\ChilloutVR\MelonLoader\net35\MelonLoader.dll" "%0\..\ManagedLibs"
xcopy /f /s /y "C:\Program Files (x86)\Steam\steamapps\common\ChilloutVR\ChilloutVR_Data\Managed" "%0\..\ManagedLibs"

Rem this breaks vstudio build system it seems
del "%0\..\ManagedLibs\netstandard.dll"
del "%0\..\ManagedLibs\mscorlib.dll"

echo Nstrip convert all private/protected stuff to public, yay
for %%x in (Assembly-CSharp.dll Assembly-CSharp-firstpass.dll UnityEngine.CoreModule.dll Cohtml.Runtime.dll SteamVR_Actions.dll SteamVR.dll) do (
    NStrip.exe -p -n "C:\Program Files (x86)\Steam\steamapps\common\ChilloutVR\ChilloutVR_Data\Managed\%%x" "%0\..\ManagedLibs\%%x"
)
echo We re done now
pause
