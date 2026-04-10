create table sysdac_instances_internal
(
    instance_id   uniqueidentifier                                               not null
        constraint PK_sysdac_instances_internal
            primary key,
    instance_name sysname                                                        not null
        constraint UQ_sysdac_instances_internal
            unique,
    type_name     sysname                                                        not null,
    type_version  nvarchar(64)                                                   not null,
    description   nvarchar(4000) default '',
    type_stream   varbinary(max)                                                 not null,
    date_created  datetime       default getdate()                               not null,
    created_by    sysname        default [dbo].[fn_sysdac_get_currentusername]() not null
)
go

grant select on sysdac_instances_internal to [public]
go

