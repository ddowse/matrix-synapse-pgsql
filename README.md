# matrix-synapse-pgsql
Bootstraps a Matrix Synapse Server with PostgreSQL in one container (jail) with [BastilleBSD](https://bastillebsd.org/)  

# DISCLAIMER

Read [synapse](https://github.com/matrix-org/synapse/tree/master/docs) to edit the configuration to your exact needs. 

By using this template you confirm that you understand the risks of running a (maybe) public accessible service.

## Basic Packages

www/nginx   
database/postgresql12-server   
net-im/py-matrix-synapse   
security/acme.sh   

## Defaults

acme.sh will listen in standalone mode on IPv6 Address only and will use Let's Encrypt as CA.    
You need to edit `Bastillefile` to change this if you want to use *old* IPv4. 
Then maybe RDR Rules and NAT may apply to your setup. 

The follwing arguments are used. 

EMAIL for acme.sh account
DOMAIN is the FQDN for your synapse instance

PASSWORD is for the databaseuser `synapse_user` on db `synapse` although local users can login without a password.   
Edit pg_hba.conf to change this. 

Database: `synapse` 
User: `synapse_user`

## DNS

Do not forget to add a AAAA Record to your Zone for the (Sub) Domain. 

## Basic

Create a (vnet) container (jail) with `bastille` as usual. For database/postgres12-server the next 2 lines are mandatory.   
Replace `matrix-synapse` with your name for the container. 

```bash
bastille config matrix-synapse set sysvmsg=new
bastille config matrix-synapse set sysvshm=new
```

```bash
bastille bootstrap https://github.com/ddowse/matrix-synapse-pgsql
```

## Bootstrap

```bash
bastille template matrix-synapse ddowse/matrix-synapse \
--arg EMAIL=valid@email.address \
--arg DOMAIN=FQDN \
--arg PASSWORD=DB_PASS
```

## Synapse

One how to proceed after a succesful deploy of this container visit the [Synapse docs](https://github.com/matrix-org/synapse/blob/develop/docs/admin_api/user_admin_api.md)

Hint: `register_new_matrix_user -u <User> -p <Passphrase> -a -c /usr/local/etc/matrix-synapse/homeserver.yaml http://localhost:8008` 

## Issues

Report template issues on github if it's about general usage of BastilleBSD go to the [docs](https://bastille.readthedocs.io/en/latest/) or join the [Telegram](https://t.me/BastilleBSD) for any questions. 
