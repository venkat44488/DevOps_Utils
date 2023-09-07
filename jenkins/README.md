
# JENKINS DATA as below
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
# sample jenkins DECLARATIVE pipeline 

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

# sample jenkins SCRIPTED pipeline 

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


