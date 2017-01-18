@echo off

IF "%DATALOADER_HOME%" == "" (
	echo To run this, set the DATALOADER_HOME environment variable to the directory where the salesforce.com Data Loader is installed.
	goto end
)

IF "%JAVA_HOME%" == "" (
	echo To run process.bat, set the JAVA_HOME environment variable to the directory where the Java Runtime Environment ^(JRE^) is installed.
	goto end
)

REM SET URL=sfdc.endpoint=%1
SET URL=sfdc.endpoint=https://test.salesforce.com
REM SET USR=sfdc.username=%2
SET USR=sfdc.username=peter.dedic@theglobalfund.org.2.aimdev1
REM SET PWD=sfdc.password=%3
SET PWD=sfdc.password=da36812bb56c4ebeb03679e245a1d62dce1193260e4d6f61a0c53df4c7f0ebce21769fdab802fe75

"%JAVA_HOME%"\bin\java -cp "%DATALOADER_HOME%"\dataloader-36.0.0-uber.jar -Dsalesforce.config.dir=conf com.salesforce.dataloader.process.ProcessRunner %URL% %USR% %PWD% process.name=metaExtract | find /V "INFO"
"%JAVA_HOME%"\bin\java -cp "%DATALOADER_HOME%"\dataloader-36.0.0-uber.jar -Dsalesforce.config.dir=conf com.salesforce.dataloader.process.ProcessRunner %URL% %USR% %PWD% process.name=settingsExtract | find /V "INFO"

:end