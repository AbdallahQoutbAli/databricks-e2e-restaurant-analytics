CREATE FUNCTION [dbo].[fn_sysdac_is_login_creator]() RETURNS int BEGIN DECLARE @engineEdition int = CAST(SERVERPROPERTY('EngineEdition') AS int); DECLARE @islogincreator int; IF (@engineEdition IN (5,12)) BEGIN SET @islogincreator = COALESCE(IS_MEMBER('loginmanager'), 0) | dbo.fn_sysdac_is_currentuser_sa() END ELSE BEGIN SET @islogincreator = HAS_PERMS_BY_NAME(null, null, 'ALTER ANY LOGIN') END RETURN @islogincreator; END
go

grant execute on fn_sysdac_is_login_creator to [public]
go

