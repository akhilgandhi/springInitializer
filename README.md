# springInitializer
Shell script for spring initializer

This script will generate a spring boot app by providing the below information:

* **Project type** - can either be **"maven-project"** or **"gradle-project"**
* **Project language** - can be **JAVA**/**KOTLIN**/**GROOVY**
* **Spring boot version**
* **Project metadata** - this includes **groupId**, **artifactId**, **version**, **name**, **description**, and **package name**
* **Project packaging** - either **JAR** or **WAR**
* **JAVA version** - can **14**/**11**/**8**
* **Base directory**
* **Dependencies** - this is a comma separated list of project dependencies. For more use: curl https://start.spring.io/

After generating the project, this script will create a remote github repo and do a initial commit with all the generated code.
