for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /format:list') do set datetime=%%I
set datetime=%datetime:~0,8%-%datetime:~8,6%

rem Path where the start_diskspeed_local.bat is stored
set BASEPATH=D:\Installation\dl380p\Performance

rem File which is used for performance testing (would be deleted at the end)
set TESTFILE=d:\spdtest.dat

rem Session Name (is append to the computername and date)
rem Should be used to identify the test.
set LOGNAME=disk_d

rem How long the test should run in seconds
set DURATION=300

rem ---- NO NEED TO CHANGE BELLOW ----
set RESULT=%BASEPATH%\%computername%_%datetime%_%LOGNAME%_

rem Software Cache active, Hardware Cache active
%BASEPATH%\DiskSpeed\amd64fre\diskspd.exe -b8K -d%DURATION% -o4 -t8 -r -w25 -L -c1G -Sb %TESTFILE% > %RESULT%with_sw_cache.txt

rem No Software Cache, Hardware Cache active
%BASEPATH%\DiskSpeed\amd64fre\diskspd.exe -b8K -d%DURATION% -o4 -t8 -r -w25 -L -c1G -Su %TESTFILE% > %RESULT%no_sw_cache.txt

rem No Software Cache, No Hardware Cache
%BASEPATH%\DiskSpeed\amd64fre\diskspd.exe -b8K -d%DURATION% -o4 -t8 -r -w25 -L -c1G -Sh %TESTFILE% > %RESULT%no_hw_cache.txt

del  %TESTFILE% 
pause
