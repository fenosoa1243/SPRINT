#!/bin/bash

APP_NAME="TEST_SPRINT"
SRC_DIR="src/main/java"
WEB_DIR="src/main/webapp"
BUILD_DIR="build"
LIB_DIR="lib"
TOMCAT_WEBAPPS="/opt/tomcat/webapps"
CATALINA_HOME="/opt/tomcat"
SERVLET_API_JAR="lib/servlet-api.jar"
FRAMEWORK_JAR="lib/FRAMEWORK.jar"

# Nettoyage build
if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"
fi
mkdir -p "$BUILD_DIR/WEB-INF/classes"
mkdir -p "$BUILD_DIR/WEB-INF/lib"

# Compilation Java
find "$SRC_DIR" -name "*.java" > sources.txt
javac -cp "$SERVLET_API_JAR:$FRAMEWORK_JAR" -d "$BUILD_DIR/WEB-INF/classes" @sources.txt
COMPILE_STATUS=$?
rm -f sources.txt

if [ $COMPILE_STATUS -ne 0 ]; then
    echo "ERREUR : Compilation échouée."
    read -p "Appuyez sur une touche pour continuer..."
    exit 1
fi

# Copier webapp
cp -r "$WEB_DIR/." "$BUILD_DIR/"

# Copier framework JAR
cp "$FRAMEWORK_JAR" "$BUILD_DIR/WEB-INF/lib/"

# Création WAR
(cd "$BUILD_DIR" && jar -cvf "$APP_NAME.war" *)

if [ $? -ne 0 ]; then
    echo "ERREUR : Création du WAR échouée."
    read -p "Appuyez sur une touche pour continuer..."
    exit 1
fi

# Arrêt Tomcat
echo "Arrêt de Tomcat..."
"$CATALINA_HOME/bin/shutdown.sh" 2>/dev/null
sleep 5

# Nettoyage ancien déploiement
if [ -f "$TOMCAT_WEBAPPS/$APP_NAME.war" ]; then
    rm -f "$TOMCAT_WEBAPPS/$APP_NAME.war"
fi
if [ -d "$TOMCAT_WEBAPPS/$APP_NAME" ]; then
    rm -rf "$TOMCAT_WEBAPPS/$APP_NAME"
fi

# Déploiement
cp "$BUILD_DIR/$APP_NAME.war" "$TOMCAT_WEBAPPS/"

# Démarrage Tomcat
echo "Démarrage de Tomcat..."
"$CATALINA_HOME/bin/startup.sh"

echo ""
echo "Déploiement terminé."
read -p "Appuyez sur une touche pour continuer..."