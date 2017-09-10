node {    
    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {
        docker.build("instantsearch")
    }

    stage('Save image') {
        sh 'docker save instantsearch > instantsearch.tar'
    }

    stage ('Export image to swarm') {
        sh 'scp -i ~/awskey.pem instantsearch.tar core@10.0.0.41:~/'
    }

    stage ('Load image in swarm local registry') {
        sh 'ssh -i ~/awskey.pem core@10.0.0.41 "docker load < instantsearch.tar"'
        sh 'ssh -i ~/awskey.pem core@10.0.0.41 "docker tag instantsearch localhost:5000/instantsearch:${BUILD_NUMBER}"'
        sh 'ssh -i ~/awskey.pem core@10.0.0.41 "docker push localhost:5000/instantsearch:${BUILD_NUMBER}"'
    }

    stage ('Deploy image in swarm cluster') {
        sh 'ssh -i ~/awskey.pem core@10.0.0.41 "docker service inspect instantsearch && docker service update --image localhost:5000/instantsearch:${BUILD_NUMBER} instantsearch || docker service create --name instantsearch --label traefik.port=80 --label traefik.frontend.rule=PathPrefixStrip:/instantsearch/ --network traefik-net --replicas 3 --update-delay 10s localhost:5000/instantsearch:${BUILD_NUMBER}"'
    }


    stage ('Clean') {
        sh 'rm instantsearch.tar'
        sh 'ssh -i ~/awskey.pem core@10.0.0.41 "rm instantsearch.tar"' 
    }
}
