pipeline {
    agent any

    environment {
        OUTPUT_DIR = 'output'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/gnusaleem/buildroot.git', branch: 'devel'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                sudo apt-get update
                sudo apt-get install -y build-essential bison flex gettext libtool libncurses5-dev
                '''
            }
        }

        stage('Clean Environment') {
            steps {
                sh '''
                if [ -d ${OUTPUT_DIR} ]; then
                    rm -rf ${OUTPUT_DIR}
                fi
                '''
            }
        }

        stage('Configure Buildroot') {
            steps {
                sh 'make O=${OUTPUT_DIR} raspberrypi4_64_defconfig'
            }
        }

        stage('Build') {
            steps {
                sh 'make O=${OUTPUT_DIR}'
            }
        }

        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: "${OUTPUT_DIR}/images/*", fingerprint: true
            }
        }
    }

    post {
        success {
            echo 'Build completed successfully!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
