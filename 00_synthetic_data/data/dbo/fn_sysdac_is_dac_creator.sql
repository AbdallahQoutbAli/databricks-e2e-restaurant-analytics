CREATE FUNCTION [dbo].[fn_sysdac_is_dac_creator]() RETURNS int BEGIN DECLARE @engineEdition int = CAST(SERVERPROPERTY('EngineEdition') AS int); DECLARE @isdaccreator int; IF (@engineEdition IN (5,12)) BEGIN SET @isdaccreator = COALESCE(IS_MEMBER('dbmanager'), 0) | dbo.fn_sysdac_is_currentuser_sa() END ELSE BEGIN SET @isdaccreator = COALESCE(is_srvrolemember('dbcreator'), 0) END RETURN @isdaccreator; END
go

grant execute on fn_sysdac_is_dac_creator to [public]
go

