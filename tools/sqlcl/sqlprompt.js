/* Get database name, version and uptime */
var lBanner = util.executeReturnOneCol("select '@|green -----==== database '||VERSION||'|@ @|red '||INSTANCE_NAME||'|@ @|green is on a duty from '|| STARTUP_TIME ||' ====----- |@' as col1 from V$INSTANCE");


/* if user has no access to V$INSTANCE, use simple version */
if (lBanner == null) {
	var lBanner = util.executeReturnOneCol("select sys_context('userenv','instance_name') from dual");
	lBanner = '@|green ---------==== database|@ @|red ' + lBanner + '|@ @|green ====--------- |@';
}

sqlcl.setStmt('prompt '+ lBanner);
sqlcl.run();


/*  execute a sql and get the first column of the first row as a return*/
var dbUser = util.executeReturnOneCol('select user from dual');
var dbHost = util.executeReturnOneCol('select HOST_NAME from V$INSTANCE');

/*  based on the connect user change my SQL prompt*/
if ( dbUser == 'WDT' && dbHost == 'vm-apex') {
 sqlcl.setStmt('set sqlprompt "🎯   @|red _USER|@>"');
} else if ( dbUser == 'DEV' || dbHost == 'vm-dev'){
 sqlcl.setStmt('set sqlprompt "😎   @|blue  _USER>|@"');
} else {
 sqlcl.setStmt('set sqlprompt "🙊   @|yellow  _USER>|@"');
}

sqlcl.run();


