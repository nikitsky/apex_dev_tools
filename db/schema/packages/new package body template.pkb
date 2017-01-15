create or replace package body <<PACKAGE_NAME>>
as
    gc_scope_prefix         constant VARCHAR2(31)  := lower($$PLSQL_UNIT) || '.';

----------------------------------------------------------------------------------------------------------------------------------
procedure _SET_STATUS(
    pio_id      in out TABLE_NAME.ID%TYPE,
    pi_status   in TABLE_NAME.STATUS%TYPE)
is
    l_params            logger.tab_param;
BEGIN
    logger.append_param(l_params, 'pio_id', pio_id);
    logger.append_param(l_params, 'pi_status', pi_status);

    logger.log_error(
        p_text => logger.sprintf('Process called for %s ', pio_id),
        p_params => l_params,
        p_scope => gc_scope_prefix || 'set_status');

EXCEPTION
    WHEN OTHERS THEN
        logger.log_error(
            p_text => logger.sprintf('Exception %s - %s', SQLCODE, SQLERRM),
            p_params => l_params,
            p_scope => gc_scope_prefix || 'set_status');
        raise;
END _SET_STATUS;

----------------------------------------------------------------------------------------------------------------------------------
procedure _GET_SOMETHING_AJAX
is
    l_json_clob         clob;
    l_json_values       apex_json.t_values;
    l_error             VARCHAR2(2000) := null;

    l_DAY               DATE;
    l_EMPLOYEE          NUMBER;
    l_count				NUMBER;
    l_TASK 				NUMBER;
	l_DESC 				VARCHAR2(100);
BEGIN
    --Get the clob passed in from the Ajax process
    l_json_clob := apex_application.g_clob_01;

    logger.log(
        p_text => logger.sprintf('User: %s, data is in the EXTRA field', apex_application.g_x01),
        p_extra => l_json_clob,
        p_scope => gc_scope_prefix || 'get_something_ajax');


    l_error := 'Cannot parse input data from user' || apex_application.g_x01;
    --Parse JSON-formatted clob and put the members into l_json_values
    apex_json.parse(
        p_values => l_json_values,
        p_source => l_json_clob
    );

    l_error := 'Cannot get date form the input data';
    --get day from input data
    l_DAY := TO_DATE(apex_json.GET_VARCHAR2(
                p_path => 'day',
                p_values => l_json_values
            ), 'DD-MON-RR');

    l_error := 'Cannot get date form the input data';
    --get employee from input data
    l_EMPLOYEE := apex_json.get_number(p_path=>'employee', p_values=>l_json_values);

    --elements count in nester array fav
    l_count := apex_json.get_count(
        p_path   => 'fav',
        p_values => l_json_values
    );

    --get values from nested array
	for idx in 1 .. l_count loop
		l_error := 'Cannot get fav #'||idx;
	    l_TASK     := apex_json.get_number(p_path=>'fav[%d].task', p0=>idx, p_values=>l_json_values);
	    l_DESC     := apex_json.GET_VARCHAR2(p_path=>'fav[%d].desc', p0=>idx, p_values=>l_json_values);
    end loop;

    --Write some JSON out for the response
    apex_json.open_object();
    apex_json.write('status', 'success');
    apex_json.write('employee', l_EMPLOYEE);
    apex_json.close_object();

EXCEPTION
    WHEN OTHERS THEN
        logger.log_error(
            p_text => 'Exception '||l_error,
            p_scope => gc_scope_prefix || 'get_something_ajax');
    --send error back
    apex_json.open_object();
    apex_json.write('status', 'error');
    apex_json.write('message', l_error);
    apex_json.close_object();
END _GET_SOMETHING_AJAX;

/
show error
