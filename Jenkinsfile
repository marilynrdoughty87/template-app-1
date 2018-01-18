node {
    stage('build') {
        checkout scm
        sh './docker/build.sh'
        junit '**/build/test-results/**/*.xml'
    }
}
