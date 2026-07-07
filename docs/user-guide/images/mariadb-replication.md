# MariaDB Replication

In this document, we will discuss how to enable replication on an existing MariaDB database.

!!! tip
    **Notes**
    → All of the shell commands will be performed inside of the SFTP container.
    → Whenever you see the ***server-id***, this needs to be a unique number for *each* server.
    → When you see `-pPW` in the mysql commands, ***the lack of a space is intentional!***

## Prepare Primary Database

### Enable Replication

Edit the running service and add the following commands to the ***Command Override*** section.

```bash
--log-bin --binlog-format=mixed --server-id=1001 --log-basename=primary1 --expire-logs-days=2
```

*Rebuild the primary database container.*

### Create the replication user

From the sftp container, gain access to the mysql console with: `mysql -u root -h IP-Of-Primary -p`

```sql
CREATE USER 'repluser'@'%' IDENTIFIED BY 'bigs3cret';
GRANT REPLICATION SLAVE ON *.* TO 'repluser'@'%';
```

### Dump database on primary

Enter a SQL shell once again, and run:

```sql
FLUSH TABLES WITH READ LOCK;
SET GLOBAL read_only = ON;
SHOW MASTER STATUS;
```

- That last step will print out something like the following:
    
    ```sql
    MariaDB [(none)]> SHOWMASTER STATUS;
    +---------------------+----------+--------------+------------------+
    | File                | Position | Binlog_Do_DB | Binlog_Ignore_DB |
    +---------------------+----------+--------------+------------------+
    | primary1-bin.000002 |     1225 |              |                  |
    +---------------------+----------+--------------+------------------+
    ```
    
    ***Make note of the File and Position values.***
    

Exit that prompt and dump the database.

```bash
mariadb-dump -h IP-of-primary -pPW --databases DB-NAME > db.sql
```

!!! warning
    It’s important that you include the `--databases DB-NAME` portion. If you just say the db name without that, the dump will not include any database create statements.

Once that’s finished, re-enter the SQL shell:

```sql
SET GLOBAL read_only = OFF;
UNLOCK TABLES;
```

## Enable Replication on Secondary

### Configure secondary container

Edit the running service and add the following commands to the ***Command Override*** section.

```bash
--server-id=2001 --log-bin=mysql-bin --sync-binlog=1 --relay-log=mysql-relay-bin --log-slave-updates=1 --read-only=1 --expire-logs-days=2
```

*Rebuild the secondary container*

### Import the database

```bash
mysql -u root -h IP-OF-SECONDARY -u root -pROOTPW < db.sql
```

### Enable Replication on the Secondary DB

Enter a SQL shell with: `mysql -u root -h IP-OF-SECONDARY -p`

```sql
STOP SLAVE;

CHANGE MASTER TO 
	MASTER_HOST='ip-of-primary', 
	MASTER_USER='repluser', 
	MASTER_PASSWORD='bigs3cret', 
	MASTER_PORT=3306, 
	MASTER_CONNECT_RETRY=10, 
	MASTER_LOG_FILE='primary1-bin.000002', 
	MASTER_LOG_POS=1225,
	MASTER_USE_GTID=slave_pos;

START SLAVE;
```

You can follow along with the status using: `SHOW SLAVE SATUS \G;`

To confirm everything is working, you want to see the following in the result:

```
...
Slave_IO_Running: Yes
Slave_SQL_Running: Yes
...
Seconds_Behind_Master: 0
```
