create or replace trigger NEW_TABLE_NAME_BUI
    before insert or update on NEW_TABLE_NAME
    for each row
begin

    if inserting then
        if :NEW.ID is null then
            SELECT NEW_SEQUENCE_SEQ.NEXTVAL INTO :new.ID FROM DUAL;
        end if;
    end if;

    :NEW.UPDATED_AT := localtimestamp;
    :NEW.UPDATED_BY := COALESCE(SYS_CONTEXT ('APEX$SESSION', 'app_user'),USER);
end;

/

show error