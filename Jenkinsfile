node {
    def app

    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {
        app = docker.build("instantsearch")
    }

    stage('Push image') {
        docker.withRegistry('10.0.0.41:5000') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}
