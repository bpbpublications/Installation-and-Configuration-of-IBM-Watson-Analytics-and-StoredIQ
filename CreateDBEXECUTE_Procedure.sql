-- Create Oracle DBEXECUTE Procedure
CREATE OR REPLACE PROCEDURE ICAUSER.UPDATE_WHITELIST (
LISTID IN VARCHAR2,
LISTTYPE IN VARCHAR2, 
LISTPOSITION IN VARCHAR2,
LISTVALUE IN VARCHAR2,
LISTSTATUS OUT INT
)
IS
   v_STATUS  INT;
BEGIN
      LISTSTATUS := 0;
      INSERT INTO ICAUSER.WHITELIST
                  (LISTID, LISTTYPE, LISTPOSITION, LISTVALUE
                  )
           VALUES (LISTID, LISTTYPE, LISTPOSITION, LISTVALUE                  
);
   SELECT COUNT(*) INTO v_STATUS FROM ICAUSER.WHITELIST WHERE LISTID = LISTID;
  
   LISTSTATUS := v_STATUS;
END;
/
