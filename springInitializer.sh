#!/bin/bash

#exec 1>>/home/akhil/Development/output.log
#exec 2>>/home/akhil/Development/errors.log

reset

echo "CHOOSE PROJECT TYPE : "
echo "  1. MAVEN PROJECT"
echo "  2. GRADLE PROJECT"
while :
do
    read choice
    case $choice in
    1)
        echo "Project type will be MAVEN"
        projectType="maven-project"
        break
        ;;
    2)
        echo "Project type will be GRADLE"
        projectType="gradle-project"
        break
        ;;
    *)
        echo "Incorrect choice!!!"
        ;;
    esac
done

reset

echo "CHOOSE PROJECT LANGUAGE : " 
echo "  1. JAVA"
echo "  2. KOTLIN"
echo "  3. GROOVY"
while : 
do
    read choice
    case $choice in 
        1) 
            echo "Project language will be set as JAVA"
            language="java"
            break
            ;;
        2)
            echo "Project language will be set as KOTLIN"
            language="kotlin"
            break
            ;;
        3)
            echo "Project language will be set as GROOVY"
            language="groovy"
            break
            ;;
        *)
            echo "Incorrect choice!!!"
            ;;
    esac
done

reset

echo "CHOOSE SPRING BOOT VERSION : "
echo "  1. 2.3.1"
echo "  2. 2.2.8"
echo "  3. 2.1.15"
while : 
do
    read choice
    case $choice in 
        1) 
            echo "Spring boot version will be set as 2.3.1.RELEASE"
            bootVersion="2.3.1.RELEASE"
            break
            ;;
        2)
            echo "Spring boot version will be set as 2.2.8.RELEASE"
            bootVersion="2.2.8.RELEASE"
            break
            ;;
        3)
            echo "Spring boot version will be set as 2.1.15.RELEASE"
            bootVersion="2.1.15.RELEASE"
            break
            ;;
        *)
            echo "Incorrect choice!!!"
            ;;
    esac
done

reset

echo "READING PROJECT METADATA : "
read -p "   GROUP : " groupId
read -p "   ARTIFACT : " artifactId
read -p "   VERSION : " version
read -p "   NAME : " name
read -p "   DESCRIPTION : " description
read -p "   PACKAGE NAME : " packageName

reset

echo "CHOOSE PACKAGING : "
echo "  1. JAR"
echo "  2. WAR"
while : 
do
    read choice
    case $choice in 
        1) 
            echo "Project will be packaged as JAR"
            packaging="jar"
            break
            ;;
        2)
            echo "Project will be packaged as WAR"
            packaging="war"
            break
            ;;
        *)
            echo "Incorrect choice!!!"
            ;;
    esac
done

reset

echo "CHOOSE JAVA VERSION : "
echo "  1. 14"
echo "  2. 11"
echo "  3. 8"
while : 
do
    read choice
    case $choice in 
        1) 
            echo "Java version will be set as 14"
            javaVersion="14"
            break
            ;;
        2)
            echo "Java version will be set as 11"
            javaVersion="11"
            break
            ;;
        3)
            echo "Java version will be set as 1.8"
            javaVersion="1.8"
            break
            ;;
        *)
            echo "Incorrect choice!!!"
            ;;
    esac
done

reset

read -p "BASE DIRECTORY : " baseDir

reset

echo "Please enter all the dependencies needed for the spring boot project, must be comma separated. For more details use: curl https://start.spring.io/ : "
read dependencies

reset

curl https://start.spring.io/starter.zip -d groupId=$groupId -d artifactId=$artifactId -d version=$version -d name=$name -d description="$description" -d packageName=$packageName -d dependencies=$dependencies -d language=$language -d javaVersion=$javaVersion -d bootVersion=$bootVersion -d packaging=$packaging -d type=$projectType -d baseDir=$baseDir -o demo.zip

unzip -qq demo.zip

rm -f demo.zip

echo "NOW SETTING UP GITHUB REPO"

reset

# setup the above project in github and make a initial commit

# step 1: name of the remote repo. Enter a single word ..or.. separate with hyphens
read -p "ENTER NAME YOU WANT TO GIVE TO YOUR REMOTE REPO? " repo_name

read -p "ENTER A DESCRIPTION FOR YOUR REPO " repo_description

reset

# step 2: provide github user name
read -p "ENTER GITHUB USERNAME " username

reset

# step 3: goto local project folder path
CURRENTDIR=$(pwd)

cd ${CURRENTDIR}/${baseDir}

# step 4: initialize repo locally, create blank README, add and commit
git init
touch README.md
git add .
git commit -m "initial commit using shell script"

echo "GIT REPO INITIALIZED "

# step 5: use github API to log the user in
curl -H 'Authorization: token 952e25d623ebe8621bab1355ec8e3e5a269381cf' https://api.github.com/user/repos -d "{\"name\": \"${repo_name}\", \"description\": \"${repo_description}\"}"

# step 6: add the remote github repo to local repo and push
git remote add origin https://github.com/${username}/${repo_name}.git
git push --set-upstream origin master

echo "PUSHED TO REMOTE REPO "

echo "Done. Go to https://github.com/$username/$repo_name to see."
echo " *** You're now in you project root *** "
