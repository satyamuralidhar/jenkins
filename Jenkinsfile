pipeline {
    agent any 
        stages {
            stage('build begin') {
                steps {
                    slackSend channel: 'devpoc', message: 'build is started ra macha'
                }
            }
            stage('touch'){
                steps {
                    sh 'rm -rf satya.py'
                    sh 'touch satya.py'
                    sh label: '', script: 'echo "print(\'hi satya\')" >> satya.py'
                }
            }    
            stage('perm') {
                steps {
                    sh 'chmod 777 satya.py'
                }
            }
            stage('hello') {
                steps {
                    sh 'python satya.py'
                }
            }
        }
        post {
        success {
            slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")

        }
        failure {
            slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        } 
    }        
    
}
