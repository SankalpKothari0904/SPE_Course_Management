pipeline {
    environment {
        DOCKERHUB_CRED = credentials("Dockerhub-Credentials-ID")
    }
    agent any
    stages {
        stage("Stage 1: Maven Build") {
            steps {
                // Build the custom MySQL image
                dir('sql') {
                    sh 'docker build -t siddharthkothari9403/mysql:latest .'
                }

                // Run the MySQL container
                sh 'docker run -d --rm --name test-db -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=elective_management -p 3308:3306 siddharthkothari9403/mysql:latest'

                // Wait for the database to be ready
                sh '''
                    for i in {1..10}; do
                        if docker exec test-db mysqladmin ping -uroot -proot | grep -q "mysqld is alive"; then
                            echo "Database is ready!";
                            break;
                        fi
                        echo "Waiting for database to be ready...";
                        sleep 5;
                    done
                '''

                // Run Maven build
                dir('ElectiveManagement') {
                    sh 'mvn clean install'
                }

                // Stop the MySQL container
                sh 'docker stop test-db'
            }
        }
        stage("Stage 2: Build Docker Images") {
            parallel {
                stage("Build Frontend Image") {
                    steps {
                        dir('elecfr-web') {
                            sh 'docker build -t sankalpkothari/elecfr-web:latest .'
                        }
                    }
                }
                stage("Build Backend Image") {
                    steps {
                        dir('ElectiveManagement') {
                            sh 'docker build -t sankalpkothari/elective-management:latest .'
                        }
                    }
                }
                stage("Build Database Image") {
                    steps {
                        dir('sql') {
                            sh 'docker build -t sankalpkothari/mysql:latest .'
                        }
                    }
                }
            }
        }
        stage("Stage 3: Push Docker Images to Dockerhub") {
            steps {
                sh 'echo $DOCKERHUB_CRED_PSW | docker login -u $DOCKERHUB_CRED_USR --password-stdin'
                sh 'docker push sankalpkothari/elecfr-web:latest'
                sh 'docker push sankalpkothari/elective-management:latest'
                sh 'docker push sankalpkothari/mysql:latest'
            }
        }
        stage("Stage 4: Ansible Deployment") {
            steps {
                dir('deploy') {
                    sh 'ansible-playbook -i inventory deploy-k8s.yml'
                }
            }
        }
    }
}
