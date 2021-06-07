# matrix-synapse-pgsql
Bootstraps a Matrix Synapse Server with PostgreSQL and Nginx Reverse Proxy including TLS certificate in one container (jail) with [BastilleBSD](https://bastillebsd.org/) ready to use.   

---

# DISCLAIMER

Read [synapse](https://github.com/matrix-org/synapse/tree/master/docs) to edit the configuration to your exact needs afterwards. 

By using this template you confirm that you understand the risks of running a (maybe) public accessible service.

---

1. Create container
  
For database/postgres12-server the next 2 lines are mandatory.   

```bash
bastille config TARGET set sysvmsg=new
bastille config TARGET set sysvshm=new
```

2. Bootstrap this template

```bash
bastille bootstrap https://github.com/ddowse/matrix-synapse-pgsql
```

3. Apply this template with your argument values

```bash
bastille template TARGET ddowse/matrix-synapse --arg EMAIL=le@example.org --arg DOMAIN=FQDN --arg PASSWORD=DB_PASS
```

4. This will install the "Basic Package Stack" as shown below.
   - Then creates a Let's Encrypt account with the supplied `EMAIL` address.
   - acme.sh will try to issue a Certficate for the supplied `DOMAIN`
   - Staring postgresql
   - Setup postgresql
   - Create dbuser `synapse_user` with supplied `PASSWORD`
   - Create Datebase `synapse`
   - Generates default configuration for Synapse for the supplied `DOMAIN`
   - bastille will copy the nginx.conf 
   - bastille will Render the configuration for nginx.conf with SSL Certficate
   - bastille will copy the patch directory
   - bastille will Render the homeserver.yaml patch
   - bastille will apply the patch to homeserver.yaml
   - Adding a Cronjob to renew the Certificate
   - Starting nginx
   - Starting synapse

5. Your Synapse Server is now available to further tweaking and reachable over SSL/TLS on `DOMAIN`. 

---

## Basic Package Stack

www/nginx   
database/postgresql12-server   
net-im/py-matrix-synapse   
security/acme.sh  

---

## Defaults & Arguments

acme.sh will listen in standalone mode on IPv6 Address only and will use Let's Encrypt as CA.    
You need to edit `Bastillefile` to change this if you want to use *old* IPv4. 
Then maybe RDR Rules and NAT may apply to your setup. 

The follwing arguments are used. 

`EMAIL` for acme.sh account   
`DOMAIN` is the FQDN for your synapse instance  
`PASSWORD` is for the databaseuser, although local users can login without a password. Edit pg_hba.conf to change this.   
`synapse` is the dbname   
`synapse_user`is the dbuser


---

## Synapse

One how to proceed after a succesful deploy of this container visit the [Synapse docs](https://github.com/matrix-org/synapse/blob/develop/docs/admin_api/user_admin_api.md)

Hint:  

`register_new_matrix_user -u user -p password -a -c /usr/local/etc/matrix-synapse/homeserver.yaml http://localhost:8008` 

---

## Issues

Report template issues on github if it's about general usage of BastilleBSD go to the [docs](https://bastille.readthedocs.io/en/latest/) or join the [Telegram](https://t.me/BastilleBSD) Group for any questions. 
