CREATE PROCEDURE [dbo].[sp_sysdac_delete_instance]     @instance_id UniqueIdentifier AS SET NOCOUNT ON; BEGIN     DECLARE @retval INT     DECLARE @partId INT     IF @instance_id IS NULL     BEGIN        RAISERROR(14043, -1, -1, 'instance_id', 'sp_sysdac_delete_instance')        RETURN(1)     END     IF NOT EXISTS (SELECT * from dbo.sysdac_instances WHERE instance_id = @instance_id)     BEGIN         RAISERROR(36004, -1, -1)         RETURN(1)     END     DELETE FROM sysdac_instances_internal WHERE instance_id=@instance_id     SELECT @retval = @@error     RETURN(@retval) END
go

grant execute on sp_sysdac_delete_instance to [public]
go

