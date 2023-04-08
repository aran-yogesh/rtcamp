# rtcamp

This script first checks if Docker and docker-compose are installed on the system, and installs them if they are missing.


![Screenshot (44)](https://user-images.githubusercontent.com/63587953/230719626-bd704f18-b5d1-46b2-89b5-c728ed76251f.png)

Then, it gets the site name from the command-line argument and creates a docker-compose file for the WordPress site.


![Screenshot (45)](https://user-images.githubusercontent.com/63587953/230719716-b18b07c2-df66-48c1-a3e1-771cd8d27346.png)

Next, it creates an entry in the /etc/hosts file for the site.

After that, it defines three subcommands: enable, disable, and delete. The enable subcommand brings up the WordPress site in a Docker container, the disable subcommand stops and removes the containers, and the delete subcommand removes the containers and deletes all the site files.

![Screenshot (46)](https://user-images.githubusercontent.com/63587953/230719802-b6f073fa-19c8-479d-9046-9a1609557ca9.png)

Finally, it checks if a subcommand has been provided and executes the corresponding function. If no subcommand has been provided, it executes the enable_site function by default.

![Screenshot (47)](https://user-images.githubusercontent.com/63587953/230719828-5e5a4639-2f48-481c-9572-d00e37bf2d87.png)

the script throws an error when its not given a bash run.sh then it runs fine when we give a "example.com " arguement and enable argument since my system has docker, docker-compose and wordpress already installed so its already upto date in the result image

![Screenshot (48)](https://user-images.githubusercontent.com/63587953/230720295-0349411a-1ac6-4834-9d51-1ab9b8776aad.png)

