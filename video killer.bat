echo Please install ffmpeg before using this!
echo.
echo.
echo.
if exist C:\Users\%USERNAME%\Downloads\ffmpeg-master-latest-win64-gpl\ffmpeg-master-latest-win64-gpl\bin (
	set ffmpegdir=C:\Users\%USERNAME%\Downloads\ffmpeg-master-latest-win64-gpl\ffmpeg-master-latest-win64-gpl\bin
) else (
	set /p ffmpegdir=Where is your ffmpeg.exe? If you read the readme, it should be in C:\Users\%USERNAME%\Downloads\ffmpeg-master-latest-win64-gpl\ffmpeg-master-latest-win64-gpl\bin && echo.
)
mkdir "C:\Users\%USERNAME%\Downloads\killtmp"
cd %ffmpegdir%
:select
set /p sel=Is your video a youtube link or a direct path? [yt/dp]
if "%sel%"=="yt" (
	goto yt
) else if "%sel%"=="dp" (
    goto dp
) else (
    echo That is not a valid selection!
    goto select
)

:dp
set /p death=What is the direct path to the video you want to kill? (Ex: "C:\Users\isaac\Videos\teamspeak.mp4") && echo.
goto work
echo That is not a valid selection! Type yt or dp.
goto select  

:yt
set /p death=What is the youtube link to the video you want to kill? (Ex: https://www.youtube.com/watch?v=-Dv_DXqdC9k) && echo.
if exist "C:\Users\isaac\youtube-dl.exe" (
    cd "C:\Users\%USERNAME%"
    youtube-dl.exe %death% -o "video.mp4"
    move video.mp4 "C:\Users\%USERNAME%\Downloads\killtmp"
    set death="C:\Users\%USERNAME%\Downloads\killtmp\video.mp4"
    goto work
) else (
    set /p ytdir=Where is the direct path to your youtube-dll.exe file?
    cd %ytdir%
    youtube-dl.exe %death% -o "video.mp4"
	move video.mp4 "C:\Users\%USERNAME%\Downloads\killtmp"
    set death="C:\Users\%USERNAME%\Downloads\killtmp\video.mp4"
	goto work
)

:work
cd %ffmpegdir%
ffmpeg -i %death% -map 0:a:0 -b:a 10k -maxrate 10k "C:\Users\%USERNAME%\Downloads\killtmp\killed.mp3"
ffmpeg -i %death% -s 72x72 -filter:v fps=12 -b 10k -maxrate 10k "C:\Users\%USERNAME%\Downloads\killtmp\killed.mp4"
ffmpeg -i "C:\Users\%USERNAME%\Downloads\killtmp\killed.mp4" -i "C:\Users\%USERNAME%\Downloads\killtmp\killed.mp3" -c:v copy -map 0:v:0 -map 1:a:0 "C:\Users\isaac\Downloads\please_reconsider.mp4"
@RD /S /Q "C:\Users\%USERNAME%\Downloads\killtmp"
start "" "wmplayer.exe" "C:\Users\isaac\Downloads\please_reconsider.mp4"
