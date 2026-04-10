CREATE PROCEDURE [dbo].[sp_sysdac_rename_database]     @database_name sysname,     @new_name sysname AS SET NOCOUNT ON; BEGIN     DECLARE @sqlstatement nvarchar(1000)     DECLARE @quoted_database_name nvarchar(258)     SET @quoted_database_name = QUOTENAME(@database_name)     SET @sqlstatement = 'ALTER DATABASE ' + @quoted_database_name + ' SET SINGLE_USER WITH ROLLBACK IMMEDIATE'     EXEC (@sqlstatement)     EXEC sp_rename @objname=@quoted_database_name, @newname=@new_name, @objtype='DATABASE'     DECLARE @quoted_new_name nvarchar(258)     SET @quoted_new_name = QUOTENAME(@new_name)     SET @sqlstatement = 'ALTER DATABASE ' + @quoted_new_name + ' SET MULTI_USER WITH ROLLBACK IMMEDIATE'     EXEC (@sqlstatement)     RETURN(@@error) END
go

grant execute on sp_sysdac_rename_database to [public]
go

