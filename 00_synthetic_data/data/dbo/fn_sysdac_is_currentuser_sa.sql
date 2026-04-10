CREATE FUNCTION [dbo].[fn_sysdac_is_currentuser_sa]() RETURNS int BEGIN DECLARE @engineEdition int = CAST(SERVERPROPERTY('EngineEdition') AS int); DECLARE @is_sa int; IF (@engineEdition IN (5,12)) BEGIN SET @is_sa = 0 IF((CONVERT(varchar(85), suser_sid(), 2) LIKE '0106000000000164%')) SET @is_sa = 1 END IF (@is_sa = 0) BEGIN SET @is_sa = COALESCE(is_srvrolemember('sysadmin'), 0) END RETURN @is_sa; END
go

grant execute on fn_sysdac_is_currentuser_sa to [public]
go

