properties([
    parameters ([
        string(name: 'BUILD_NODE', defaultValue: 'omar-build', description: 'The build node to run on'),
        string(name: 'REGISTRY_URL', defaultValue: 'nexus-docker-public-hosted.ossim.io', description: 'REGISTRY_URL to push to'),
        booleanParam(name: 'CLEAN_WORKSPACE', defaultValue: true, description: 'Clean the workspace at the end of the run')
    ]),
    pipelineTriggers([
            [$class: "GitHubPushTrigger"]
    ]),
    [$class: 'GithubProjectProperty', displayName: '', projectUrlStr: 'https://github.com/ossimlabs/ossim-alpine-minimal.git'],
    buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '3', daysToKeepStr: '', numToKeepStr: '20')),
    disableConcurrentBuilds()
])

timeout(time: 60, unit: 'MINUTES') {
    node("${BUILD_NODE}"){
        DOCKER_TAG="latest"
        if(BRANCH_NAME == "master") DOCKER_TAG="master"
        else if(BRANCH_NAME != "dev" ) DOCKER_TAG=BRANCH_NAME

        stage("Checkout branch $BRANCH_NAME")
        {
            checkout(scm)
        }

        stage("Load Variables")
        {
            withCredentials([string(credentialsId: 'o2-artifact-project', variable: 'o2ArtifactProject')]) {
                step ([$class: "CopyArtifact",
                    projectName: o2ArtifactProject,
                    filter: "common-variables.groovy",
                    flatten: true])
            }

            load "common-variables.groovy"
        }

        stage ("Checkout Source Code") 
        {                          
            dir("compile-ossim"){
                sh "./checkout-ossim.sh"
            }
        }  

        stage ("Build Ossim")
        {
            withDockerRegistry(credentialsId: 'dockerCredentials', url: '${DOCKER_REGISTRY_PRIVATE_URL}') {
                sh "./build.sh"
            }
        }

        stage ("Build Runtime Image")
        {
            withDockerRegistry(credentialsId: 'dockerCredentials', url: '${DOCKER_REGISTRY_PRIVATE_URL}') {
                dir("runtime"){
                    sh "./build-docker.sh"
                }
            }
        }

        stage ("Publish Docker Image")
        {
            withDockerRegistry(credentialsId: 'dockerCredentials', url: '${DOCKER_REGISTRY_PRIVATE_URL}') {
                sh """
                    docker tag ossim-runtime:alpine ${DOCKER_REGISTRY_PRIVATE_URL}/ossim-builder:alpine
                    docker push ${DOCKER_REGISTRY_PRIVATE_URL}/ossim-builder:alpine
                """
            }
        }

        stage("Clean Workspace")
        {
            if ("${CLEAN_WORKSPACE}" == "true")
                step([$class: 'WsCleanup'])
        }
    }
}
