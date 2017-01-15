// script printtab select * from logger_logs where id=8522

function formatCaption( pFieldName ) {
    var lFiller = " ";
    for (var n = 0; n < 17 - pFieldName.length; n++) {
        lFiller = lFiller + " ";
    }
    return lFiller + pFieldName;
};

function formatValue( pFieldName, pValue ) {
    if ((pFieldName == "CALL_STACK" || pFieldName == "EXTRA") && (pValue != null)) {
        return "\n" + pValue;
    } else {
        return pValue;
    }
};

var sql="select ID, TIME_STAMP, LOGGER_LEVEL, TEXT, SCOPE, MODULE, ACTION, USER_NAME, CLIENT_IDENTIFIER, CLIENT_INFO, CALL_STACK, UNIT_NAME, LINE_NO, SCN, SID, to_char(EXTRA) EXTRA from logger_logs where id=";
// for(var i=1;i<args.length;i++){
//   sql = sql + args[i];
// }
// ctx.write(sql + "\n\n");

if (args.length > 1) {
    sql = sql + args[1];
} else {
    var last_id = util.executeReturnOneCol("select max(id) from logger_logs");
    sql = sql + last_id;
}

var ret = util.executeReturnListofList(sql,null);

/* loop the rows */
for (var i = 1; i < ret.size(); i++) {
    /*loop the cols */
    for( var ii=0;ii<ret[i].size();ii++) {
        ctx.write(formatCaption(ret[0][ii]) + ": " + formatValue(ret[0][ii], ret[i][ii]) + "\n");
    }
}

ctx.write('\n\n');

