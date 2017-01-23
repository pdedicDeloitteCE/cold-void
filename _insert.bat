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

IF %1 neq SIT IF %1 neq UAT2 IF %1 neq DEV2 IF %1 neq DEV1 IF %1 neq CI IF %1 neq BAT2 IF %1 neq PROD IF %1 neq DATAVAL IF %1 neq DEVSI goto end

IF %1 == DATAVAL (
  echo "deploying to DATAVAL"
  SET USR=sfdc.username=peter.dedic@theglobalfund.org.2.aimdataval
  SET PWD=sfdc.password=da36812bb56c4ebeabf560a9e1579d147e61badea894ea89e51470db1177b262b31943c3ef8a95b8
)

IF %1 == SIT (
  echo "deploying to SIT"
  SET USR=sfdc.username=peter.dedic@theglobalfund.org.2.aimsit
  SET PWD=sfdc.password=da36812bb56c4ebed8bac0dba9673320526537dfa680e2898e02d652a1ad4ae4aabc77659d2a1dc1
)

IF %1 == UAT2 (
  echo "deploying to UAT2"
  SET USR=sfdc.username=peter.dedic@theglobalfund.org.2.aimuat2
  SET PWD=sfdc.password=da36812bb56c4ebeaeb46eb6365d97c94edd43868e71a92de4235e454a88850a0adbabaeb6a031b6
)

IF %1 == DEV2 (
  echo "deploying to DEV2"
  SET USR=sfdc.username=peter.dedic@theglobalfund.org.2.aimdev2
  SET PWD=sfdc.password=da36812bb56c4ebefa85fb9a2ef280a716000dd62e6c5b7eb0304b9df6e03d70adde60d334986df3
)

IF %1 == DEV1 (
  echo "deploying to DEV1"
  SET USR=sfdc.username=peter.dedic@theglobalfund.org.2.aimdev1
  SET PWD=sfdc.password=da36812bb56c4ebeb03679e245a1d62dce1193260e4d6f61a0c53df4c7f0ebce21769fdab802fe75
)

IF %1 == CI (
  echo "deploying to CI"
  SET USR=sfdc.username=peter.dedic@theglobalfund.org.2.aimci
  SET PWD=sfdc.password=da36812bb56c4ebeabca4a7faab7e0fef61772b7668c47daf6bad5141d19b6458bf3bc7be1fb06d8
)

IF %1 == BAT2 (
  echo "deploying to BAT2"
  SET USR=sfdc.username=peter.dedic@theglobalfund.org.2.aimbat2
  SET PWD=sfdc.password=da36812bb56c4ebeacbe74978fcfe78adacbab32c2e0d0b8bb6edb941ecfe744c1786bb263e2d130
)

IF %1 == PROD (
  echo "deploying to PROD"
  SET USR=sfdc.username=peter.dedic@theglobalfund.org.2
  SET PWD=sfdc.password=da36812bb56c4ebe74baf1a408d270ea3c81a0510132a5a3ea50f9a6be9ea18cdec85ad18d4d1d33
)

IF %1 == DEVSI (
  echo "deploying to DEVSI"
  SET USR=sfdc.username=peter.dedic@theglobalfund.org.2.aimdevsi
  SET PWD=sfdc.password=da36812bb56c4ebe8a1179846b6d322a6177b62dba5b2c8eb6d7e8acb5244fb7e58af71d9dcac1c7
)

"%JAVA_HOME%"\bin\java -cp "%DATALOADER_HOME%"\dataloader-36.0.0-uber.jar -Dsalesforce.config.dir=conf com.salesforce.dataloader.process.ProcessRunner %URL% %USR% %PWD% process.name=metaExtractId | find /V "INFO"
"%JAVA_HOME%"\bin\java -cp "%DATALOADER_HOME%"\dataloader-36.0.0-uber.jar -Dsalesforce.config.dir=conf com.salesforce.dataloader.process.ProcessRunner %URL% %USR% %PWD% process.name=metaDelete | find /V "INFO"
"%JAVA_HOME%"\bin\java -cp "%DATALOADER_HOME%"\dataloader-36.0.0-uber.jar -Dsalesforce.config.dir=conf com.salesforce.dataloader.process.ProcessRunner %URL% %USR% %PWD% process.name=metaInsert | find /V "INFO"

"%JAVA_HOME%"\bin\java -cp "%DATALOADER_HOME%"\dataloader-36.0.0-uber.jar -Dsalesforce.config.dir=conf com.salesforce.dataloader.process.ProcessRunner %URL% %USR% %PWD% process.name=settingsExtractId | find /V "INFO"
"%JAVA_HOME%"\bin\java -cp "%DATALOADER_HOME%"\dataloader-36.0.0-uber.jar -Dsalesforce.config.dir=conf com.salesforce.dataloader.process.ProcessRunner %URL% %USR% %PWD% process.name=settingsDelete | find /V "INFO"
"%JAVA_HOME%"\bin\java -cp "%DATALOADER_HOME%"\dataloader-36.0.0-uber.jar -Dsalesforce.config.dir=conf com.salesforce.dataloader.process.ProcessRunner %URL% %USR% %PWD% process.name=settingsInsert | find /V "INFO"


:end