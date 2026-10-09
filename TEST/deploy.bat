@echo off

set APP_NAME=TEST_SPRINT
set SRC_DIR=src\main\java
set WEB_DIR=src\main\webapp
set BUILD_DIR=build
set LIB_DIR=lib
set TOMCAT_WEBAPPS=D:\Tomcat\webapps
set CATALINA_HOME=D:\Tomcat
set SERVLET_API_JAR=lib\servlet-api.jar
set FRAMEWORK_JAR=lib\FRAMEWORK.jar

REM Nettoyage build
if exist %BUILD_DIR% rmdir /s /q %BUILD_DIR%
mkdir %BUILD_DIR%\WEB-INF\classes
mkdir %BUILD_DIR%\WEB-INF\lib

REM Compilation Java
dir /s /b %SRC_DIR%\*.java > sources.txt
javac -cp "%SERVLET_API_JAR%;%FRAMEWORK_JAR%" -d %BUILD_DIR%\WEB-INF\classes @sources.txt
del sources.txt

REM Copier webapp
xcopy %WEB_DIR% %BUILD_DIR% /E /I /Y

REM Copier framework JAR
copy %FRAMEWORK_JAR% %BUILD_DIR%\WEB-INF\lib\

REM Création WAR
cd %BUILD_DIR%
jar -cvf %APP_NAME%.war *
cd ..

REM Arrêt Tomcat
echo Arrêt de Tomcat...
call "%CATALINA_HOME%\bin\shutdown.bat" 2>nul
timeout /t 5 /nobreak >nul

REM Nettoyage ancien déploiement
if exist %TOMCAT_WEBAPPS%\%APP_NAME%.war del %TOMCAT_WEBAPPS%\%APP_NAME%.war
if exist %TOMCAT_WEBAPPS%\%APP_NAME% rmdir /s /q %TOMCAT_WEBAPPS%\%APP_NAME%

REM Déploiement
copy %BUILD_DIR%\%APP_NAME%.war %TOMCAT_WEBAPPS%

REM Démarrage Tomcat
echo Démarrage de Tomcat...
call "%CATALINA_HOME%\bin\startup.bat"

echo.
echo Déploiement terminé.
pause