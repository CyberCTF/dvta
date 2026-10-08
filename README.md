# DVTA

[DVTA, Damn Vulnerable Thick Client App](https://github.com/srini0x00/dvta) by Srinivas
(srini0x00): a .NET Windows client for an expense tracker, talking to SQL Server and FTP, built
from vulnerabilities found in real thick client pentests. This repository runs it with
[Isoloom](https://www.isoloom.com): [`isoloom.yml`](isoloom.yml) describes the machine, and
[`provision/main.yml`](provision/main.yml) sets up the back end and installs upstream's compiled
client (vendored with its source in [`dvta/`](dvta)) from a controller.

| Machine | Services |
| --- | --- |
| win01 (Windows Server 2019) | SQL Server 2019 Express (instance SQLEXPRESS, TCP 1433), FTP 21, RDP 3389, the DVTA client on the desktop |

## Run it

```bash
isoloom run vagrant
isoloom test vagrant
```

About 5 GB of memory (4 GB for the machine, 1 GB for the controller); the first run downloads
SQL Server Express (about 250 MB) inside the machine. RDP to the machine's lab address as
vagrant/vagrant and start DVTA from the desktop. Bring your own tools (dnSpy or ILSpy, Process
Monitor, Wireshark, Echo Mirage, a SQL client).

The client is upstream's, unchanged: its Configure button is disabled, and enabling it is the
first challenge. Then configure the server as 127.0.0.1 (the back end runs on the same machine).
Users: rebecca/rebecca, raymond/raymond, admin/admin123. The database login is `sa` /
`p@ssw0rd` and the FTP account `dvta` / `p@ssw0rd`, as upstream's set-up. Upstream's video
uses FileZilla Server for FTP; this lab uses Windows' own IIS FTP server.

Lab guide: upstream's [README](dvta/README.md) and its set-up videos.
Upstream version and commit: [UPSTREAM.md](UPSTREAM.md).

## Licence

MIT, as DVTA ([LICENSE](LICENSE)). SQL Server Express is downloaded from Microsoft under its own
licence terms, accepted by the set-up (`/IACCEPTSQLSERVERLICENSETERMS`). The application is
deliberately vulnerable: keep it isolated.
