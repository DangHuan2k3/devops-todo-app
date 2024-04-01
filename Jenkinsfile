#!/usr/bin/env groovy

import groovy.transform.Field

@Field
String SSH_ID_REF = 'ssh-credentials-id'
@Field
String DOCKER_USER_REF = 'huan-dockerhub'

pipeline {
    agent any

    tools {
        dockerTool 'docker'
    }

    stages {
        stage('Build') {
            steps {
                sh 'docker build -t danghuan2k3/todo-app:0.0.2 .'
            }
        }
        stage("Docker login and push docker image") {
            steps {
                withBuildConfiguration {
                    sh 'docker login --username ${repository_username} --password ${repository_password}'
                    sh 'docker push danghuan2k3/todo-app:0.0.2'        		
                }
            }
        }
        stage("deploy") {
             steps {
                 withBuildConfiguration {
                     sshagent(credentials: [SSH_ID_REF]) {
                         sh '''
                            ssh -o StrictHostKeyChecking=no root@ec2-18-143-167-76.ap-southeast-1.compute.amazonaws.com "docker run --detach --name huan-todo-app -p 3000:8000 danghuan2k3/todo-app:0.0.2"
                            docker ps
                            '''
                    }
                }
            }
        }
    }
}

void withBuildConfiguration(Closure body) {
    withCredentials([usernamePassword(credentialsId: DOCKER_USER_REF, usernameVariable: 'repository_username', passwordVariable: 'repository_password')]) {
        body()
    }
}
