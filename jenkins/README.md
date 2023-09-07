
## JENKINS DATA as below
- Manage Jenkins -->Plugins for plugin installaiton.
- Manage Jenkins --> System
- Manage Jenkins --> tools
- Manage Jenkins  --> nodes and clouds
- Manage Jenkins --> backup manager
- Manage Jenkins -- > security 
- Manage Jenkins --> credentials 
- Manage Jenkins --> system information : will show complete system information like 
    - jenkins version,java verison, windows os and version, 
    - workspace home path, java home etc .

- what are post build actions?
 - archive artifacts. 
 - build other projects
 - E-mail notificatoins.
 - delete workspace when build is done
 - publish html reports
 - 
- some build tools are as below
 - gradle: for python
 - apache maven: for java
 - npm: for java scripts
 - MSBuild: for .NET
 - ANT: for java
- Static code analysis tools
  - ESLint: for java script
  - PyLint: for python 
  - sonarqube: an opensource platform for contineus inspection of code quality. it supports multiple languages. 
- what are artifactory tools 
 - JFrog Artifactory:  The core product, JFrog Artifactory, serves as a universal repository manager. It supports various package formats, including Maven, npm, Docker, PyPI, and more. It allows you to store, retrieve, and manage binary artifacts and their metadata in a highly customizable and organized manner. Developers use Artifactory to store and share software libraries and dependencies.
 - JFrog Container Registry: This is a specialized version of Artifactory designed specifically for managing Docker images. It allows you to host Docker repositories, including Helm charts, and provides tools for scanning container images for vulnerabilities.
 - Nexus: Nexus is another popular tool used for artifact and repository management in software development.

## Sample jenkins DECLARATIVE pipeline 

```t
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Check out code from a Git repository
                checkout scm
            }
        }

        stage('Build') {
            steps {
                // Compile and package a Java application (assuming a Maven project)
                sh 'mvn clean package'
            }
        }

        stage('Archive') {
            steps {
                // Archive the JAR file as a build artifact
                archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
            }
        }
    }

    post {
        success {
            // This block runs if the pipeline is successful
            echo 'Build successful! Deploy your application.'
        }
        failure {
            // This block runs if the pipeline fails
            echo 'Build failed! Check the build logs for errors.'
        }
    }
}

```

## Sample jenkins SCRIPTED pipeline 

```t 
node {
    // Checkout code from a Git repository
    stage('Checkout') {
        checkout scm
    }

    try {
        // Compile and package a Java application (assuming a Maven project)
        stage('Build') {
            sh 'mvn clean package'
        }

        // Archive the JAR file as a build artifact
        stage('Archive') {
            archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
        }

        // This block runs if the pipeline is successful
        stage('Success') {
            echo 'Build successful! Deploy your application.'
        }
    } catch (Exception e) {
        // This block runs if the pipeline fails
        currentBuild.result = 'FAILURE'
        stage('Failure') {
            echo 'Build failed! Check the build logs for errors.'
        }
    } finally {
        // Cleanup or post-build actions can go here
    }
}

```
## Declaring ENVIRONMENT variables in jenkins file
```t
environment { ①
  CC = 'clang'
  }

```


