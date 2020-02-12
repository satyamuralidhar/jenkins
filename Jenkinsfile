pipeline {
    agent any 
        stages {
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
    
}
