pipeline {
    agent { label 'server1-walid' }

    stages {
        stage('Pull SCM') {
            steps {
                git branch: 'main', url: 'https://github.com/wmustaqim19/simple-apps.git'
            }
        }
        
        stage('Build') {
            steps {
                sh'npm install'
            }
        }
        
        stage('Testing') {
            steps {
                sh'''
                cp app/.env .
                APP_PORT=5001 npm test
                APP_PORT=5001 npm run test:coverage
                '''
            }
        }
        
        stage('Code Review') {
            steps {
                sh'''
                sonar-scanner \
                    -Dsonar.projectKey=simple-apps \
                    -Dsonar.sources=. \
                    -Dsonar.host.url=http://172.23.2.122:9000 \
                    -Dsonar.login=sqp_0f11c3f16197d54d6061caf7055276f04a9193cf
                '''
            }
        }
        
        stage('Deploy') {
            steps {
                sh'''
                docker compose up --build -d
                '''
            }
        }
        
        stage('Backup') {
            steps {
                 sh 'docker compose push' 
            }
        }
    }
}