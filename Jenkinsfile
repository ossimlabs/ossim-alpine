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

    stage ("Build Dev Image") {
        withCredentials([[$class: 'UsernamePasswordMultiBinding',
                           credentialsId: 'dockerCredentials',
                           usernameVariable: 'DOCKER_REGISTRY_USERNAME',
                           passwordVariable: 'DOCKER_REGISTRY_PASSWORD']])               
        {                          
            if(DOCKER_REGISTRY_USERNAME&&DOCKER_REGISTRY_PASSWORD)
            {
                sh "docker login -u ${DOCKER_REGISTRY_USERNAME} -p ${DOCKER_REGISTRY_PASSWORD} ${REGISTRY_URL}"
            }            
            dir("${env.WORKSPACE}/dev"){
                sh "./build-docker.sh"
            }
        } 
    }

    stage ("Checkout Source Code") 
    {                          
        dir("${env.WORKSPACE}/dev"){
            sh "./checkout-src.sh"
        }
    }    

    stage ("Build CPP")
    {
        withCredentials([[$class: 'UsernamePasswordMultiBinding',
                           credentialsId: 'dockerCredentials',
                           usernameVariable: 'DOCKER_REGISTRY_USERNAME',
                           passwordVariable: 'DOCKER_REGISTRY_PASSWORD']])               
        {                          
            if(DOCKER_REGISTRY_USERNAME&&DOCKER_REGISTRY_PASSWORD)
            {
                sh "docker login -u ${DOCKER_REGISTRY_USERNAME} -p ${DOCKER_REGISTRY_PASSWORD} ${REGISTRY_URL}"
            }            
            dir("${env.WORKSPACE}/dev"){
                def foo = '/scripts/build-src.sh'
                sh "./run-docker.sh ${foo}"
            }
        }
    }

    stage ("Build Runtime Image")
    {
        withCredentials([string(credentialsId: 'o2-artifact-project', variable: 'o2ArtifactProject')]) {
            dir("${env.WORKSPACE}/runtime"){
                sh "./build-docker.sh"
            }
        }
    }


    stage ("Publish Docker Images")
    {
        withCredentials([[$class: 'UsernamePasswordMultiBinding',
                        credentialsId: 'dockerCredentials',
                        usernameVariable: 'DOCKER_REGISTRY_USERNAME',
                        passwordVariable: 'DOCKER_REGISTRY_PASSWORD']])
        {
            sh """
            docker tag ossim-dev-alpine-minimal:local ${REGISTRY_URL}/ossim-dev-alpine-minimal:${DOCKER_TAG}
            """

            sh """
            docker push ${REGISTRY_URL}/ossim-dev-alpine-minimal:${DOCKER_TAG}
            """

            sh """
            docker tag ossim-runtime-alpine-minimal:local ${REGISTRY_URL}/ossim-runtime-alpine-minimal:${DOCKER_TAG}
            """

            sh """
            docker push ${REGISTRY_URL}/ossim-runtime-alpine-minimal:${DOCKER_TAG}
            """
        }
    }
    
    // try {
    //     stage ("OpenShift Tag Image")
    //     {
    //         withCredentials([[$class: 'UsernamePasswordMultiBinding',
    //                         credentialsId: 'openshiftCredentials',
    //                         usernameVariable: 'OPENSHIFT_USERNAME',
    //                         passwordVariable: 'OPENSHIFT_PASSWORD']])
    //         {
    //             // Run all tasks on the app. This includes pushing to OpenShift and S3.
    //             sh """
    //                 ./gradlew openshiftTagImage \
    //                     -PossimMavenProxy=${OSSIM_MAVEN_PROXY}

    //             """
    //         }
    //     }
    // } catch (e) {
    //     echo e.toString()
    // }

    stage("Clean Workspace")
    {
        if ("${CLEAN_WORKSPACE}" == "true")
            step([$class: 'WsCleanup'])
    }
}
}
