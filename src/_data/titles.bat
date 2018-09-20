@echo off
if exist titles.txt (del titles.txt)
for /f "tokens=*" %%a in (resource-urls.csv) do (
  echo Checking %%a
  echo|set /p=%%a ;>> titles.txt
  wget --quiet -O - "%%a" 2> nul | sed -n -e "s!.*<title>\(.*\)</title>.*!\1!p" >> titles.txt
)
type titles.txt