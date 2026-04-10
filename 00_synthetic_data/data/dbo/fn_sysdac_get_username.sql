CREATE FUNCTION [dbo].[fn_sysdac_get_username](@user_sid varbinary(85)) RETURNS sysname WITH EXECUTE AS OWNER BEGIN DECLARE @engineEdition int = CAST(SERVERPROPERTY('EngineEdition') AS int); DECLARE @current_user_name sysname; IF (@engineEdition IN (5,12)) BEGIN  SELECT @current_user_name = name FROM sys.sql_logins where sid = @user_sid END ELSE BEGIN SELECT @current_user_name = name FROM sys.syslogins where sid = @user_sid END RETURN @current_user_name; END
go

grant execute on fn_sysdac_get_username to [public]
go

