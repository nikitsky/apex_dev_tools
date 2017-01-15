// script transposes a record
// usage:
//  1) script transpose select table_name, NUM_ROWS from dba_tables where owner='SCOTT'
//  2) script transpose AMC_SERVICES 19 => script transpose select * from AMC_SERVICES where ID=19

function formatCaption( pFieldName ) {
    var lFiller = " ";
    for (var n = 0; n < 17 - pFieldName.length; n++) {
        lFiller = lFiller + " ";
    }
    return lFiller + pFieldName;
};

var sql="";

if (args.length == 1) {
    ctx.write('Transpose a record\n');
    ctx.write('usage:\n');
    ctx.write(" 1) script transpose select table_name, NUM_ROWS from dba_tables where owner='SCOTT'\n");
    ctx.write(" 2) script transpose AMC_SERVICES 19 \n");
    ctx.write("        is a shortcut for \n    script transpose select * from AMC_SERVICES where ID=19\n");
} else {
    if (args.length == 3) {
            sql = "select * from " + args[1] + " where id=" + args[2];
        } else {
            for(var i=1;i<args.length;i++){
              sql = sql + " " + args[i];
            }
        }
        ctx.write(sql + "\n\n");

        var ret = util.executeReturnListofList(sql,null);

        /* loop the rows */
        for (var i = 1; i < ret.size(); i++) {
            /*loop the cols */
            for( var ii=0;ii<ret[i].size();ii++) {
                ctx.write(formatCaption(ret[0][ii]) + ": " + ret[i][ii] + "\n");
            }
            ctx.write('--------------------------------------------\n\n');
        }

        ctx.write('\n\n');
    }

