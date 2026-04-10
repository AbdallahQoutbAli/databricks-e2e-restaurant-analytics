create type DatabaseEventsInputTable as table
(
    source_id          uniqueidentifier not null,
    source_sequence_id bigint           not null,
    start_time         datetime2        not null,
    end_time           datetime2        not null,
    database_name      sysname,
    event_category     nvarchar(64)     not null,
    event_type         nvarchar(64)     not null,
    event_subtype      int              not null,
    event_count        int              not null,
    activity_id        uniqueidentifier,
    description        nvarchar(max),
    additional_data    xml
)
go

