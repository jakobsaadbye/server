create table if not exists boards(
    id varchar(64) primary key,
    title varchar(255),
    created_at timestamptz default current_timestamp,
    updated_at timestamptz default current_timestamp
);

create table if not exists columns(
    id varchar(64) primary key,
    board_id varchar(64) references boards(id) on delete cascade,
    title varchar(255),
    position real
);

create table if not exists todos(
    id varchar(64) primary key,
    board_id varchar(64) references boards(id) on delete cascade,
    column_id varchar(64) references columns(id) on delete cascade,
    title varchar(255),
    description varchar,
    position real,
    updated_at timestamptz default current_timestamp
);

create table if not exists crr_changes(
    id text not null,
    type text not null,
    tbl_name text not null,
    col_id text,
    pk text not null,
    value any,
    site_id text not null,
    created_at bigint not null,
    applied_at bigint not null,
    seq integer,
    primary key(id, type, tbl_name, col_id, pk, value, site_id, created_at, applied_at, seq)
);

create table if not exists crr_client(
    site_id primary key,
    last_pulled_at bigint not null default 0,
    last_pushed_at bigint not null default 0
);