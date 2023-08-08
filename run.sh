#ABOUT this bash script
#CHModed it like this: 	chmod +x run.sh
#execute it doing this: ./run.sh
#have phun!

port=10070
img_name="lf2_dev_br"
cnt_name="lf2-dev-br"

#Stops the currently runing container, if there is one
echo 'docker stop $cnt_name'
docker stop $cnt_name


#Deletes the current "brobath-test" docker container
echo 'docker container rm $cnt_name'
docker container rm $cnt_name


#Generates the sys_data JS module file
#retrieves and stores in a file the last commit id
FILE_NAME="system_data.js"
NL=''

sdj=''
sdj=$sdj'const sys_data = {'$NL

sdj=$sdj'  "git_commit_id": "'$(git rev-parse --short HEAD)'",'$NL
sdj=$sdj'  "name": "'$img_name'"'$NL
sdj=$sdj'};'$NL
sdj=$sdj'module.exports = sys_data;'

echo $sdj > $FILE_NAME



#To build the docker image:
#NOTE: you must be in the Dockerfile directory with tour terminal
echo 'docker build -t ${img_name} .'
docker build -t $img_name .


#To run naming it but not on background (to see the live console.logs)
#docker run --name $cnt_name --publish $port:$port $img_name


#To run naming it and on background:
echo 'docker run --name $cnt_name -d --publish $port:$port $img_name'
docker run --name $cnt_name -d --publish $port:$port $img_name



#Prints the status of the running containers after deploying this one!
docker ps


#For accessing the running container, run the following code:
#docker exec -it <container_id> /bin/bash
