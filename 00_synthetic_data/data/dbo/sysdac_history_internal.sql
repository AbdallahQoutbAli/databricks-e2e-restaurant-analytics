create table sysdac_history_internal
(
    action_id                int                                                      not null,
    sequence_id              int                                                      not null,
    instance_id              uniqueidentifier                                         not null,
    action_type              tinyint                                                  not null,
    action_type_name         as case [action_type]
                                    when 0 then 'deploy'
                                    when 1 then 'create'
                                    when 2 then 'rename'
                                    when 3 then 'register'
                                    when 4 then 'create objects'
                                    when 5 then 'detach'
                                    when 6 then 'delete'
                                    when 7 then 'data transfer'
                                    when 8 then 'disable constraints'
                                    when 9 then 'move data'
                                    when 10 then 'enable constraints'
                                    when 11 then 'copy permissions'
                                    when 12 then 'set readonly'
                                    when 13 then 'upgrade'
                                    when 14 then 'unregister'
                                    when 15 then 'update registration'
                                    when 16 then 'set readwrite'
                                    when 17 then 'disconnect users' end,
    dac_object_type          tinyint                                                  not null,
    dac_object_type_name     as case [dac_object_type]
                                    when 0 then 'dacpac'
                                    when 1 then 'login'
                                    when 2 then 'database' end,
    action_status            tinyint                                                  not null,
    action_status_name       as case [action_status]
                                    when 0 then 'not started'
                                    when 1 then 'pending'
                                    when 2 then 'success'
                                    when 3 then 'fail'
                                    when 4 then 'rollback' end,
    required                 bit,
    dac_object_name_pretran  sysname                                                  not null,
    dac_object_name_posttran sysname                                                  not null,
    sqlscript                nvarchar(max),
    payload                  varbinary(max),
    comments                 varchar(max)                                             not null,
    error_string             nvarchar(max),
    created_by               sysname  default [dbo].[fn_sysdac_get_currentusername]() not null,
    date_created             datetime default getdate()                               not null,
    date_modified            datetime default getdate()                               not null,
    constraint PK_sysdac_history_internal
        primary key (action_id, sequence_id),
    constraint UQ_sysdac_history_internal
        unique (action_id, dac_object_type, action_type, dac_object_name_pretran, dac_object_name_posttran)
)
go

create index IX_sysdac_history_internal
    on sysdac_history_internal (sequence_id, action_status)
go

grant select on sysdac_history_internal to [public]
go

