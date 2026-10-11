# Places the player's flag (CTF_FLAG_MAIN, given by the launcher) in DVTA's database: an expense
# of the admin user (item = the flag), the record the admin's data export and the database
# itself expose. Without one (CI, a run by hand) the development flag.
# Runs before the playbook: on a first start SQL Server is not installed yet, so the flag waits
# in C:\ctf\flag.txt (Administrators and SYSTEM only) for the playbook's "Flag" task, which
# writes the record and deletes the file. On a later run (SQL Server already up) it writes the
# record directly. Plain PowerShell 2.0, as the other Windows labs.
$ErrorActionPreference = 'Stop'
$dev = 'FLAG{dev-dvta}'
$flag = $env:CTF_FLAG_MAIN
if (-not $flag) { $flag = $dev }
$cs = 'Data Source=127.0.0.1\SQLEXPRESS;Initial Catalog=DVTA;User Id=sa;Password=p@ssw0rd;Connect Timeout=5'
$c = New-Object System.Data.SqlClient.SqlConnection($cs)
try { $c.Open() } catch { $c = $null }
if ($c) {
  try {
    $cmd = $c.CreateCommand()
    $cmd.CommandText = "DELETE FROM dbo.expenses WHERE email = 'admin@damnvulnerablethickclientapp.com'; INSERT INTO dbo.expenses (email, item, price, date, time) VALUES ('admin@damnvulnerablethickclientapp.com', @flag, '0', '01/01/2020', '00:00')"
    $cmd.Parameters.AddWithValue('@flag', $flag) | Out-Null
    $cmd.ExecuteNonQuery() | Out-Null
  } finally { $c.Close() }
  if (Test-Path 'C:\ctf') { Remove-Item -Recurse -Force 'C:\ctf' }
  exit 0
}
$dir = 'C:\ctf'
$file = Join-Path $dir 'flag.txt'
New-Item -ItemType Directory -Force -Path $dir | Out-Null
[IO.File]::WriteAllText($file, $flag, (New-Object Text.ASCIIEncoding))
foreach ($p in @($dir, $file)) {
  icacls $p /inheritance:r /grant:r '*S-1-5-32-544:(F)' '*S-1-5-18:(F)' | Out-Null
  if ($LASTEXITCODE -ne 0) { throw "icacls $p failed" }
}
exit 0
