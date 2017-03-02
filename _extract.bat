@echo off

IF "%DATALOADER_HOME%" == "" (
	echo To run this, set the DATALOADER_HOME environment variable to the directory where the salesforce.com Data Loader is installed.
	goto end
)

IF "%JAVA_HOME%" == "" (
	echo To run process.bat, set the JAVA_HOME environment variable to the directory where the Java Runtime Environment ^(JRE^) is installed.
	goto end
)

rem SET URL=sfdc.endpoint=%1
SET URL=sfdc.endpoint=https://test.salesforce.com
SET USR=sfdc.username=%1
rem SET USR=sfdc.username=peter.dedic@theglobalfund.org.2.aimdev1
SET PWD=sfdc.password=%2
rem SET PWD=sfdc.password=da36812bb56c4ebebe8aff6deca348b7d3e5843756fc97e2222512f28af664ec2ff31d586ac3c10f


"%JAVA_HOME%"\bin\java -cp "%DATALOADER_HOME%"\dataloader-36.0.0-uber.jar -Dsalesforce.config.dir=conf com.salesforce.dataloader.process.ProcessRunner %URL% %USR% %PWD% process.name=metaExtract | find /V "INFO"
"%JAVA_HOME%"\bin\java -cp "%DATALOADER_HOME%"\dataloader-36.0.0-uber.jar -Dsalesforce.config.dir=conf com.salesforce.dataloader.process.ProcessRunner %URL% %USR% %PWD% process.name=settingsExtract | find /V "INFO"

:end