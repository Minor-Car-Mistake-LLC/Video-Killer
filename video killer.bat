@echo off
echo Please install ffmpeg before using this!
echo.
echo.
echo.
if exist C:\Users\%USERNAME%\Downloads\ffmpeg-master-latest-win64-gpl\ffmpeg-master-latest-win64-gpl\bin (
	set ffmpegdir=C:\Users\%USERNAME%\Downloads\ffmpeg-master-latest-win64-gpl\ffmpeg-master-latest-win64-gpl\bin
) else (
	set /p ffmpegdir=Where is your ffmpeg.exe? If you read the readme, it should be in C:\Users\%USERNAME%\Downloads\ffmpeg-master-latest-win64-gpl\ffmpeg-master-latest-win64-gpl\bin && echo.
)
cd %ffmpegdir%
set /p death=What is the direct path to the video you want to kill? (Ex: C:\Users\%USERNAME%\Videos\teamspeak.mp4) && echo.
mkdir "C:\Users\%USERNAME%\Downloads\killtmp
ffmpeg -i %death% -map 0:a:0 -b:a 10k -maxrate 10k "C:\Users\%USERNAME%\Downloads\killtmp\killed.mp3"
ffmpeg -i %death% -s 72x72 -filter:v fps=12 -b 10k -maxrate 10k "C:\Users\%USERNAME%\Downloads\killtmp\killed.mp4"
ffmpeg -i "C:\Users\%USERNAME%\Downloads\killtmp\killed.mp4" -i "C:\Users\%USERNAME%\Downloads\killtmp\killed.mp3" -c:v copy -map 0:v:0 -map 1:a:0 "C:\Users\isaac\Downloads\please_reconsider.mp4"
@RD /S /Q "C:\Users\%USERNAME%\Downloads\killtmp"
start "" "wmplayer.exe" "C:\Users\isaac\Downloads\please_reconsider.mp4"
