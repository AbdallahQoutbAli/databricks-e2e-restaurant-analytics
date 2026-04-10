CREATE FUNCTION [dbo].[fn_sysdac_get_currentusername]()
RETURNS sysname
BEGIN
    RETURN SUSER_SNAME();
END
go

grant execute on fn_sysdac_get_currentusername to [public]
go

