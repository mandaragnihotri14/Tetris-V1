pipeline{
    agent any
    tools{
        jdk 'jdk17'
        nodejs 'node16'
    }
    environment {
        SCANNER_HOME=tool 'sonar-scanner'
        GIT_REPO_NAME = "Tetris-V1"
        GIT_USER_NAME = "mandaragnihotri14"
    }
    stages {
        stage('clean workspace'){
            steps{
                cleanWs()
            }
        }
        stage('Checkout from Git'){
            steps{
                git branch: 'master', url: 'https://github.com/mandaragnihotri14/Tetris-V1.git'
            }
        }
        stage("Sonarqube Analysis "){
            steps{
                withSonarQubeEnv('sonar-server') {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=TetrisVersion1.0 \
                    -Dsonar.projectKey=TetrisVersion1.0 '''
                }
            }
        }
        stage("quality gate"){
           steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar' 
                }
            } 
        }
        stage('Install Dependencies') {
            steps {
                sh "npm install --save core-js@^3"
            }
        }
       // stage('OWASP FS SCAN') {
        //    steps {
        //       dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'DP-Check'
        //        dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
        //    }
        //}
        stage('TRIVY FS SCAN') {
            steps {
                sh "trivy fs . > trivyfs.txt"
            }
        }
        stage("Docker Build & Push"){
            steps{
                script{
                   withDockerRegistry(credentialsId: 'docker', toolName: 'docker'){   
                       sh "docker build -t tetrisv1 ."
                       sh "docker tag tetrisv1 magnihotri/tetrisv1:latest "
                       sh "docker push magnihotri/tetrisv1:latest "
                    }
                }
            }
        }
        stage("TRIVY"){
            steps{
                sh "trivy image magnihotri/tetrisv1:latest > trivyimage.txt" 
            }
        }
        stage("Update Image in Manifest"){
            steps {
            withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]) {
                sh '''
                    git config user.email "mandaragnihotri14@gmail.com"
                    git config user.name "Mandar Agnihotri"
                    BUILD_NUMBER=${BUILD_NUMBER}
                    sed -i "s/replaceImageTag/${BUILD_NUMBER}/g" deployment.yaml
                    git add deployment.yaml
                    git commit -m "Update deployment image to version ${BUILD_NUMBER}"
                    git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:master
                '''
                }
            }
        }
    }
}
