#Setup and maintain web- and mailservers with salt

## What I have
At the moment I have three servers:

* Ubuntu 14.04 instance in Amsterdam (DigitalOcean)
* Ubuntu 14.04 instance in Singapore (DigitalOcean)
* Debian 7 instance somewhere in Canada (CloudAtCost)

## What's the problem?

The DigitalOcean machines are pre-installed with [iRedMail](http://www.iredmail.org/), 
but I modified it to suit my needs better. In short I have three  problems: 

* Maintenance is too time consuming
* Modifications are not reproduceable
* Differences between Debian and Ubuntu

## What's the solution?

I think that I can build a salt script which supports me with the maintenance 
and makes my modifications (to a certain degree) OS agnostic. 

## What's the plan?

I want to reverse engineer the iRedAdmin script and port it to salt, that I can spawn up new instances when needed. 
Maybe in the long run I will also replace the quite useless admin UI and replace it with something helpful, that people can
do some basic tasks like add new subdomains or create an email alias. Another nice to have feature would be if the customer YAML
file created itself from the database...