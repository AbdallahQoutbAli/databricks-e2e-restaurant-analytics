CREATE PROCEDURE dbo.sp_sysdac_ensure_dac_creator AS BEGIN IF (dbo.fn_sysdac_is_dac_creator() != 1) BEGIN RAISERROR(36010, -1, -1); RETURN(1); END END
go

grant execute on sp_sysdac_ensure_dac_creator to [public]
go

