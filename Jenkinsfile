node {

    stage ("Checkout React Client"){
        git branch: 'master', url: 'https://github.com/Lunatunny/Reactclient.git'
    }

    stage ("Install dependencies - REACT CLIENT") {
        sh 'npm install'
    }

    stage ("Containerize the app-docker build - REACT CLIENT") {
        sh 'docker build --rm -t jenkins-reactclient:v1.0 .'
    }

    stage ("Inspect the docker image - REACT CLIENT"){
        sh "docker images jenkins-reactclient:v1.0"
        sh "docker inspect jenkins-reactclient:v1.0"
    }

    stage ("Run Docker container instance - REACT CLIENT"){
        sh "docker run -d --rm --name reactclient -p 3000:80 jenkins-reactclient:v1.0"
    }

    stage('User Acceptance Test - react client') {
	  def response= input message: 'Is this build ready for kubernetes?',
	   parameters: [choice(choices: 'Yes\nNo', 
	   description: '', name: 'Pass')]

	  if(response=="Yes") {
	    stage('Deploy to Kubenetes cluster - react client') {
	      sh "kubectl create deployment reactclient --image=jenkins-reactclient:v1.0 --httpPort=80"
	      sh "kubectl expose deployment reactclient --type=LoadBalancer --port=80"
	      sh "kubectl scale deployment reactclient --replicas=3"
		}
	  }
    }

    stage("Production Deployment View"){
        sh "kubectl get deployments"
        sh "kubectl get pods"
        sh "kubectl get services"
    }
}
