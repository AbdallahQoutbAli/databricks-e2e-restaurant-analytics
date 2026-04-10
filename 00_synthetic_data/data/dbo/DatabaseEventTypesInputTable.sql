create type DatabaseEventTypesInputTable as table
(
    event_category     nvarchar(64),
    event_type         nvarchar(64),
    event_subtype      int,
    event_subtype_desc nvarchar(64),
    severity           int,
    description        nvarchar(max)
)
go

