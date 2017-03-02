@echo off

IF "%DATALOADER_HOME%" == "" (
	echo To run this, set the DATALOADER_HOME environment variable to the directory where the salesforce.com Data Loader is installed.
	goto end
)

IF "%JAVA_HOME%" == "" (
	echo To run process.bat, set the JAVA_HOME environment variable to the directory where the Java Runtime Environment ^(JRE^) is installed.
	goto end
)

SET URL=sfdc.endpoint=https://test.salesforce.com
SET USR=sfdc.username=%1
SET PWD=sfdc.password=%2

rem IF %1 neq SIT IF %1 neq UAT2 IF %1 neq DEV2 IF %1 neq DEV1 IF %1 neq CI IF %1 neq BAT2 IF %1 neq PROD IF %1 neq DATAVAL IF %1 neq DEVSI goto end

rem IF %1 == DATAVAL (
rem   echo "deploying to DATAVAL"
rem   SET USR=sfdc.username=peter.dedic@theglobalfund.org.2.aimdataval
rem   SET PWD=sfdc.password=da36812bb56c4ebeabf560a9e1579d147e61badea894ea89e51470db1177b262b31943c3ef8a95b8
rem )

rem IF %1 == SIT (
rem   echo "deploying to SIT"
rem   SET USR=sfdc.username=peter.dedic@theglobalfund.org.2.aimsit
rem   SET PWD=sfdc.password=da36812bb56c4ebed8bac0dba9673320526537dfa680e2898e02d652a1ad4ae4aabc77659d2a1dc1
rem )

rem IF %1 == UAT2 (
rem   echo "deploying to UAT2"
rem   SET USR=sfdc.username=peter.dedic@theglobalfund.org.2.aimuat2
rem   SET PWD=sfdc.password=da36812bb56c4ebeaeb46eb6365d97c94edd43868e71a92de4235e454a88850a0adbabaeb6a031b6
rem )

rem IF %1 == DEV2 (
rem   echo "deploying to DEV2"
rem   SET USR=sfdc.username=peter.dedic@theglobalfund.org.2.aimdev2
rem   SET PWD=sfdc.password=da36812bb56c4ebefa85fb9a2ef280a716000dd62e6c5b7eb0304b9df6e03d70adde60d334986df3
rem )

rem IF %1 == DEV1 (
rem   echo "deploying to DEV1"
rem   SET USR=sfdc.username=peter.dedic@theglobalfund.org.2.aimdev1
rem   SET PWD=sfdc.password=da36812bb56c4ebeb03679e245a1d62dce1193260e4d6f61a0c53df4c7f0ebce21769fdab802fe75
rem )

rem IF %1 == CI (
rem   echo "deploying to CI"
rem   SET USR=sfdc.username=peter.dedic@theglobalfund.org.2.aimci
rem   SET PWD=sfdc.password=da36812bb56c4ebeabca4a7faab7e0fef61772b7668c47daf6bad5141d19b6458bf3bc7be1fb06d8
rem )

rem IF %1 == BAT2 (
rem   echo "deploying to BAT2"
rem   SET USR=sfdc.username=peter.dedic@theglobalfund.org.2.aimbat2
rem   SET PWD=sfdc.password=da36812bb56c4ebeacbe74978fcfe78adacbab32c2e0d0b8bb6edb941ecfe744c1786bb263e2d130
rem )

rem IF %1 == PROD (
rem   echo "deploying to PROD"
rem   SET URL=sfdc.endpoint=https://login.salesforce.com
rem   SET USR=sfdc.username=peter.dedic@theglobalfund.org.2
rem   SET PWD=sfdc.password=da36812bb56c4ebeb47d49e23a36af9e18e831d1df97dbce6d14bc9c2cbd2fda5b60ed184ee2cae5
rem )

rem IF %1 == DEVSI (
rem   echo "deploying to DEVSI"
rem   SET USR=sfdc.username=peter.dedic@theglobalfund.org.2.aimdevsi
rem   SET PWD=sfdc.password=da36812bb56c4ebe8a1179846b6d322a6177b62dba5b2c8eb6d7e8acb5244fb7e58af71d9dcac1c7
rem )

IF %3 == meta (
  "%JAVA_HOME%"\bin\java -cp "%DATALOADER_HOME%"\dataloader-36.0.0-uber.jar -Dsalesforce.config.dir=conf com.salesforce.dataloader.process.ProcessRunner %URL% %USR% %PWD% process.name=metaExtractId | find /V "INFO"
  "%JAVA_HOME%"\bin\java -cp "%DATALOADER_HOME%"\dataloader-36.0.0-uber.jar -Dsalesforce.config.dir=conf com.salesforce.dataloader.process.ProcessRunner %URL% %USR% %PWD% process.name=metaDelete | find /V "INFO"
  "%JAVA_HOME%"\bin\java -cp "%DATALOADER_HOME%"\dataloader-36.0.0-uber.jar -Dsalesforce.config.dir=conf com.salesforce.dataloader.process.ProcessRunner %URL% %USR% %PWD% process.name=metaInsert | find /V "INFO"
)
IF %3 == settings (
  "%JAVA_HOME%"\bin\java -cp "%DATALOADER_HOME%"\dataloader-36.0.0-uber.jar -Dsalesforce.config.dir=conf com.salesforce.dataloader.process.ProcessRunner %URL% %USR% %PWD% process.name=settingsExtractId | find /V "INFO"
  "%JAVA_HOME%"\bin\java -cp "%DATALOADER_HOME%"\dataloader-36.0.0-uber.jar -Dsalesforce.config.dir=conf com.salesforce.dataloader.process.ProcessRunner %URL% %USR% %PWD% process.name=settingsDelete | find /V "INFO"
  "%JAVA_HOME%"\bin\java -cp "%DATALOADER_HOME%"\dataloader-36.0.0-uber.jar -Dsalesforce.config.dir=conf com.salesforce.dataloader.process.ProcessRunner %URL% %USR% %PWD% process.name=settingsInsert | find /V "INFO"
)
rem java -cp "%DATALOADER_HOME%\dataloader-36.0.0-uber.jar" com.salesforce.dataloader.security.EncryptionUtil -e Deloitte2019sGRBhW1uj9WPC8Z21QRBTFv4 conf/key.txt
:end