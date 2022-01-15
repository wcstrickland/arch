# Purpose
#### Create a microservice that allows for flow driven ftp of salesforce files

# Approach

## 1. SF connected app executes initial auth with api key

## 2. credentials for connected app are stored in database

## 3. SF calls out to app with api key. 

## 4. App looks up creds with api key and gets auth to use SF Rest apis.

## 5. App downloads file from SF. 

## 6. App sends file via SFTP. 

## 7. App reports back.

#### Create external heroku app api that recieves requests with the following info.

1. api key used to look up
2. salesforce auth info
3. target file id
4. target ftp server info/auth

#### heroku app then will zip it, send it, and respond with the status of the operation.


# Considerations

- multitenant vs secure single user heroku app
    - API keys. unlimited?
- parallel operations?
- how does it scale?
- how does it interact with salesforce limits
    - API limits but on the consumer org not on the provider app
- cost
- how are the params delivered to the server
    - http Post request with api key to look up creds from inital auth
    as well as target ftp server and id of file for upload



## Node!
- Components
    - ftp client
    - express listener
        - check
    - database for api key auth and sf app credentials
    - middlewares/packages
    - routes
        - initial auth route
        - post route api
        - (future) make use of "get" for api?
    - typescript vs javascript
        - looks like a mix

