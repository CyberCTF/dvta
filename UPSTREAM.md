# Upstream

| Dir | Repository | Version | Commit | Licence |
| --- | --- | --- | --- | --- |
| dvta | https://github.com/srini0x00/dvta | master (2021-06-12, after release 2.0) | c865a6ff41597fabf0cc1739e93baf9e3e471a9f | MIT |

`dvta/` is that commit, unchanged, without its Git history. It holds the C# source and
upstream's compiled client (`DVTA/bin/Release/`, the 2.0 client with the configurable server),
which `provision/main.yml` copies to the machine. The back end follows upstream's README and
set-up videos: SQL Server Express (here 2019, `SQLEXPR_x64_ENU.exe` from Microsoft, SHA-256
pinned) with the README's tables and users and `sa` / `p@ssw0rd` (the password the client ships
encrypted), and an FTP server with the client's upload account `dvta` / `p@ssw0rd`. Upstream's
video uses FileZilla Server; this lab uses Windows' own IIS FTP server.

To update, replace `dvta/` with a newer commit, then this table.
